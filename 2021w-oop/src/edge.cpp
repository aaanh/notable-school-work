#include "edge.h"

#include <string>

Edge::Edge() 
{
    
}

Edge::Edge(Node& n1, Node& n2) 
{
    addNodePair(n1, n2);
}

Edge::~Edge() 
{
    
}

bool Edge::addNodePair(Node& n1, Node& n2) 
{
    node_pair.push_back(&n1);
    node_pair.push_back(&n2);
    return 1;
}

const std::vector<Node*>& Edge::getNodePair() const {
    return node_pair;
}

bool operator==(const Edge& lhs, const Edge& rhs) {
    const auto& lp = lhs.getNodePair();
    const auto& rp = rhs.getNodePair();
    if (lp.size() < 2 || rp.size() < 2) {
        return false;
    }
    const std::string& a = lp[0]->getName();
    const std::string& b = lp[1]->getName();
    const std::string& c = rp[0]->getName();
    const std::string& d = rp[1]->getName();
    return (a == c && b == d) || (a == d && b == c);
}
