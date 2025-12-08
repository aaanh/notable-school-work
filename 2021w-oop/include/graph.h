#ifndef GRAPH_H
#define GRAPH_H

#define MAX_NODE_COUNT 100000000

#include <vector>
#include <string>
#include <algorithm>
#include <fstream>
#include <iostream>
#include <iomanip>

#include "node.h"
#include "edge.h"
#include "graph_base.h"


using namespace std;

class Graph : public GraphBase
{
    public:
        Graph();
        virtual ~Graph();

        // entity ops

        bool addNode(Node&); // done
        bool addEdge(Edge&); // done

        bool rmNode(int index); // done
        bool rmEdge(int index); // done
        bool rmEdge(Node&, Node&); // done

        unsigned long int searchNode(unsigned long node_id); // done
        Node getNode(unsigned long int); // done

        unsigned long int getNodeCount(); // done
        unsigned long int getEdgeCount(); // done

        // data ops
        // bool readDatabase(string path); // done
        // bool addDatabase(); // done
        bool setNumOfEntries(unsigned long); // done
        unsigned long getNumOfEntries(); // done

        // list ops
        vector<Node*> getNodeList(); // done
        vector<Edge*> getEdgeList(); // done

        // graph ops
        enum TraversalAlgo { DFS, BFS };
        void display();
        void traverse(unsigned long startIndex, TraversalAlgo algo = DFS);
        void dfsTraversal(unsigned long startIndex);
        void bfsTraversal(unsigned long startIndex);
        void findPath(unsigned long startIndex, unsigned long endIndex);
        void dijkstraPath(unsigned long startIndex, unsigned long endIndex);
        bool clean();
        
    private:
        int getEdgeWeight(Node* n1, Node* n2);
        
    private:
        void dfsHelper(Node* node, vector<bool>& visited, vector<Node*>& nodeList);
        vector<Node*> getAdjacent(Node* node);
        void printPerformanceStats(const string& algoName, double timeMs, int nodesVisited);

    private:
        vector<Node*> node_list;
        vector<Edge*> edge_list;
        unsigned long node_count = 0;
        unsigned long edge_count = 0;
        unsigned long num_of_entries = 0;
};

#endif