# COEN 244 Project

## Project Description

This project parses the Panama Papers dataset (./data) into an in-memory graph structure to query connections between any 2 nodes.

The idea is to improve the investigative process for journalists, connecting the dots between entities related to the tax evasion case.

Dataset is initially cleaned using Python Pandas (./data/cleaner.ipynb) to produce a cleaned entity dataset (./data/cleaned/entity.csv).

### Author:

\> Nguyen Hoang Anh

### License:

\> MIT License. Originally (CC BY-NC-ND 4.0).

### Requirements:

-   gcc/c++ | std >= c++17
-   Windows (amd64): MinGW gcc | >=9.2.0 this includes the required `filesystem.h`; gnuWin make | v3.81; MinGW Unix command line tools
-   Apple (amd64, arm64): Xcode command line tools
-   Ubuntu (amd64): `sudo apt update && sudo apt install -y build-essential`

### Usage:

-   CHANGEDIR `cd` into the decompressed project submission folder
-   COMPILE `make all`
-   Executable binary should be in `/output` folder
-   RUN by `./output/main` \*Note: \*nix platforms' executable should have no extension or `.o` as extension when compiled. Windows x86 should have `main.exe` when compiled.


### Docker:

- Quick and easy

```
docker build . -t aaanh/meaningful-graph-traversal:latest
docker run -it aaanh/meaningful-graph-traversal:latest
```

- Build and run locally

```
make all
make run
```

- Visualize a graph with Graphviz

```sh
# 1. install it first
# 2. generate the .dot file with option 3 - Display Graph
# 3. generate the PNG file from resulting .dot
dot -Tpng -o output/graph-display.png output/graph-display.dot
# 4. profit in output/graph-display.png
```

### Documentation:

-   This README.md
-   presentation.pptx
-   projectUML.jpg
