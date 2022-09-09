# Guided project - Building and analysing linear regression model in R
# Instructor - Dr. Nikunj Maheshwari

# Required libraries have been installed but needs to be loaded
library(sjPlot)
library(dplyr)
library(sjlabelled)
library(sjmisc)
library(ggplot2)
theme_set(theme_sjplot())

# Set Working Directory 
setwd("C:/Users/User/OneDrive - The University of Melbourne/Projects/Coursera-Courses/Building-And-Analyzing-Linear-Regression-Model-in-R")

# Task 1 - Load dataset and summarize it
data <- read.csv("cars.csv", header=TRUE, stringsAsFactors=FALSE)
View(data)
summary(data)
str(data)

# Task 2 - Clean your dataset
# a - remove leading and trailing white spaces in all cells 
# note: this is only required for character data type columns (chr)
# We write the following line of code:
# We are collecting the names of all columns that return true for the 
# the function is.character
cols <- names(data)[vapply(data, is.character, logical(1))]
data[,cols] <- lapply(data[,cols], trimws)

# b - null values (note: missing values are denoted NA)
# We want to convert missing values to NA
data[data=="N/A"] = NA


# c - count the number of missing values in each column and decide if we 
# need to remove it
# Think of sapply as a for loop, going through each line in your dataset
# and applying the function to it.
sapply(data, function(x) mean(is.na(x)))
# notice that the column Market.Category has a very high number.
# In this case, we will remove it, but
# CAUTION: when removing columns or rows, it might not be wise, it's often 
# better if you replace it with some value rather than remove it completely 
data$Market.Category <- NULL

# d - remove the rows that contain missing data 
data <- data[complete.cases(data), ]

# Task 3 - Split into training and test set
data_num <- data %>% 
  select_if(is.numeric)

# Taking a look at the ditribution of the MSRP 
# Two ways to make the histogram:
# 1 - using ggplot
ggplot(data_num, aes(x = MSRP)) + geom_histogram()
# 2 - using hist function 
hist(data_num$MSRP, breaks=100)

# From the histograms, we can see that there are outliers, so we want to 
# remove them as they may skew the analysis. In this case, we will just 
# look at cars that have MSRP in the range 15000 - 50000
data_num <- data_num %>%
  filter(MSRP > 15000) %>% 
  filter(MSRP < 50000)

# Set a seed to ensure we can reproduce the code 
set.seed(123)
# Split 80% of the data into training 
size <- floor(0.8 * nrow(data_num))
train_ind <- sample(seq_len(nrow(data_num)), size=size)
train <- data_num[train_ind, ]
test <- data_num[-train_ind, ]

# Task 4 - Fit linear regression model and interpret model summary statistics
model <- lm(MSRP ~ . , data = train)
summary(model)
# F statistic gives the overall significance of the model. It assesses
# whether atleast one predictor/variable has a non-zero coefficient 

# small p-value shows that the model is highly significant 

# We want to plot the model and get a clearer picture 
# This plot will show us the coefficients and the significance 
plot_model(model, show.values = TRUE, value.offset = 0.2)

# We want to use another model using only some variables 
model2 <- lm(MSRP ~ Engine.HP + highway.MPG + Engine.Cylinders, 
             data = train)

# Task 5 - Plot and analyse model residuals - diagnostic plots
par(mfrow = c(2,2))
plot(model)

# Plot 3 - scale-location plot shows if residuals are spread
# equally along the ranges of predictors - the assumption
# of equal variance. 
# We want this plot to be randomly spread with a horizontal 
# line. 

# Plot 4 - helps identify influential cases - cases that 
# can alter the results if they are excluded from your
# model. Look out for points in the upper and lower right
# corner. Cases that are outside of the Cook's distance are
# considered to be influential. 

# Generally, if some cases are identified over all 4 
# plots, you might want to take a deeper look into them 

# Task 6 - Predict future values and calculate model error metrics
test$pred <- predict(model, newdata = test)
par(mfrow=c(1,1))
ggplot(test, aes(x=MSRP, y=pred)) +
  geom_point() +
  geom_smooth(method='lm', color='blue') +
  theme_bw()

# Error metrics - observed value minus the predicted value 
error <- test$pred - test$MSRP
rmse <- sqrt(mean(error^2))
rmse

mae <- mean(abs(error))
mae

### End of project