#include "main.h"

int main() {
    Graph graph = TestDataUtils();
    
    int choice;
    do {
        cout << "\n=== MAIN MENU ===\n";
        cout << "1 - Test IO Operations\n";
        cout << "2 - Graph Traversal\n";
        cout << "3 - Display Graph\n";
        cout << "0 - Exit\n";
        cout << "Choice: ";
        cin >> choice;
        
        switch(choice) {
            case 1:
                TestIO(graph);
                break;
            case 2:
                TestGraphTraversal(graph);
                break;
            case 3:
                graph.display();
                break;
            case 0:
                cout << "Goodbye!\n";
                break;
            default:
                cout << "Invalid choice!\n";
        }
    } while(choice != 0);
    
    return 0;
}

Graph TestDataUtils() {
    cout << "\n=== DATA INITIALIZATION ===\n";
    string path = patchDataPath();
    cout << "Data path: " << path << "\n";
    indexDirectory(path);

    cout << "Initializing graph objects...\n";
    ifstream data;
    Graph graph;

    openFiles(path, data);
    if (data.is_open()) {
        dataParser(graph, data);
        data.close();
    } else {
        cout << "Failed to open data file!\n";
    }

    return graph;
}

void TestIO(Graph graph) {
    auto node_list = graph.getNodeList();
    auto edge_list = graph.getEdgeList();

    cout << "\n=== TESTING NODE ACCESSORS ===\n";
    if (!node_list.empty()) {
        cout << "Column headers:\n";
        node_list[0]->printAttributes();
        cout << "\nFirst 5 nodes:\n";
        for (size_t i = 0; i < min(node_list.size(), 5UL); i++) {
            cout << "[" << i << "] ";
            node_list[i]->print();
        }
    } else {
        cout << "No nodes found!\n";
    }
    pauseSystem();

    cout << "\n=== TESTING EDGE ACCESSORS ===\n";
    cout << "Node1_ID\tNode2_ID\tCountry1\tCountry2\n";
    cout << "----------------------------------------\n";
    
    int edge_counter = 0;
    int max_edges = min(static_cast<int>(edge_list.size()), 20);
    
    for (auto e : edge_list) {
        if (edge_counter >= max_edges) break;
        
        auto pair = e->getNodePair();
        cout << pair[0]->getNodeId() << "\t\t" 
             << pair[1]->getNodeId() << "\t\t"
             << pair[0]->getCountryCode() << "\t" 
             << pair[1]->getCountryCode() << "\n";
        edge_counter++;
    }
    
    if (edge_list.size() > 20) {
        cout << "... (showing first 20 of " << edge_list.size() << " edges)\n";
    }
    pauseSystem();

    cout << "\n=== TESTING GRAPH ACCESSORS ===\n";
    try {
        cout << "Node count: " << graph.getNodeCount() << "\n";
        cout << "Edge count: " << graph.getEdgeCount() << "\n";
        cout << "Total entries: " << graph.getNumOfEntries() << "\n";
        
        if (graph.getNodeCount() > 0) {
            cout << "Testing getNode(0): " << graph.getNode(0).getName() << "\n";
        }
        
        cout << "All accessor methods passed!\n";
    } catch (...) {
        cout << "Error: One or more graph accessors failed!\n";
    }
    pauseSystem();
}

void TestGraphTraversal(Graph graph) {
    if (graph.getNodeCount() == 0) {
        cout << "No nodes available for traversal.\n";
        return;
    }
    
    cout << "\n=== GRAPH TRAVERSAL TEST ===\n";
    cout << "Select operation:\n";
    cout << "0 - DFS Traversal (from start node)\n";
    cout << "1 - BFS Traversal (from start node)\n";
    cout << "2 - Find Path - BFS (unweighted shortest)\n";
    cout << "3 - Find Path - Dijkstra (weighted shortest)\n";
    cout << "Choice: ";
    
    int choice;
    cin >> choice;
    
    if (choice == 2 || choice == 3) {
        cout << "Enter start node index (0-" << (graph.getNodeCount()-1) << "): ";
        unsigned long startIndex;
        cin >> startIndex;
        cout << "Enter end node index (0-" << (graph.getNodeCount()-1) << "): ";
        unsigned long endIndex;
        cin >> endIndex;
        
        if (startIndex >= graph.getNodeCount()) startIndex = 0;
        if (endIndex >= graph.getNodeCount()) endIndex = 1;
        
        if (choice == 2) {
            graph.findPath(startIndex, endIndex);
        } else {
            graph.dijkstraPath(startIndex, endIndex);
        }
    } else {
        cout << "Enter start node index (0-" << (graph.getNodeCount()-1) << "): ";
        unsigned long startIndex;
        cin >> startIndex;
        
        if (startIndex >= graph.getNodeCount()) {
            cout << "Invalid start index. Using 0.\n";
            startIndex = 0;
        }
        
        Graph::TraversalAlgo algo = (choice == 1) ? Graph::BFS : Graph::DFS;
        graph.traverse(startIndex, algo);
    }
}