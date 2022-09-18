# Introduction to Time Series in R 

# Set working directory
setwd("C:/Users/User/OneDrive - The University of Melbourne/Projects/Coursera-Courses/Intro-To-Time-Series-Analysis-in-R")

# Load Packages 
library(IRdisplay)
library(magrittr)
library(tidyverse)
library(scales)
library(gridExtra)
library(forecast)
library(tseries)
library(ggthemes)
theme_set(theme_economist())

# Load Helper R Functions - these are functions defined in another script 
source("R Functions/compare_models_function.R")
source("R Functions/sim_random_walk_function.R")
source("R Functions/sim_stationary_example_function.R")

# Run a function to compare linear regression to basic AR(1) time series models
# This function was predefined in a different script
compare.models(n=100)
# Breaking down the plot:
# Light blue line - past data 
# Dark blue line - forecast from the model 
# Yellow - resulting confidence intervals 
### LINEAR REGRESSION FORECAST
# We can see that the linear regression forecast doesn't account for 
# compounding error - CI width should increase over time because we are
# making successive future predictions.
### TIME SERIES FORECAST
# In the time series forecast, the error bands actually widen as more and 
# more predictions are made - this makes sense because we are forecasting
# using what we have forecasted, so there is more variance.
compare.models(n=10000)

# KEY CONCEPTS: Autocorrelation/Autocovariance 
# simulate a random walk 
dat <- sim.random.walk()
# plot the random walk 
dat %>% 
  ggplot(aes(t,X)) +
  geom_line() +
  xlab("T") +
  ylab("X") + 
  ggtitle("Time Series Plot")

# ACF plot 
ggAcf(dat$X, type = "correlation") +
  ggtitle("Autocorrelation ACF Plot")

# PACF plot 
ggAcf(dat$X, type="partial") +
  ggtitle("Partial Autocorrelation PACF Plot")

############## KEY CONCEPTS: Stationarity #################
### CHECKING FOR STATIONARITY
# Generate our sample data frame that contains three time series 
# Note: This was a predefined function given to us 
df <- sim.stationary.example(n=1000)
head(df)
dim(df) # t is a time series index, x1,x2,x3 are simulated time series 
# note: x1 and x2 are non stationary, x3 is stationary 

# Step 1 to check for stationarity: check a plot of the time series 
# and look for a constant mean and finite variance (bounded x values)

# EXAMPLE: 
# Plot non-stationary time series (x1 and x2)
g1 <- ggplot(df, aes(x=t, y=X1)) +
  geom_line() +
  xlab("t") +
  ylab("X1") +
  ggtitle("Non-Stationary X1")

g2 <- ggplot(df, aes(x=t, y=X2)) + 
  geom_line() + 
  xlab("t") + 
  ylab("X2") +
  ggtitle("Non-Stationary X2")

# Plot stationary time series (x3)
g3 <- ggplot(df, aes(x=t, y=X3)) +
  geom_line() + 
  xlab("t") +
  ylab("X3") +
  ggtitle("Stationary X3")

# View both plots simultaneously 
grid.arrange(g1,g3)

# Step 2 to check for stationarity: check the ACF plot - see if it dies off 
# quickly as opposed to gradual decline 

# EXAMPLE: 
# Plot ACF for stationary 
g4 <- ggAcf(df$X1, type="correlation") +
  xlab("t") + 
  ylab("X1") + 
  ggtitle("Non-Stationary X1")

# Plot ACF for non-stationary 
g5 <- ggAcf(df$X3, type="correlation") + 
  xlab("t") + 
  ylab("X3") +
  ggtitle("Stationary X3")

grid.arrange(g4,g5)

# Step 3 to check for stationarity: perform unit root tests - something like
# the augmented Dickey-Fuller test 

# EXAMPLE: 
# Non-stationary has large, non-significant p-value 
adf.test(df$X1)

# Stationary has small, significant p-value 
adf.test(df$X3)


