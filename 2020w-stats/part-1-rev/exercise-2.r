# Moran process

n <- 100 # pop size

simulate_moran <- function(n) { # feed pop size n into the function
    population <- c(rep(0, n-1), 1)  # initialize a vector containing n-1 type 0 and 1 type 1
    # print(population) # for debugging only
    k <- 0 #  initialize counter variable for converging dominant generations
    while (!(all(population == c(rep(0, n))) | all(population == c(rep(1, n))))) { # run/stop logic
        k <- k+1

        # replace that individual with another randomly selected one with respect to INDEX LOCATION
        population[sample(c(1:n), 1, replace=FALSE)] <- population[sample(c(1:n), 1, replace=FALSE)]

        # print(population) # for debugging only
    }
    return(list("generations" = k, "dominant" = population[1]))    
}

dom0 <- 0
dom1 <- 0
gen0 <- 0
gen1 <- 0

for (i in 1:1500) {
    print(i) # print i-th simulation
    moran <- simulate_moran(n)
    if (moran$dominant == 0) {
        dom0 <- dom0 + 1 # number of simulations ending up in type 0
        gen0 <- gen0 + moran$generations # call value by index using list_name$column_name
    }
    else if (moran$dominant == 1) {
        dom1 <- dom1 + 1 # number of simulations ending up in type 1
        gen1 <- gen1 + moran$generations # sums the generations
    }
}

cat("Type 0 dominance: ", dom0, "\n")
cat("Type 0 average gen: ", gen0/dom0, "\n")

cat("Type 1 dominance: ", dom1, "\n")
cat("Type 1 average gen: ", gen1/dom1, "\n")

cat("Percentage of Type 1 dominance: ", dom1/i*100,"%", "\n")