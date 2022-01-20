# Collider confound

library(gganimate)
library(ggplot2)

# generate confounding relationship

n <- 100

x <- rnorm(n = n, mean = 10, sd = 2.5)

y <- rnorm(n = n, mean = 25, sd = 5)

b1 <- 150
b2 <- -2.5
b3 <- -1.5

z <- rnorm(n = n, mean = b1 + b2 * x + b3 * y)

df <- data.frame(z, x, y, t = 1)

ggplot(data = df, (aes(x = x, y = y))) +
  geom_point(colour = "grey") +
  geom_smooth(method = "lm", colour = "black", se = TRUE) +
  labs(title = "Path from X to Y is closed",
       subtitle = "Modelled as Y ~ X (Myxomatosis ~ Predators)",
       x = "Predators (X)",
       y = "Myxomatosis (Y)") +
  theme_minimal()

# Confounded

m <- lm(y ~ x + z, data = df)

library(ggeffects)

tmp <- ggpredict(m)
tmp_x <- tmp$x

x_plot <- ggplot() +
  geom_point(data = df, aes(x = x, y = y), colour = "grey") +
  geom_ribbon(data = tmp_x, aes(x = x, y = predicted, ymin = conf.low, ymax = conf.high),
              fill = "grey", alpha = 0.3) +
  geom_line(data = tmp_x, aes(x = x, y = predicted)) +
  labs(title = "Path from X to Y is open",
       subtitle = "Modelled as Y ~ X + Z (Myxomatosis ~ Predators + Prey)",
       x = "Predators (X)",
       y = "Myxomatosis (Y)") +
  theme_minimal()

tmp_z <- tmp$z

z_plot <- ggplot() +
  geom_point(data = df, aes(x = z, y = y), colour = "grey") +
  geom_ribbon(data = tmp_z, aes(x = x, y = predicted, ymin = conf.low, ymax = conf.high),
              fill = "grey", alpha = 0.3) +
  geom_line(data = tmp_z, aes(x = x, y = predicted)) +
  labs(x = "Prey (Z)",
       y = "Myxomatosis (Y)") +
  theme_minimal()

library(patchwork)

x_plot / z_plot








