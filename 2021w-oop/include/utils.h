#ifndef UTILS_H
#define UTILS_H

#include <string>
#include <filesystem>
#include <iostream>
#include <fstream>
#include <sstream>
#include <iomanip>
#include <algorithm>

#include "graph.h"
#include "node.h"
#include "edge.h"

namespace fs = std::filesystem;

// get platform name
std::string getOsName();

// patches data path with respect to host platform
std::string patchDataPath();

// index data file directory
void indexDirectory(std::string path);

// open files
void openFiles(std::string, std::ifstream&);

// print data 
void printDatabase(std::ifstream&);

// data parser
void dataParser(Graph &graph, std::ifstream &data);

// cross-platform pause function
void pauseSystem();

#endif