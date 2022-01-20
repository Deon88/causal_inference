# Forked confound
library(gganimate)
library(ggplot2)

n <- 100

z <- rnorm(n = n, mean = 10, sd = 2.5)

b1 <- 50
b2 <- 2.5

x <- rnorm(n = n, mean = b1 + b2 * z)

a1 <- 5
a2 <- 3

y <- rnorm(n = n, mean = a1 + b2 * z, sd = 5)

df <- data.frame(z, x, y, t = 1)

ggplot(data = df, (aes(x = x, y = y))) +
  geom_point(colour = "grey") +
  geom_smooth(method = "lm", colour = "black", se = TRUE) +
  labs(title = "Path from X to Y is open",
       subtitle = "Modelled as Y ~ X (Sparrows ~ Starlings)",
       x = "Number of starlings (X)",
       y = "Number of sparrows (Y)") +
  theme_minimal()

# Corrected relationship

m <- lm(y ~ x + z, data = df)

library(ggeffects)

tmp <- ggpredict(m)
tmp_x <- tmp$x

x_plot <- ggplot() +
  geom_point(data = df, aes(x = x, y = y), colour = "grey") +
  geom_ribbon(data = tmp_x, aes(x = x, y = predicted, ymin = conf.low, ymax = conf.high),
              fill = "grey", alpha = 0.3) +
  geom_line(data = tmp_x, aes(x = x, y = predicted)) +
  labs(title = "Path from X to Y is closed",
       subtitle = "Modelled as Y ~ X + Z (Sparrows ~ Starlings + Feeder)",
       x = "Number of starlings (X)",
       y = "Number of sparrows (Y)") +
  theme_minimal()

tmp_z <- tmp$z

z_plot <- ggplot() +
  geom_point(data = df, aes(x = z, y = y), colour = "grey") +
  geom_ribbon(data = tmp_z, aes(x = x, y = predicted, ymin = conf.low, ymax = conf.high),
              fill = "grey", alpha = 0.3) +
  geom_line(data = tmp_z, aes(x = x, y = predicted)) +
  labs(x = "Amount of food in bird feeder (Z)",
       y = "Number of sparrows (Y)") +
  theme_minimal()

library(patchwork)

x_plot / z_plot

################################
# Quiz figures

library(ggplot2)

n <- 100

z <- rnorm(n = n, mean = 10, sd = 2.5)

b1 <- 905
b2 <- -2.5

x <- rnorm(n = n, mean = b1 + b2 * z)

a1 <- -62
a2 <- 13.5

y <- rnorm(n = n, mean = a1 + b2 * z, sd = 5)

df <- data.frame(z, x, y, t = 1)

ggplot(data = df, (aes(x = x, y = y))) +
  geom_point(colour = "grey") +
  geom_smooth(method = "lm", colour = "black", se = TRUE) +
  labs(title = "Path from X to Y is open",
       subtitle = "Modelled as Y ~ X (Sparrows ~ Starlings)",
       x = "Number of starlings (X)",
       y = "Number of sparrows (Y)") +
  theme_minimal()

# Corrected relationship

m <- lm(y ~ x + z, data = df)

library(ggeffects)

tmp <- ggpredict(m)
tmp_x <- tmp$x

x_plot <- ggplot() +
  geom_point(data = df, aes(x = x, y = y), colour = "grey") +
  geom_ribbon(data = tmp_x, aes(x = x, y = predicted, ymin = conf.low, ymax = conf.high),
              fill = "grey", alpha = 0.3) +
  geom_line(data = tmp_x, aes(x = x, y = predicted)) +
  labs(title = "Path from X to Y is closed",
       subtitle = "Modelled as Y ~ X + Z (Sparrows ~ Starlings + Feeder)",
       x = "Number of starlings (X)",
       y = "Number of sparrows (Y)") +
  theme_minimal()

tmp_z <- tmp$z

z_plot <- ggplot() +
  geom_point(data = df, aes(x = z, y = y), colour = "grey") +
  geom_ribbon(data = tmp_z, aes(x = x, y = predicted, ymin = conf.low, ymax = conf.high),
              fill = "grey", alpha = 0.3) +
  geom_line(data = tmp_z, aes(x = x, y = predicted)) +
  labs(x = "Amount of food in bird feeder (Z)",
       y = "Number of sparrows (Y)") +
  theme_minimal()

library(patchwork)

x_plot / z_plot
