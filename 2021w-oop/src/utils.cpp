#include "utils.h"

#include <chrono>
#include <cstdlib>
#include <filesystem>
#include <string>
#include <thread>

std::string getOsName() {
#ifdef _WIN32
    return "Windows 32-bit";
#elif _WIN64
    return "Windows 64-bit";
#elif (__APPLE__ || __MACH__)
    return "macOS";
#elif __linux__
    return "Linux";
#elif __FreeBSD__
    return "FreeBSD";
#elif __unix || __unix__
    return "Unix";
#else
    return "Other";
#endif
}

std::string patchDataPath() {
    return (fs::current_path() / "data" / "cleaned").string();
}

void indexDirectory(std::string path) {
    int file_count = 0;
    std::cout << "Data files found:\n";
    for (const auto &entry : fs::directory_iterator(path)) {
        std::cout << " > " << entry.path().filename() << "\n";
        file_count++;
    }
    std::cout << "Total files: " << file_count << "\n\n";
}

void openFiles(std::string path, std::ifstream &data) {
    const fs::path entityFile = fs::path(path) / "entity.csv";
    data.open(entityFile);
    std::cout << entityFile.string() << "\n";

    if (!(data.is_open())) {
        std::cout << "Failed to open database. Check path.\n";
    } else {
        std::cout << "Database opened successfully.\n";
    }
}

void printDatabase(std::ifstream &data) {
    std::string line;
    std::string temp_id, n, j, jd, cc, c;
    unsigned long int id;
    int line_count = 0;
    while (std::getline(data, line)) {
        if (line_count != 0) {
            // get the csv data
            std::stringstream ss(line);
            getline(ss, temp_id, ',');
            getline(ss, n, ',');
            getline(ss, j, ',');
            getline(ss, jd, ',');
            getline(ss, cc, ',');
            getline(ss, c, ',');

            // type conversion
            id = stod(temp_id);

            // print data
            std::cout << "> Entry ID       : " << id << "\n";
            std::cout << ">> Name          : " << n << "\n";
            std::cout << ">> Jurisdiction  : " << j << "\n";
            std::cout << ">> J. Description: " << jd << "\n";
            std::cout << ">> Country code  : " << cc << "\n";
            std::cout << ">> Country       : " << c << "\n";

            std::cout << "\n-------------------\n\n";
        }
        line_count++;
    }
}

void dataParser(Graph &graph, std::ifstream &data) {
    std::string line;
    std::string temp_id, name, j, jd, cc, c;
    unsigned long id;
    int line_count = 0;
    clock_t start, end;
    start = clock();
    while (std::getline(data, line)) {
        if (line_count != 0) {
            // get the csv data
            std::stringstream ss(line);
            getline(ss, temp_id, ',');
            getline(ss, name, ',');
            getline(ss, j, ',');
            getline(ss, jd, ',');
            getline(ss, cc, ',');
            getline(ss, c, ',');
            // type conversion
            id = stoi(temp_id);

            Node *n = new Node(id, name, j, jd, cc, c);

            graph.addNode(*n);

            // Create edges only with the previous node of same country (chain approach)
            const auto& nodeList = graph.getNodeList();
            for (int i = static_cast<int>(nodeList.size()) - 2; i >= 0; i--) {
                if (n->getCountryCode() == nodeList[i]->getCountryCode() && 
                    n->getNodeId() != nodeList[i]->getNodeId()) {
                    Edge *e = new Edge(*n, *nodeList[i]);
                    graph.addEdge(*e);
                    break; // only connect to most recent node with same country
                }
            }
        }
        line_count++;
        if (line_count % 100 == 0) {
            std::cout << "\rProcessed: " << line_count << " entries";
            std::cout.flush();
        }
        graph.setNumOfEntries(line_count - 1);
    }
    end = clock();
    double time_taken = double(end - start) / double(CLOCKS_PER_SEC);
    std::cout << "\n\n=== PARSING COMPLETE ===\n";
    std::cout << "Parse time: " << std::fixed << std::setprecision(3) << time_taken << " seconds\n";
    std::cout << "Total entries: " << line_count - 1 << "\n";
    std::cout << "Nodes: " << graph.getNodeCount() << "\n";
    std::cout << "Edges: " << graph.getEdgeCount() << "\n";
    std::cout << "========================\n\n";
}

void pauseSystem() {
    if (getOsName().find("Windows") != std::string::npos) {
        std::system("pause");
    } else {
        std::this_thread::sleep_for(std::chrono::milliseconds(1000));
    }
}