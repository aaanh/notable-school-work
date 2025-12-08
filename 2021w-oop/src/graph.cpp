#include "graph.h"
#include "utils.h"
#include <queue>
#include <chrono>
#include <climits>

#ifdef ENABLE_LTTNG
#define TRACEPOINT_DEFINE
#include "graph_tracepoints.h"
#define TRACE(provider, event, ...) tracepoint(provider, event, __VA_ARGS__)
#else
#define TRACE(provider, event, ...) do {} while(0)
#endif

Graph::Graph() {}

Graph::~Graph() {}

bool Graph::addNode(Node &n) {
    bool flag;
    // check if node_count is valid and add
    if (this->node_count < MAX_NODE_COUNT) {
        node_list.push_back(&n);
        node_count++;
        flag = true;
    } else {
        cout << "Error adding node.\n";
        flag = false;
    }
    return flag;
}

bool Graph::addEdge(Edge &e) {
    // check edge needs a graph containing >= 2 nodes
    if (node_count < 2) {
        cout << "Not enough nodes.\n";
        return false;
    }

    // check for duplicate edges
    for (auto edge : edge_list) {
        if (*edge == e) {
            return false; // edge already exists
        }
    }

    // add new edge
    edge_list.push_back(&e);
    edge_count++;
    return true;
}

bool Graph::rmNode(int index) {
    if (index < 0 || index >= static_cast<int>(node_list.size())) {
        cout << "Node index out of bounds.\n";
        return false;
    }

    Node *nodeToRemove = node_list[index];

    // remove edges containing this node
    for (int i = edge_list.size() - 1; i >= 0; i--) {
        auto nodePair = edge_list[i]->getNodePair();
        if (nodePair[0] == nodeToRemove || nodePair[1] == nodeToRemove) {
            rmEdge(i);
        }
    }

    node_list.erase(node_list.begin() + index);
    node_count--;
    return true;
}

bool Graph::rmEdge(int index) {
    edge_list.erase(edge_list.begin() + index);
    edge_count--;
    return 1;
}

bool Graph::rmEdge(Node &n1, Node &n2) {
    for (int i = edge_list.size() - 1; i >= 0; i--) {
        auto pair = edge_list[i]->getNodePair();
        if ((pair[0] == &n1 && pair[1] == &n2) ||
            (pair[0] == &n2 && pair[1] == &n1)) {
            rmEdge(i);
            return true;
        }
    }
    return false;
}

unsigned long int Graph::searchNode(unsigned long node_id) {
    for (size_t i = 0; i < node_list.size(); i++) {
        if (node_list[i]->getNodeId() == node_id) {
            return i;
        }
    }
    return -1; // not found
}

Node Graph::getNode(unsigned long int index) { return *node_list[index]; }

unsigned long int Graph::getNodeCount() { return node_count; }

unsigned long int Graph::getEdgeCount() { return edge_count; }

bool Graph::setNumOfEntries(unsigned long entries) {
    this->num_of_entries = entries;
    return 1;
}

unsigned long Graph::getNumOfEntries() { return num_of_entries; }

vector<Node *> Graph::getNodeList() { return this->node_list; }

vector<Edge *> Graph::getEdgeList() { return this->edge_list; }

void Graph::display() {
    if (node_list.empty()) {
        cout << "No nodes to display.\n";
        return;
    }

    unsigned long begin, end;
    unsigned long counter = 0;
    vector<string> checked;

    cout << "\n=== GRAPH DISPLAY MODULE ===\n";
    cout << "Available range: 0 - " << (node_list.size() - 1) << "\n";
    cout << "Enter begin index: ";
    cin >> begin;
    cout << "Enter end index: ";
    cin >> end;

    // Validate input
    if (begin >= node_list.size() || end >= node_list.size() || begin > end) {
        cout << "Invalid range. Using available data range.\n";
        begin = 0;
        end = min(static_cast<unsigned long>(node_list.size() - 1), 10UL);
    }

    cout << "\nDisplaying nodes " << begin << " to " << end << ":\n";
    cout << "====================================\n";

    for (size_t i = begin; i <= end && i < node_list.size(); i++) {
        checked.clear();
        cout << "[" << i << "] (" << node_list[i]->getCountryCode() << ") "
             << node_list[i]->getName();
        checked.push_back(node_list[i]->getName());

        // Show connected nodes
        for (auto e : edge_list) {
            auto pair = e->getNodePair();
            if (pair[0] == node_list[i] &&
                find(checked.begin(), checked.end(), pair[1]->getName()) ==
                    checked.end()) {
                cout << " -- " << pair[1]->getName();
                checked.push_back(pair[1]->getName());
                counter++;
            } else if (pair[1] == node_list[i] &&
                       find(checked.begin(), checked.end(),
                            pair[0]->getName()) == checked.end()) {
                cout << " -- " << pair[0]->getName();
                checked.push_back(pair[0]->getName());
                counter++;
            }

            if (counter >= 3) {
                cout << "\n    ";
                counter = 0;
            }
        }
        cout << "\n";

        if ((i - begin + 1) % 5 == 0) {
            pauseSystem();
        }
    }

    cout << "====================================\n";
}

