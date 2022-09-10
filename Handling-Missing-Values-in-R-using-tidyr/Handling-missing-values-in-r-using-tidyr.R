###########################################################
###########################################################

### Handling Missing Values in R using tidyr

###########################################################
###########################################################

###########################################################
## Task One: Getting Started
## In this task, you will install and import the required 
## packages for this project.
###########################################################

## Install the tidyverse package
install.packages("tidyverse")

## Load the tidyverse package
library(tidyverse)

## Load the ggplot2 package into the R workspace
library(ggplot2)

###########################################################
## Task Two: Import and explore the data sets
## In this task, you will load and explore the msleep data
###########################################################

## Load the msleep data
data(msleep)

## Check the first 6 rows of the data
head(msleep)

## Check the dimension of the data
dim(msleep) # shape function in python

## Check the column names
names(msleep)

# TWO WAYS TO CHECK THE NUMBER OF MISSING VALUES 

## Check the number of missing values for each column
sapply(msleep, function(x) sum(is.na(x)))

## Using the map function to check for 
## number of missing values
msleep %>% 
  map(is.na) %>% 
  map(sum)

## Calculate the proportion of missingness
## for each variable
msleep %>% 
  map(is.na) %>% 
  map(sum) %>% 
  map(~ ./nrow(msleep)) %>% 
  bind_cols()

###########################################################
## Task Three: Select Missing Variables
## In this task, you will select the columns with missing
## values
###########################################################

## Select the vore, sleep_rem, sleep_cycle, and brainwt
msleep_data <- msleep %>% 
  select(vore, sleep_rem, sleep_cycle, brainwt)

## Print the new msleep data
msleep_data

## Check the dimension of the new data
dim(msleep_data)

###########################################################
## Task Four: Drop Missing Rows
## In this task, you will drop the missing rows in the
## vore variable
###########################################################

## Drop rows with NA values in the vore column
msleep_data <- msleep_data %>% 
  drop_na(vore)

## Check the dimension of the new data
dim(msleep_data)

###########################################################
## Task Five: Replace Missing Values
## In this task, you will replace the missing values 
## in the sleep_rem and sleep_cycle variables
###########################################################

## Replace the NA values in the sleep_rem 
## column with integer zero values (0L).
msleep_data <- msleep_data %>% 
  replace_na(list(sleep_rem = 0L))

## Replace the missing values in the sleep_cycle column
## using the median of the values
msleep_data <- msleep_data %>% 
  replace_na(list(sleep_rem = 0L)) %>%
  mutate(sleep_cycle = replace_na(sleep_cycle, replace = median(sleep_cycle, na.rm = TRUE)))

###########################################################
## Task Six: Fill Missing Values
## In this task, you will fill the missing values in the 
## brainwt variable in different direction
###########################################################

## Fill the brainwt column upwards (replace with the next value)
msleep_data %>% 
  fill(brainwt, .direction = 'up')

## Replace the NA values in the sleep_rem 
## column with integer zero values (0L).
## Fill the brainwt column upwards
msleep_data <- msleep_data %>% 
  replace_na(list(sleep_rem = 0L)) %>% 
  fill(brainwt, .direction = 'up')
msleep_data

###########################################################
## Practice One: Fill Missing Values - Exercises
## In this task, you will work on a practice exercise to
## fill the missing values in the brainwt column
###########################################################

## Fill the missing values in the brainwt column
## "downup" and "updown".
msleep_data %>% 
  fill(brainwt, .direction='downup')

msleep_data %>% 
  fill(brainwt, .direction='updown')

###########################################################
## Task Seven: Wrap up - Chain all operations
## In this task, you will combine and chain all the 
## operations we have performed using the pipe operator
###########################################################

## Chain all the steps together and
## save the result as msleep_data
msleep_data <- msleep_data %>% 
  drop_na(vore) %>%
  replace_na(list(sleep_rem = 0L)) %>%
  fill(brainwt, .direction = "up") %>%
  mutate(sleep_cycle = 
           replace_na(sleep_cycle, 
                      median(sleep_cycle, na.rm = T)))

## Print the cleaned data
msleep_data


#################################################################
##-------------------------------------------------------------##
## THANK YOU FOR LEARNING WITH ME
##-------------------------------------------------------------##
#################################################################




