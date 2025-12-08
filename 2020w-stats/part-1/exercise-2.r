# Nguyen Hoang Anh
# John Abbott College, Montreal, CANADA.
# Github: https://github.com/hirumaakane-ha/r-project-2019
# License: MIT License
# Course: Statistics DDD
# Instructor: Luiz T. Kazuo
# This R program and its repository on Github is a course project.

# Prerequisites
## Details can be found in README.md

##### Exercise 2: Functions

# Get user input first for n and k parameters

k <- as.integer(readline(prompt="Enter k: "))
n <- as.integer(readline(prompt="Enter n: "))

# a) Sum of integers

# Prompt user for input

sumInt <- function(n) {
  if (n == 1) return (1)
  else return(sumInt(n-1)+(n))
}

cat('Sum of integers to n: ', sumInt(8), '\n')
1+2+3+4+5+6+7+8

# b) Sum of integers squared

sumSquare <- function(n) {
  if (n == 1) return (1)
  else return (sumSquare(n-1)+n^2)
}

cat('Sum of Square is: ', sumSquare(9), '\n')

# (c) Sum of squares from k to n

sumSquaredkn <- function(k,n) {
  sum <- 0
  for (i in k:n) {
    sum <- sum + i^2
  }
  return(sum)
}

cat('Sum is: ', sumSquaredkn(6,9), '\n')

# (d) Rewriting function in (c) to call function in (b)

rewrite <- function(k,n) {
  sum <- 0
  if (n == k) {
    return(k^2)
  }
  else {
    while (k <= n) {
      sum <- sum + k^2
      k <- k+1 
    }
    return(sum)
  }
}

cat("Sum of squared k to n = ", rewrite(8,9), "\n")
cat("Sum of squared k to n = ", rewrite(1,9), "\n")
cat("Sum of squared k to n = ", rewrite(9,9), "\n")
# Test case 1: rewrite(8,9) = 145
# Test case 2: rewrite(1,9) = 285
# Test case 3: rewrite(9,9) = 81

# Clear screen
cat('\014')
