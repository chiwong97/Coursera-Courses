
###########################################################
###########################################################

## Data Manipulation with dplyr in R

###########################################################

###########################################################
## Task One: Getting Started & About tidyverse
## In this task, you will understand what the tidyverse package 
## does and install the required packages for this project
###########################################################

# Set Working directory
setwd("C:/Users/User/OneDrive - The University of Melbourne/Projects/Coursera-Courses/Data-Manipulation-Using-dplyr-in-R")


## 1.1: Install the dplyr package


## 1.2: Install the gapminder package from the packages tab
install.packages("gapminder")

###########################################################
## Task Two: Import packages & dataset 
## In this task, we will load the required package and dataset
## into the R workspace. Also, we will explore the dataset
###########################################################

## 2.1: Load the dplyr package
library(dplyr)

## 2.2: Load the gapminder package
library(gapminder)

## 2.3: Look at the gapminder dataset
?gapminder
gapminder 

## 2.4: Check the structure of the dataset
glimpse(gapminder)

## This will give the same result
str(gapminder)

###########################################################
## Task Three: The Select Verb
## In this task, you will learn how to use the select verb
## to retrieve columns of the dataset
###########################################################

## 3.1: Select the country and continent columns
gapminder %>%
  select(country, continent)

## 3.2: Store the result of 3.1 in a variable called country_con
country_con <- gapminder %>%
  select(country, continent)

## 3.3: Print out the variable
country_con

###########################################################
## Task Four: The Filter Verb
## In this task, you will learn how to use the filter verb
## to retrieve rows of columns of the dataset
###########################################################

## 4.1: Filter the gapminder dataset for the year 1962
gapminder %>% 
  filter(year == 1962)

## 4.2: Filter for China in 2002
gapminder %>% 
  filter(country == "China", year == 2002)


###########################################################
## Task Five: The Arrange Verb
## In this task, you will learn how to use the arrange verb
## to sort the result of a column
###########################################################

## 5.1: Sort in ascending order of lifeExp
gapminder %>% 
  arrange(lifeExp)


## 5.2: Sort in descending order of lifeExp and 
## select the top fifteen
gapminder %>% 
  arrange(desc(lifeExp)) %>%
  slice(1:15)

#% 5.3: Filter for the year 1962, 
## then arrange in descending order of population
gapminder %>% 
  filter(year == 1962) %>% 
  arrange(desc(pop))


###########################################################
## Task Six: The Mutate Verb
## In this task, you will learn how to use the mutate verb
## to change or add columns in the dataset
###########################################################

## 6.1: Use mutate to change lifeExp to be in months
gapminder %>% 
  mutate(lifeExp = 12 * lifeExp)

## 6.2: Use mutate to create a new column called lifeExpMonths
gapminder %>% 
  mutate(lifeExpMonths = 12 * lifeExp)

## 6.3: Filter, mutate, and arrange the gapminder dataset
## Retrieve the life expectancy in months for the year 2007.
## Store the result in a new column called lifeExpMonths
## Sort the result in descending order
gapminder %>% 
  filter(year == 2007) %>%
  mutate(lifeExpMonths = lifeExp * 12) %>%
  arrange(desc(lifeExpMonths))


###########################################################
## Task Seven: The Summarize Verb
## In this task, you will learn how to use the summarize verb
## to summarize a column into one single value
###########################################################

## 7.1: Summarize to find the median life expectancy
gapminder %>% 
  summarize(medianLifeExp = median(lifeExp))

## 7.2: Filter for 1962 then summarize the median life expectancy
gapminder %>% 
  filter(year == 1962) %>% 
  summarize(medianLifeExp = median(lifeExp))

## 7.3: Filter for 1962 then summarize the median life expectancy 
## and the maximum GDP per capita
gapminder %>% 
  filter(year == 1962) %>%
  summarize(medianLifeExp = median(lifeExp), maxGDPperCap = max(gdpPercap))

###########################################################
## Task Eight: The group_by verb
## In this task, you will learn how to use the group_by verb
## to group by column(s) in the dataset
###########################################################

## 8.1: Find median life expectancy and maximum GDP per capita in each year
gapminder %>% 
  group_by(year) %>%
  summarize(medianLifeExp = median(lifeExp), maxGDPperCap = max(gdpPercap))

## 8.2: Find median life expectancy and maximum GDP per 
## capita in each continent in 1962
gapminder %>% 
  filter(year == 1962) %>% 
  group_by(continent) %>% 
  summarise(medianLifeExp = median(lifeExp), 
            maxGDPperCap = max(gdpPercap)) %>%
  arrange(desc(medianLifeExp))

## 8.3: Find median life expectancy and maximum GDP per capita
## in each continent/year combination
gapminder %>% 
  group_by(year, continent) %>% 
  summarise(medianLifeExp = median(lifeExp), 
            maxGDPperCap = max(gdpPercap))

year_cont <-gapminder %>% 
  group_by(year, continent) %>% 
  summarise(medianLifeExp = median(lifeExp), 
            maxGDPperCap = max(gdpPercap))

