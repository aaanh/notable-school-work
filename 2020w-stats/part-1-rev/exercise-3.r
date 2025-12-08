# (a) Tim Horton's
print("Tim Horton's cup distribution with hypergeometric")
n = 33357600 # cups
p = 1/6 # winning
q = 5/6 # normal
k = 8000 # subpop to kirkland
x = 1300 # X < 1300, as in x <= 1299

pdf_hyper = phyper(x-1, n*p, n*q, k)
cat("P[X<=1299] = ", pdf_hyper, "\n")

# (b) Hockey
print("Hockey poisson distributions")
mu = 29 # average shots per game
n = 82 # sample size of games
x = 2400 # P[X>2400], as in P[X>=2401]

# set lower.tail = TRUE for maximum meme power
pdf_poisson = ppois(2401, lambda = 29*82, lower.tail = FALSE)

cat("P[X>=2401] or P[X>2400] = ", pdf_poisson, '\n')

# (c) cdf (or pdf) for 2 different cont dist.
print("plotting distributions")
xlabel = "X"
ylabel = "P[X]"
title = "PDF of normal distribution and chi-squared distribution."
subtitle = "Parameters: chisq(df=5, col=blue); N(mu=3, sd=4, col=red)."
# change by param in seq(...) for line smoothing resolution

plot(pchisq(seq(0, 30, by=0.1), df=5), type="l", col="dodgerblue", xlab=xlabel, ylab=ylabel, main=title,sub=subtitle, font.sub=1, font.main=2, lwd=2)

lines(pnorm(seq(0, 30, by=0.1), mean = 3, sd = 4), col="deeppink", lwd=2)