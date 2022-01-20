# Some code to demonstrate the risk of confounding variables

# The causal relationships here are:

# G causes X and Y
# X causes Y and D
# D causes I
# I causes Y

# So three paths for information to enter from X to Y
# To identify a path, start with X and see how many ways you can get to Y
# Note the arrows indicate the direction of causation

# Path 1: X -> Y
# Path 2: X <- G -> Y
# Path 3: X -> D -> I -> Y

# We want to understand Path 1, so include X and Y in the model
# e.g., lm(Y ~ X)

# We are not interested in Path 2, but G is a forked confound
# To account for forked confounds, they need to be included in the model, so G is included in the model
# e.g., lm(Y ~ X + G)

# We are not interested in Path 3, but D and I are piped confounds
# To account for piped confounds, they *must not be included* be included in the model

# So our final model, which should be best suited for finding the effect of X on Y is:
# lm(Y ~ X + G)


# Simulate some data to demonstrate this:

# Setting seed to keep randomness constant between runs
set.seed(3)

# We have 10k samples+
n <- 100

# X is generated from a uniform distribution
x <- runif(n = n, min = 0, max = 100)

# Next we simulate D, which depends on X
b1 <- -10
b2 <- 3
# D is also a normal distribution with a mean dependent on X
d <- rnorm(n = n, mean = b1 + b2 * x, sd = 50)

# Plot and see what this looks like
plot(d ~ x)

# Next is I, which is caused by D.
c1 <- 500
c2 <- -0.5
i <- rnorm(n = n, mean = c1 + c2 * d, sd = 35)

plot(i ~ d)

# Next, we generate Y
# There are 2 variables which influence Y values:
# X and I
# We need an intercept and 2 slopes, hence 3 parameters

int <- 10
i_effect <- 1.25
x_effect <- 2
y <- rnorm(n = n, mean = int + 
             i_effect * i + 
             x_effect * x, 
           sd = 6)

plot(y ~ x)
plot(y ~ i)

# And finally simulate the collider confound, G
# G is caused by X and Y, so I specify two parameters (intercept and slope) for the relationship
a1 <- 25
a2 <- -2
a3 <- 2.5
# X is a normal distribution with a mean dependent on G
g <- rnorm(n = n, mean = a1 + a2 * x + a3 * y, sd = 15)

# We can plot to see what this looks like:
plot(g ~ x)
plot(g ~ y)

# Bring the data together into a dataframe
df <- data.frame(x, g, d, i, y)

# Run the model we might be tempted to run first of all
# Keep in mind, the effect of X should be -2.5
# The model causal structure we care about is Y ~ X
coef(lm(y ~ x, data = df))

# The model does find a relationship but underestimates X at ca. -4

# The model we should run is:
coef(lm(y ~ x + d, data = df))

coef(lm(y ~ x + i, data = df))

coef(lm(y ~ x + g, data = df))

m <- lm(y ~ x + g + d + i, data = df)

library(MASS)

stepAIC(m)
