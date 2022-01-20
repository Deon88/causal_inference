# Spurious correlation
library(gganimate)
library(ggplot2)

n <- 100
t <- 10

x <- rpois(n = n, lambda = 1)

y <- rpois(n = n, lambda = 2 + 1 * x)

df <- data.frame(x, y, t = 1)

ggplot(data = df, (aes(x = x, y = y))) +
  geom_jitter(colour = "grey", width = 0.1, height = 0.1) +
  geom_smooth(method = "lm", colour = "black", se = TRUE) +
  labs(title = "Coincidental relationship",
       subtitle = "Modelled as Y ~ X",
       x = "Number of Nicholas Cage films (X)",
       y = "Number of drownings (Y)") +
  theme_minimal()

# for(i in 2:t) {
#   x_tmp <- rnorm(n = n, mean = 10, sd = 2.5) + 5 * i
#   y_tmp <- rnorm(n = n, mean = 20, sd = 5)
#   df_tmp <- data.frame(
#     x = x_tmp,
#     y = y_tmp,
#     t = i
#   )
#   df <- rbind(df, df_tmp)
# }
# 
# spurious_relationship <- ggplot(data = df, (aes(x = x, y = y))) +
#   geom_point(colour = "light grey") +
#   geom_smooth(method = "lm", colour = "black", se = FALSE) +
#   labs(x = "X",
#        y = "Y") +
#   theme_minimal() +
#   labs(title = "Spurious association",
#        subtitle = "There is no effect of increasing X by {5 * round(frame_time, digit = 0)} on Y") +
#   transition_time(t)
# 
# spurious_relationship
# 
# anim_save("spurious.gif", spurious_relationship)