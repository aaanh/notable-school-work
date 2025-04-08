# (a) Rolling a die

###  (i) Simulate rolling a fair 12-sided die 500 times. Generate a pie chart of the results

roll_1 <- (sample(c(1:12), 500, replace=TRUE))
table_1 <- table(roll_1)
piepercent <- round(100*roll_1/sum(roll_1), 1)
pie(table_1, labels=(1:12), radius=1, col=rainbow(12))

### (ii) Simulate rolling an unfair 12-sided die 500 times, where rolling a 1 is three times more likely to occur than the rest of the outcomes. Generate a pie chart of the results.

p <- c(0.3, rep(0.1, 11))
roll_2 <- sample(c(1:12), 500, replace=TRUE, prob=p)
table_2 <- table(roll_2)
pie(table_2, labels=(1:12), radius=1, col=rainbow(12))

### (iii) Simulate rolling a pair of fair 12-sided die 10000 times. From the results, estimate the probability that the sum of the two dice is equal to 10. What is the exact theoretical probability?

roll_3_1 <- sample(c(1:12), 10000, replace=TRUE)
roll_3_2 <- sample(c(1:12), 10000, replace=TRUE)
count_sum <- 0
for (i in 1:10000) {
    if (roll_3_1[i] + roll_3_2[i] == 10) {
        count_sum <- count_sum + 1
    }
}
cat('Estimated probability: ', count_sum/10000,'\n')

# (b) Playing the lottery

## 4 numbers
play_count <- 0
lotto_4 <- function() {
    n <- 0
    ticket <- sort(c(6,9,4,2))
    draw <- c(0,0,0,0)
    while (!all(ticket==sort(draw))) {
        n <- n+1
        draw <- sort(sample(1:49, 4, replace=FALSE))
        print(n) 
    }
    return(list("play_count" = n, "ticket" = ticket))
}

draws <- lotto_4()
cat("Play counts: ", draws$play_count, "\n")
cat("Drawn ticket: ", draws$ticket, "\n")
cat("Number of years before winning: ", draws$play_count/52, '\n')
cat("Net earning: ", 16*10^6 - draws$play_count*3, '\n')

## 6 numbers

play_count2 <- 0
lotto_6 <- function() {
    k <- 0
    ticket2 <- sort(c(3,23,32,18,46,37))
    draw2 <- c(0,0,0,0,0,0)
    while (!all(ticket2==sort(draw2))) {
        k <- k+1
        draw2 <- sort(sample(1:49, 6, replace=FALSE))
        print(k)
        print(draw2) 
    }
    return(list("play_count" = k, "ticket" = ticket2))
}

draws2 <- lotto_6()
cat("Play counts: ", draws2$play_count2, "\n")
cat("Drawn ticket: ", draws2$ticket2, "\n")
cat("Number of years before winning: ", draws2$play_count2/52, '\n')
cat("Net earning: ", 16*10^6 - draws2$play_count2*3, '\n')