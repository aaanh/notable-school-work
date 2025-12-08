const express = require("express");
const WebSocket = require("ws");
const path = require("path");
const cors = require("cors");

class SVGViewerServer {
  constructor() {
    this.app = express();
    this.port = process.env.PORT || 3000;
    this.wsPort = process.env.WS_PORT || 8787;
    this.currentState = {
      xOffset: 0,
      yOffset: 0,
      scale: 1,
    };
    this.viewers = new Set();

    this.setupMiddleware();
    this.setupRoutes();
    this.setupWebSocket();
  }

  setupMiddleware() {
    // Enable CORS for all origins in development
    this.app.use(cors());
    
    // Serve static files
    this.app.use(express.static(path.join(__dirname)));
    this.app.use(express.json());
  }

  setupRoutes() {
    // API endpoint to update state
    this.app.post('/update-state', async (req, res) => {
      try {
        this.currentState = req.body;
        this.broadcastState();
        res.json({ success: true, viewerCount: this.viewers.size });
      } catch (error) {
        console.error('Error updating state:', error);
        res.status(500).json({ error: 'Internal server error' });
      }
    });
  }

  setupWebSocket() {
    const wss = new WebSocket.Server({ port: this.wsPort });
    console.log(`WebSocket server running on port ${this.wsPort}`);

    wss.on('connection', (ws) => {
      console.log('New viewer connected');
      this.viewers.add(ws);

      // Send current state to new viewer
      ws.send(JSON.stringify({
        type: 'state-update',
        state: this.currentState
      }));

      ws.on('close', () => {
        console.log('Viewer disconnected');
        this.viewers.delete(ws);
      });

      ws.on('error', (error) => {
        console.error('WebSocket error:', error);
        this.viewers.delete(ws);
      });
    });
  }

  broadcastState() {
    const message = JSON.stringify({
      type: 'state-update',
      state: this.currentState
    });

    let activeViewers = 0;
    this.viewers.forEach((viewer) => {
      try {
        if (viewer.readyState === WebSocket.OPEN) {
          viewer.send(message);
          activeViewers++;
        }
      } catch (error) {
        console.error('Error sending to viewer:', error);
        this.viewers.delete(viewer);
      }
    });

    console.log(`State broadcast to ${activeViewers} viewers`);
  }

  start() {
    this.app.listen(this.port, () => {
      console.log(`HTTP server running on port ${this.port}`);
      console.log(`WebSocket server running on port ${this.wsPort}`);
    });
  }
}

// Start the server
const server = new SVGViewerServer();
server.start();