void Graph::traverse(unsigned long startIndex, TraversalAlgo algo) {
    if (startIndex >= node_list.size()) {
        cout << "Invalid start index.\n";
        return;
    }
    
    cout << "\n=== GRAPH TRAVERSAL CONFIG ===\n";
    cout << "Available algorithms: 0=DFS, 1=BFS\n";
    cout << "Current selection: " << (algo == DFS ? "DFS" : "BFS") << "\n";
    cout << "Starting node: [" << startIndex << "] " << node_list[startIndex]->getName() << "\n";
    cout << "==============================\n";
    
    if (algo == DFS) {
        dfsTraversal(startIndex);
    } else {
        bfsTraversal(startIndex);
    }
}

void Graph::dfsTraversal(unsigned long startIndex) {
    TRACE(graph_provider, traversal_start, "DFS", startIndex, node_list.size());
    
    auto start = chrono::high_resolution_clock::now();
    
    vector<bool> visited(node_list.size(), false);
    cout << "\n=== DFS TRAVERSAL ===\n";
    cout << "Path: ";
    
    int nodesVisited = 0;
    dfsHelper(node_list[startIndex], visited, node_list);
    
    // Count visited nodes
    for (bool v : visited) if (v) nodesVisited++;
    
    auto end = chrono::high_resolution_clock::now();
    auto duration = chrono::duration_cast<chrono::microseconds>(end - start);
    double durationMs = duration.count() / 1000.0;
    
    TRACE(graph_provider, traversal_end, "DFS", durationMs, nodesVisited);
    
    cout << "\n";
    printPerformanceStats("DFS", durationMs, nodesVisited);
}

void Graph::bfsTraversal(unsigned long startIndex) {
    TRACE(graph_provider, traversal_start, "BFS", startIndex, node_list.size());
    
    auto start = chrono::high_resolution_clock::now();
    
    vector<bool> visited(node_list.size(), false);
    queue<Node*> q;
    int nodesVisited = 0;
    
    cout << "\n=== BFS TRAVERSAL ===\n";
    cout << "Path: ";
    
    q.push(node_list[startIndex]);
    visited[startIndex] = true;
    
    while (!q.empty()) {
        Node* current = q.front();
        q.pop();
        nodesVisited++;
        
        TRACE(graph_provider, node_visit, current->getName().c_str(), current->getNodeId());
        cout << current->getName() << " -> ";
        
        vector<Node*> adjacent = getAdjacent(current);
        for (Node* adj : adjacent) {
            int adjIndex = -1;
            for (size_t i = 0; i < node_list.size(); i++) {
                if (node_list[i] == adj) {
                    adjIndex = i;
                    break;
                }
            }
            
            if (adjIndex != -1 && !visited[adjIndex]) {
                visited[adjIndex] = true;
                q.push(adj);
            }
        }
    }
    
    auto end = chrono::high_resolution_clock::now();
    auto duration = chrono::duration_cast<chrono::microseconds>(end - start);
    double durationMs = duration.count() / 1000.0;
    
    TRACE(graph_provider, traversal_end, "BFS", durationMs, nodesVisited);
    
    cout << "\n";
    printPerformanceStats("BFS", durationMs, nodesVisited);
}

void Graph::dfsHelper(Node* node, vector<bool>& visited, vector<Node*>& nodeList) {
    int nodeIndex = -1;
    for (size_t i = 0; i < nodeList.size(); i++) {
        if (nodeList[i] == node) {
            nodeIndex = i;
            break;
        }
    }
    
    if (nodeIndex == -1 || visited[nodeIndex]) return;
    
    visited[nodeIndex] = true;
    TRACE(graph_provider, node_visit, node->getName().c_str(), node->getNodeId());
    cout << node->getName() << " -> ";
    
    vector<Node*> adjacent = getAdjacent(node);
    for (Node* adj : adjacent) {
        dfsHelper(adj, visited, nodeList);
    }
}

void Graph::printPerformanceStats(const string& algoName, double timeMs, int nodesVisited) {
    cout << "\n=== PERFORMANCE STATS ===\n";
    cout << "Algorithm: " << algoName << "\n";
    cout << "Execution time: " << fixed << setprecision(3) << timeMs << " ms\n";
    cout << "Nodes visited: " << nodesVisited << "/" << node_list.size() << "\n";
    cout << "Coverage: " << fixed << setprecision(1) << (100.0 * nodesVisited / node_list.size()) << "%\n";
    cout << "========================\n";
}

vector<Node*> Graph::getAdjacent(Node* node) {
    vector<Node*> adjacent;
    for (auto edge : edge_list) {
        auto pair = edge->getNodePair();
        if (pair[0] == node) {
            adjacent.push_back(pair[1]);
        } else if (pair[1] == node) {
            adjacent.push_back(pair[0]);
        }
    }
    return adjacent;
}

