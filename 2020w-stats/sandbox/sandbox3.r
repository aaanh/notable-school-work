# MRCA simulation program
# Iteration by Nguyen Hoang Anh, based on instructor L. K. Takei's abstraction
# MIT License, 2019

n <- 10 # population size

# initialize current gen: l_d
l_d <- list()
for (i in 1:n) {
    l_d[[i]] <- c(i)
}

l_d # print list of descendants

l_p <- list()
for (i in 1:n) {
    l_p[[i]] <- sample(1:n, 2, replace=TRUE)
}

l_p # print list of ancestors from gen-1

isChildren <- function(i) {
    v_c <- list()
    for (j in length(v_c)) {
        if (is.Element(v_c, l_p[[j]])) {
            v_c <- union(v_C, l_p[[j]])
        }
    }
}

