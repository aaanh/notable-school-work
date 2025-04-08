# GRAPHING SCRIPTS
# Dependencies: results/results.csv on https://github.com/zasshuwu/r-project-2019

require(plotly)
# setwd("~/dev/r-project-2019/results/") # For personal macOS dev env (MacBook)
# setwd("C:/Users/Nogamioka/Desktop/dev/r-project-2019/results/") # For personal Windows dev env (Desktop)
# setwd("~/dev/r-project-2019/results/") # For personal Windows dev env (Laptop)
# setwd("~/dev/r-project-2019/part-3/")

df <- read.csv("results.csv")

x <- list(title = "Iteration #")
y <- list(title = "TMRCA")

p <- plot_ly(data = df, x = ~c(1:25)) %>%
    add_trace(y = ~vector_100, name = "n = 100", marker = list(symbol = "circle"), mode="lines+markers", size = 5, line = list(width=1)) %>%
    add_trace(y = ~vector_1000, name = "n = 1000", marker = list(symbol = "diamond"), mode="lines+markers", size = 5, line = list(width=1)) %>%
    add_trace(y = ~vector_4000, name = "n = 4000", marker = list(symbol = "square-dot"), mode="lines+markers", size = 5, line = list(width=1)) %>%
    add_trace(y = ~vector_5000, name = "n = 5000", marker = list(symbol = "x"), mode="lines+markers", size = 5, line = list(width=1)) %>%
    add_trace(y = ~vector_10000, name = "n = 10000", marker = list(symbol = "triangle-up"), mode="lines+markers", size = 5, line = list(width=1)) %>%
    layout(xaxis = x, yaxis = y, title="Estimation of Time to Most Recent Common Ancestor Depending on Population Size")

mean_100 <- mean(df$vector_100)
mean_1000 <- mean(df$vector_1000)
mean_4000 <- mean(df$vector_4000)
mean_5000 <- mean(df$vector_5000)
mean_10000 <- mean(df$vector_10000)

mean_list <- list(mean_100, mean_1000, mean_4000, mean_5000, mean_10000)
df_mean <- (mean_list)
df_mean
p2 <- plot_ly(x = ~c(100, 1000, 4000, 5000, 10000), y = ~mean_list, type="bar") %>%
    layout(title = "Average TMRCA for each n size population", xaxis = list(title="Generations"), yaxis = list(title="Population size"))

mean_list
p2
p