### TRANSFORMING FOR STATIONARITY
# METHOD 1: DIFFERENCING 
diff <- df$X1 - lag(df$X1, 1)
g6 <- ggAcf(df$X1, type="correlation")
g7 <- ggAcf(diff, type="correlation")
grid.arrange(g6,g7)

# METHOD 2: DETRENDING 
# we detrend with the linear regression model 
detrended <- resid(lm(X2~t, data=df))
g8 <- ggAcf(df$X2, type="correlation")
g9 <- ggAcf(detrended, type="correlation")
grid.arrange(g8,g9)

### BASIC MODEL TYPES 
# Autoregressive - AR(p)
# Moving Average - MA(q)
# Autoregressive Moving Average - ARMA(p,q)
# Autoregressive Integreated Moving Average - ARIMA(p,d,q)
# Decomposition Models 

# EXAMPLE - Box Jenkins Method: 
# Step 1: Check for stationarity 
ur <- read.csv("Data/Mass Monthly Unemployment Rate.csv")
head(ur)
dim(ur)

# Transform data types 
class(ur$DATE)
ur$DATE <- as.Date(ur$DATE)
class(ur$DATE)

# Method 1 - checking the time series plot
ggplot(ur, aes(x=DATE, y=MAURN)) +
  geom_line()

# Method 2 - ACF plot
ggAcf(ur$MAURN, type="correlation")

# Method 3 - ADF test
adf.test(ur$MAURN)

# Step 2: Transform for Stationarity and Identify Model Parameters 
# AR model 
ar.model <- auto.arima(ur$MAURN, max.d=0, max.q=0, allowdrift=TRUE)
ar.model

# MA model 
ma.model <- auto.arima(ur$MAURN, max.d=0, max.p=0, allowdrift=TRUE)
ma.model 

# ARMA model 
arma.model <- auto.arima(ur$MAURN, max.d=0, allowdrift=TRUE)
arma.model

# ARIMA model 
arima.model <- auto.arima(ur$MAURN, allowdrift=TRUE)
arima.model

# Step 3: Check the residuals of the model fit 
ar.residual <- resid(ar.model)
ma.residual <- resid(ma.model)
arma.residual <- resid(arma.model)
arima.residual <- resid(arima.model)

# Plot a PACF plot 
ggAcf(ar.residual, type="partial")
ggAcf(ma.residual, type="partial")
ggAcf(arma.residual, type="partial")
ggAcf(arima.residual, type="partial")

# Run the Ljung Box test 
Box.test(ar.residual, type="Ljung-Box", lag=1)
Box.test(ma.residual, type="Ljung-Box", lag=1)
Box.test(arma.residual, type="Ljung-Box", lag=1)
Box.test(arima.residual, type="Ljung-Box", lag=1)

# Regardless of which model we fit, we have reasonably well behaved 
# models - so we can proceed with these models to make forecast and
# subsequent analysis. (All the p-values > 0.05)

# Step 4: Forecast 
ar.forecast <- forecast(ar.model, h=24, level=80)
ma.forecast <- forecast(ma.model, h=24, level=80)
arma.forecast <- forecast(arma.model, h=24, level=80)
arima.forecast <- forecast(arima.model, h=24, level=80)

# Plot forecasts 
g10 <- autoplot(ar.forecast)
g11 <- autoplot(ma.forecast)
g12 <- autoplot(arma.forecast)
g13 <- autoplot(arima.forecast)
grid.arrange(g10,g11,g12,g13)

# ASIDE: Model 5
# STL (Seasonal Trend Losses) Decomposition Models 
# Transform to times series object and specify the frequency 
ur.ts <- ts(ur$MAURN, frequency=12)

# Fit STL model 
stl.model <- stl(ur.ts, s.window="periodic")

# Plot model 
autoplot(stl.model)

# Forecast 
stl.forecast <- forecast(stl.model, h=24, level=80)
g14 <- autoplot(stl.forecast)
g14
