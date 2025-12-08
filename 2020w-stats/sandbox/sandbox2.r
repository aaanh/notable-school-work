n <- 10

# suppose there is an arbitrary gen(x) as  the current gen
# the enumerator function is going to choose the gen(x-1)

init <- function(n) {
    g <- list()
    for (i in 1:n) {
        g <- c(g, list(sample(1:n, 2, replace=TRUE)))    
    }
    return(g)         
}

gen_x <- function(g, n) {
    for (i in 1:n) {
        g[[i]] <- union(g[[i]], sample(1:n, 2, replace=TRUE)) 
    }
    return(g)
}

g <- init(n)
g
g <- gen_x(g, n)

checkMrca <- function(g, n) {
    for (i in 1:n) {
        if (length(g[[i]]) == n) {
            return(TRUE)
        }
        else {
            return(FALSE)
        }
    }
}

gencounter <- 0

while (checkMrca(g,n) != TRUE) {
    gencounter <- gencounter + 1
    g <- gen_x(g,n)
    print(gencounter)
}

print(g)
