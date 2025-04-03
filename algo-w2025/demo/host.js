class SVGViewer {
  constructor() {
    this.svgWrapper = document.getElementById('svg-wrapper');
    this.isDragging = false;
    this.currentX = 0;
    this.currentY = 0;
    this.initialX = 0;
    this.initialY = 0;
    this.xOffset = 0;
    this.yOffset = 0;
    this.scale = 1;
    this.updateTimeout = null;
    this.lastUpdateTime = 0;
    this.updateInterval = 50; // Minimum time between updates in ms

    // Use the current domain for API calls
    this.serverUrl = window.location.protocol + '//' + window.location.host;

    console.log('Host initialized with server URL:', this.serverUrl);
    this.init();
  }

  async init() {
    await this.loadSVG();
    this.setupEventListeners();
    this.setupControls();
  }

  async loadSVG() {
    try {
      const response = await fetch('uml-diagram.svg');
      const svgContent = await response.text();
      this.svgWrapper.innerHTML = svgContent;
      const svg = this.svgWrapper.querySelector('svg');
      if (svg) {
        svg.style.width = '100%';
        svg.style.height = '100%';
      }
    } catch (error) {
      console.error('Error loading SVG:', error);
    }
  }

  updateTransform() {
    this.svgWrapper.style.transform = `translate(${this.xOffset}px, ${this.yOffset}px) scale(${this.scale})`;
    this.debouncedUpdateState();
  }

  debouncedUpdateState() {
    const now = Date.now();
    if (now - this.lastUpdateTime >= this.updateInterval) {
      this.updateState();
      this.lastUpdateTime = now;
    } else {
      // Clear any pending update
      if (this.updateTimeout) {
        clearTimeout(this.updateTimeout);
      }
      // Schedule a new update
      this.updateTimeout = setTimeout(() => {
        this.updateState();
        this.lastUpdateTime = Date.now();
      }, this.updateInterval);
    }
  }

  async updateState() {
    const state = {
      xOffset: this.xOffset,
      yOffset: this.yOffset,
      scale: this.scale
    };

    console.log('Sending state update:', state);

    try {
      const response = await fetch(`${this.serverUrl}/update-state`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(state)
      });

      if (!response.ok) {
        const errorText = await response.text();
        console.error('Failed to update state:', errorText);
      } else {
        const result = await response.json();
        console.log('State update successful:', result);
      }
    } catch (error) {
      console.error('Error updating state:', error);
    }
  }

  dragStart(e) {
    e.preventDefault();
    if (e.type === "touchstart") {
      this.initialX = e.touches[0].clientX - this.xOffset;
      this.initialY = e.touches[0].clientY - this.yOffset;
    } else {
      this.initialX = e.clientX - this.xOffset;
      this.initialY = e.clientY - this.yOffset;
    }
    this.isDragging = true;
    this.svgWrapper.classList.add('dragging');
  }

  dragEnd(e) {
    e.preventDefault();
    this.initialX = this.currentX;
    this.initialY = this.currentY;
    this.isDragging = false;
    this.svgWrapper.classList.remove('dragging');
  }

  drag(e) {
    if (this.isDragging) {
      e.preventDefault();

      if (e.type === "touchmove") {
        this.currentX = e.touches[0].clientX - this.initialX;
        this.currentY = e.touches[0].clientY - this.initialY;
      } else {
        this.currentX = e.clientX - this.initialX;
        this.currentY = e.clientY - this.initialY;
      }

      this.xOffset = this.currentX;
      this.yOffset = this.currentY;

      this.updateTransform();
    }
  }

  setupEventListeners() {
    this.svgWrapper.addEventListener('mousedown', this.dragStart.bind(this), { passive: false });
    document.addEventListener('mousemove', this.drag.bind(this), { passive: false });
    document.addEventListener('mouseup', this.dragEnd.bind(this), { passive: false });
    this.svgWrapper.addEventListener('touchstart', this.dragStart.bind(this), { passive: false });
    document.addEventListener('touchmove', this.drag.bind(this), { passive: false });
    document.addEventListener('touchend', this.dragEnd.bind(this), { passive: false });

    document.addEventListener('wheel', this.handleWheel.bind(this), { passive: false });
  }

  setupControls() {
    document.getElementById('zoomIn').addEventListener('click', () => this.handleZoom(1.2));
    document.getElementById('zoomOut').addEventListener('click', () => this.handleZoom(0.8));
    document.getElementById('reset').addEventListener('click', () => this.handleReset());
  }

  handleZoom(factor) {
    const oldScale = this.scale;
    const newScale = Math.min(Math.max(this.scale * factor, 0.1), 5);
    
    if (newScale !== oldScale) {
      const rect = this.svgWrapper.getBoundingClientRect();
      const centerX = rect.left + (rect.width / 2);
      const centerY = rect.top + (rect.height / 2);
      const x = (centerX - rect.left) / oldScale;
      const y = (centerY - rect.top) / oldScale;
      this.scale = newScale;
      this.xOffset = centerX - (x * newScale);
      this.yOffset = centerY - (y * newScale);
      this.updateTransform();
    }
  }

  handleWheel(e) {
    e.preventDefault();
    const zoomSensitivity = 0.1;
    const delta = -Math.sign(e.deltaY) * zoomSensitivity;
    const oldScale = this.scale;
    const newScale = this.scale * (1 + delta);

    if (newScale >= 0.1 && newScale <= 5) {
      const mouseX = e.pageX;
      const mouseY = e.pageY;
      const rect = this.svgWrapper.getBoundingClientRect();
      const x = (mouseX - rect.left) / oldScale;
      const y = (mouseY - rect.top) / oldScale;
      this.scale = newScale;
      this.xOffset = mouseX - (x * newScale);
      this.yOffset = mouseY - (y * newScale);
      this.updateTransform();
    }
  }

  handleReset() {
    this.xOffset = 0;
    this.yOffset = 0;
    this.scale = 1;
    this.updateTransform();
  }
}

// Initialize the viewer when the DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
  new SVGViewer();
}); 