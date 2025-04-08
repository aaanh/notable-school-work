# Repository: mrca-sim-r
### R project for Stats course at JAC, 2020. MRCA simulation.
### Course title: 201-DDD-05 - Statistical Methods
------

## Initializing dependencies:
- ggplot2, plotly
### Setting up development/testing env:
1. Install R from https://cran.r-project.org/mirrors.html - choose the automatic CDN server link.
2. Clone the repository here: git clone https://github.com/zasshuwu/mrca-sim-r/
3. (Might need to setwd to repository root to run code.)
4. Allocate at least a good amount of time when trying to run the simulation from the start with varying size of population.
5. Attention: These scripts were coded on x64-darwin platform with R version 3.6.1, and tested for compability on Ubuntu 19.04 LTS and Windows 10 lastest version in August, 2019. Dependencies and env factors might break if packages are to deprecate in the future.

Advance with own discretions: I strongly advise using R Studio IDE because it offers intuitive code editor and script execution interface. The IDE can display assigned variables and defined functions within the workflow. You can download and [install R Studio here](https://rstudio.com).

### Navigating the repository:
```
root/
    | docs  # Project information, requirements, descriptions; MRCA papers
    | part-1  # Source code and report for part 1
    | part-2  # (same)
    | part-3  # (same)
        | index.r <- main simulation file; code for exporting simulated data
        | graph.r <- data visualization using ggplot2; dependencies: results/*
    | results
    | sandbox
    | LICENSE.txt
    | README.md (this file)
```
----------------------------------------------------------
Acknowledgement: Thank you Prof. Luiz  K. Takei (QC., Canada) for valuable guidance throughout the course of the project.
