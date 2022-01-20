# True relationship
# library(gganimate)
library(ggplot2)

n <- 100
t <- 10

x <- runif(n = n, min = 0, max = 100)

b1 <- 253
b2 <- -1.59

y <- rnorm(n = n, mean = b1 + b2 * x, sd = 10)

df <- data.frame(x, y, t = 1)

ggplot(data = df, (aes(x = x, y = y))) +
  geom_point(colour = "light grey") +
  geom_smooth(method = "lm", colour = "black", se = TRUE) +
  labs(title = "True causal relationship",
       subtitle = "Modelled as Y ~ X",
       x = "Predator abundance (X)",
       y = "Prey abundance (Y)") +
  ylim(c(0, NA)) +
  theme_minimal()

# for(i in 2:t) {
#   x_tmp <- runif(n = n, min = 0, max = 100) + 5 * i
#   y_tmp <- rnorm(n = n, mean = b1 + b2 * x_tmp, sd = 5)
#   df_tmp <- data.frame(
#     x = x_tmp,
#     y = y_tmp,
#     t = i
#   )
#   df <- rbind(df, df_tmp)
# }
# 
# true_relationship <- ggplot(data = df, (aes(x = x, y = y))) +
#   geom_point(colour = "light grey") +
#   geom_smooth(method = "lm", colour = "black", se = FALSE) +
#   labs(x = "X",
#        y = "Y") +
#   theme_minimal() +
#   labs(title = "True causal relationship",
#        subtitle = "Increasing X by {5 * round(frame_time, digit = 0)} causes a change in Y") +
#   transition_time(t)
# 
# setwd("C:\\github\\ZO4541\\code\\confounding")
# 
# anim_save("true causal.gif", true_relationship)
# 


