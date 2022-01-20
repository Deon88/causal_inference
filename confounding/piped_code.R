# Piped confound

set.seed(666)

library(gganimate)
library(ggplot2)

# Generated confounded relationship

n <- 100

x <- runif(n = n, min = 0, max = 1)

b1 <- 25
b2 <- 2.5

z <- rnorm(n = n, mean = b1 + b2 * x, sd = 1)

a1 <- 230
a2 <- -5

y <- rnorm(n = n, mean = a1 + a2 * z, sd = 1)

df <- data.frame(x, y, z, t = 1)

ggplot(data = df, (aes(x = x, y = y))) +
  geom_point(colour = "grey") +
  geom_smooth(method = "lm", colour = "black", se = TRUE) +
  labs(title = "Path from X to Y is open",
       subtitle = "Modelled as Y ~ X (Prey abundance ~ Predator Presence )",
       x = "Predator Presence (X)",
       y = "Prey Abundance (Y)") +
  theme_minimal()


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
       subtitle = "Modelled as Y ~ X + Z (Prey abundance ~ Predator Presence + Predation rate)",
       x = "Predator Presence (X)",
       y = "Prey Abundance (Y)") +
  
  theme_minimal()

tmp_z <- tmp$z

z_plot <- ggplot() +
  geom_point(data = df, aes(x = z, y = y), colour = "grey") +
  geom_ribbon(data = tmp_z, aes(x = x, y = predicted, ymin = conf.low, ymax = conf.high),
              fill = "grey", alpha = 0.3) +
  geom_line(data = tmp_z, aes(x = x, y = predicted)) +
  labs(x = "Predation rate (X)",
       y = "Prey Abundance (Y)") +
  theme_minimal()

library(patchwork)

x_plot / z_plot
