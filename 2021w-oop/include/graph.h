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

class Graph : public GraphBase
{
    public:
        Graph();
        ~Graph() override;

        Graph(const Graph&) = delete;
        Graph& operator=(const Graph&) = delete;
        Graph(Graph&&) noexcept = default;
        Graph& operator=(Graph&&) noexcept = default;

        // entity ops

        bool addNode(Node&) override;
        bool addEdge(Edge&) override;

        bool rmNode(int index) override;
        bool rmEdge(int index) override;
        bool rmEdge(Node&, Node&) override;

        unsigned long int searchNode(unsigned long node_id) override;
        Node getNode(unsigned long int) override;

        unsigned long int getNodeCount() override;
        unsigned long int getEdgeCount() override;

        // data ops
        bool setNumOfEntries(unsigned long) override;
        unsigned long getNumOfEntries() override;

        // list ops
        const std::vector<Node*>& getNodeList() const override;
        const std::vector<Edge*>& getEdgeList() const override;

        // graph ops
        enum TraversalAlgo { DFS, BFS };
        void display() override;
        bool exportDot(unsigned long begin, unsigned long end, const std::string& path);
        void traverse(unsigned long startIndex, TraversalAlgo algo = DFS);
        void dfsTraversal(unsigned long startIndex);
        void bfsTraversal(unsigned long startIndex);
        void findPath(unsigned long startIndex, unsigned long endIndex);
        void dijkstraPath(unsigned long startIndex, unsigned long endIndex);
        bool clean() override;
        
    private:
        int getEdgeWeight(Node* n1, Node* n2);
        size_t nodeIndex(Node* node) const;

    private:
        void dfsHelper(Node* node, std::vector<bool>& visited);
        std::vector<Node*> getAdjacent(Node* node);
        void printPerformanceStats(const std::string& algoName, double timeMs, int nodesVisited);

    private:
        std::vector<Node*> node_list;
        std::vector<Edge*> edge_list;
        unsigned long node_count = 0;
        unsigned long edge_count = 0;
        unsigned long num_of_entries = 0;
};

#endif