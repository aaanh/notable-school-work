# COEN 244 Project

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
docker pull aaanh/meaningful-graph-traversal:latest
docker run -it aaanh/meaningful-graph-traversal:latest
```

- Build and run locally

```
git clone https://github.com/aaanh/meaningful-graph-traversal && cd meaningful-graph-traversal
docker build . --tag <your_dockerhub_uuid>/meaningful-graph-traversal:latest
docker run -it <your_dockerhub_uuid>/meaningful-graph-traversal:latest
```

### Documentation:

-   This README.md
-   presentation.pptx
-   projectUML.jpg