void Graph::findPath(unsigned long startIndex, unsigned long endIndex) {
    if (startIndex >= node_list.size() || endIndex >= node_list.size()) {
        cout << "Invalid node indices.\n";
        return;
    }
    
    if (startIndex == endIndex) {
        cout << "Start and end nodes are the same.\n";
        return;
    }
    
    cout << "\n=== PATH FINDING ===\n";
    cout << "From: [" << startIndex << "] " << node_list[startIndex]->getName() << "\n";
    cout << "To: [" << endIndex << "] " << node_list[endIndex]->getName() << "\n";
    
    vector<bool> visited(node_list.size(), false);
    vector<int> parent(node_list.size(), -1);
    queue<int> q;
    
    q.push(startIndex);
    visited[startIndex] = true;
    
    cout << "Building path...\n";
    int nodesExplored = 0;
    
    bool found = false;
    while (!q.empty() && !found) {
        int current = q.front();
        q.pop();
        nodesExplored++;
        
        cout << "\rExploring: " << node_list[current]->getName() << " [" << nodesExplored << " nodes]";
        cout.flush();
        
        if (current == static_cast<int>(endIndex)) {
            found = true;
            break;
        }
        
        vector<Node*> adjacent = getAdjacent(node_list[current]);
        for (Node* adj : adjacent) {
            int adjIndex = -1;
            for (size_t i = 0; i < node_list.size(); i++) {
                if (node_list[i] == adj) {
                    adjIndex = i;
                    break;
                }
            }
            
            if (adjIndex != -1 && !visited[adjIndex]) {
                visited[adjIndex] = true;
                parent[adjIndex] = current;
                q.push(adjIndex);
            }
        }
    }
    cout << "\n";
    
    if (found) {
        cout << "\nPath found: ";
        vector<int> path;
        int current = endIndex;
        while (current != -1) {
            path.push_back(current);
            current = parent[current];
        }
        
        reverse(path.begin(), path.end());
        for (size_t i = 0; i < path.size(); i++) {
            cout << node_list[path[i]]->getName();
            if (i < path.size() - 1) cout << " -> ";
        }
        cout << "\nPath length: " << path.size() - 1 << " edges\n";
    } else {
        cout << "\nNo path found between these nodes.\n";
    }
    cout << "==================\n";
}

void Graph::dijkstraPath(unsigned long startIndex, unsigned long endIndex) {
    if (startIndex >= node_list.size() || endIndex >= node_list.size()) {
        cout << "Invalid node indices.\n";
        return;
    }
    
    cout << "\n=== DIJKSTRA PATH FINDING ===\n";
    cout << "From: [" << startIndex << "] " << node_list[startIndex]->getName() << "\n";
    cout << "To: [" << endIndex << "] " << node_list[endIndex]->getName() << "\n";
    
    vector<int> dist(node_list.size(), INT_MAX);
    vector<int> parent(node_list.size(), -1);
    vector<bool> visited(node_list.size(), false);
    
    dist[startIndex] = 0;
    
    cout << "Building weighted path...\n";
    
    for (size_t count = 0; count < node_list.size() - 1; count++) {
        int u = -1;
        for (size_t v = 0; v < node_list.size(); v++) {
            if (!visited[v] && (u == -1 || dist[v] < dist[u])) {
                u = v;
            }
        }
        
        if (dist[u] == INT_MAX) break;
        visited[u] = true;
        
        cout << "\rProcessing: " << node_list[u]->getName() << " (cost: " << dist[u] << ")";
        cout.flush();
        
        if (u == static_cast<int>(endIndex)) break;
        
        vector<Node*> adjacent = getAdjacent(node_list[u]);
        for (Node* adj : adjacent) {
            int v = -1;
            for (size_t i = 0; i < node_list.size(); i++) {
                if (node_list[i] == adj) {
                    v = i;
                    break;
                }
            }
            
            if (v != -1 && !visited[v]) {
                int weight = getEdgeWeight(node_list[u], node_list[v]);
                if (dist[u] + weight < dist[v]) {
                    dist[v] = dist[u] + weight;
                    parent[v] = u;
                }
            }
        }
    }
    cout << "\n";
    
    if (dist[endIndex] == INT_MAX) {
        cout << "\nNo path found.\n";
    } else {
        cout << "\nShortest weighted path found (cost: " << dist[endIndex] << "): ";
        vector<int> path;
        int current = endIndex;
        while (current != -1) {
            path.push_back(current);
            current = parent[current];
        }
        
        reverse(path.begin(), path.end());
        for (size_t i = 0; i < path.size(); i++) {
            cout << node_list[path[i]]->getName();
            if (i < path.size() - 1) cout << " -> ";
        }
        cout << "\n";
    }
    cout << "============================\n";
}

int Graph::getEdgeWeight(Node* n1, Node* n2) {
    // Heuristic weights based on business relationship strength
    if (n1->getCountryCode() == n2->getCountryCode()) {
        return 1; // Same country = strong connection
    }
    
    // Different countries but same jurisdiction
    if (n1->getJurisdiction() == n2->getJurisdiction()) {
        return 3;
    }
    
    // Default weight for any connection
    return 5;
}

bool Graph::clean() { return 1; }
