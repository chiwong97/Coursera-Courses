###########################################################
###########################################################

### Tidy Messy Data using tidyr in R

###########################################################
###########################################################

###########################################################
## Task One: Getting Started
## In this task, you will install and import the required 
## packages for this project.
###########################################################

## Install the required package
install.packages(c("tidyverse","readxl"))

## Load the tidyverse package into the R workspace
library(tidyverse)

## Load the readxl library to read in the xlsx file
library(readxl)

## Set working directory
setwd("C:/Users/User/OneDrive - The University of Melbourne/Projects/Coursera-Courses/Tidy-messy-data-using-tidyr-in-R")

###########################################################
## Task Two: Pivot longer
## In this task, you will learn to use the pivot_longer() 
## function to make sure each variable is stored in a column
###########################################################

## Let's get an idea of the arguments the function contains
?pivot_longer

## Let's create a sample data
table1 <- tibble(
  country = c("A", "B", "C"),
  `1999` = c("0.7K", "37K", "212K"),
  `2000` = c("2K", "80K", "213K")
)

## Print the data
table1

## Use pivot_longer to reshape the data
table1 %>% 
  pivot_longer(c('1999', '2000'))

## Pivot on all the other columns except the country column
table1 %>% 
  pivot_longer(-country)

## Overwrite its name with year 
## The value column should be named n_cases
table1 %>% 
  pivot_longer(-country, names_to = "year", values_to = "n_cases")

## Using the gather function
table1 %>% 
  gather(-country, key = 'year', value = 'n_cases')

## Read the documentation of gather - similar to the pivot_longer() function 
?gather

###########################################################
## Task Three: Pivot wider
## In this task, you will learn to use the pivot_wider() 
## function to make sure each variable is stored in a column
###########################################################

## Let's get an idea of the arguments the function contains
?pivot_wider

## Read in the planet-data.csv using the read_csv() function
planet_df = read_csv("planet-data.csv")

## Print the first six rows of the data using the head() function
head(planet_df)

## Change this long data to wide form
## Give each planet variable its own column
planet_df %>%
  pivot_wider(planet, names_from = 'metric', values_from = 'value')

## Quick note about spread()
?spread

###########################################################
## Task Four: (Optional) Practice Activity
## In this task, you will take a pause and practice. You want to
## know the number of nuclear bombs for each country
###########################################################

## Read in nukes.csv into R
nukes_df <- read_csv("nukes.csv")

## Print the first 5 rows and all columns
nukes_df %>% 
  print(n = 5, width = Inf)

## Pivot all columns except for year to a longer format.
nukes_df %>% 
  pivot_longer(-year)

## Overwrite the names of the two new columns
## The name column should be named country
## The value column should be named n_bombs
nukes_df %>% 
  pivot_longer(-year, names_to = 'Country', values_to = 'n_bombs')

###########################################################
## Task Five: Plot the long data
## In this task, you will take a pause and practice
###########################################################

## Replace the NA values in the n_bombs column 
## with integer zero values (0L).
nukes_df %>% 
  pivot_longer(-year, names_to = "country", values_to = "n_bombs") %>%
  replace_na(list(n_bombs = 0L))

## Plot the number of bombs per country over time
## Create a line plot where the number of bombs dropped 
## per country is plotted over time. Use country to color the lines.
nukes_df %>% 
  pivot_longer(-year, names_to = "country", values_to = "n_bombs") %>%
  replace_na(list(n_bombs = 0L)) %>%
  ggplot(aes(x = year, y = n_bombs, color = country)) + 
  geom_line()

###########################################################
## Task Six: Unstack data
## In this task, you will learn how to unstack data
###########################################################

## Load the PlantGrowth data
data("PlantGrowth")

## Print the data
PlantGrowth

## Split this data into the different treatment groups
unstack(PlantGrowth)

## Load the diets.csv data set using read_csv()
diet <- read_csv("DIETS.csv")

## Explore the data using 
## head() and tail() functions
head(diet)
tail(diet)

## Unstack the data
unstack(diet)

## The solution
# Note that the column to be unstacked should be specified first, so we specify WTLOSS then DIET
diet.data <- unstack(diet, WTLOSS ~ DIET)

## Check the first 5 rows of the new data
head(diet.data, n=5)

###########################################################
## Task Seven: (Optional) Practice Assessment
## In this task, you will take a pause and answer some 
## questions to test your knowledge
###########################################################

## Question 1:
## As an R user with an understanding of the tidyr package. 
## You have been tasked to replace the missing values in 
## the cty (city miles per gallon) column of the mpg 
## data set with the value 5. Write a code to achieve this task.
data(mpg)
head(mpg)
mpg %>% 
  replace_na(list(cty = 5L))

## Question 2:
## Peter is an beginner R user who just started learning about 
## tidying data in R. He has a data set with two columns; 
## age and gender (Male and Female) of participants in a survey. 
## He desires to create two columns where each column contains 
## the ages of the two genders in this dataset. He read about the unstack function. 
## However, the unstack function is not working as it should. 
## What do you suggest should be done to the unstack function to make it work? 
## And how should the argument be specified?

###########################################################
## Task Eight: Separate rows
## In this task, you will learn to use separate_rows()
## to make sure each observation is stored in a row
###########################################################

## Let's get an idea of the arguments the function contains
?separate_rows

## Import the netflix_data.csv using the read_csv() function
## Save it as net_data
net_data = read_csv('netflix_data.csv')

## Print the first six rows of the data using the head() function
head(net_data)

## Separate the actors in the cast column over multiple rows
net_data %>% 
  separate_rows(cast, sep = ', ')

## Find which six actors have the most appearances
net_data %>% 
  separate_rows(cast, sep = ', ') %>% 
  rename(actor = cast) %>% 
  count(actor, sort = TRUE) %>% 
  head(n = 6)


###########################################################
## Task Nine: Separate & Unite
## In this task, you will use separate() to 
## make sure each cell contains a single value and
## unite to merge columns by a delimiter
###########################################################

## Let's get an idea of the arguments the function contains
?separate

## Read the movies_duration.csv using the read_csv() function
movies_data <- read_csv("movies_duration.csv")

## Print the first six rows of the data using the head() function
head(movies_data)

## Split the duration column into value and unit columns
movies_data %>% 
  separate(duration, into=c('value', 'unit'), sep=' ', convert=TRUE)

## Find the average duration for each type and unit
movies_data %>% 
  separate(duration, into=c('value', 'unit'), sep=' ', convert=TRUE) %>% 
  group_by(type, unit) %>% 
  summarize(mean_duration = mean(value))

## Join the title and type columns using sep = ' - '
movies_data %>% 
  unite(title_type, title, type, sep =' - ') %>% 
  separate(duration, into=c('value', 'unit'), sep= ' ', convert = TRUE)

###########################################################
## Task Ten: (Optional) Practice Activity
## In this task, you will take a pause and practice. You want to
## get a count of movies per director
###########################################################

## Load the netflix_directors.csv data using read_csv()
netflix_directors = read_csv('netflix_directors.csv')

## Print director_df to see what string 
## separates directors in the director column.
head(netflix_directors)

## Spread the values in the director column over separate rows.
netflix_directors %>% 
  separate_rows(director, sep = ', ')

## Spread the director column over separate rows
## Count the number of movies per director
netflix_directors %>% 
  separate_rows(director, sep = ', ') %>% 
  count(director, sort = TRUE) 
  

## Drop rows with NA values in the director column using drop_na()
## and recount the number of movies per director
netflix_directors %>% 
  drop_na(director) %>% 
  separate_rows(director, sep = ', ') %>% 
  count(director, sort = TRUE) 


###########################################################
## Task Eleven: Separate rows & Separate
## In this task, you will learn how to combine the 
## separate_rows() and separate() functions to tidy data
###########################################################

## Load and print the drink.xlsx data using read_excel()
drink_df <- read_excel("drink.xlsx")
drink_df

## Separate the ingredients column over rows
drink_df %>%
  separate_rows(ingredients, sep = "; ")

## Separate the ingredients into three columns
## ingredient, quantity, and unit
drink_df %>% 
  separate_rows(ingredients, sep = "; ") %>% 
  separate(ingredients, into = c('ingredient', 'quantity', 'unit'), sep=' ', convert=TRUE) 

## Separate the ingredients over rows
## Separate ingredients into three columns
## Group by ingredient and unit
## Calculate the total quantity of each ingredient
drink_df %>% 
  separate_rows(ingredients, sep = "; ") %>% 
  separate(ingredients, into = c('ingredient', 'quantity', 'unit'), sep=' ', convert=TRUE) %>%
  group_by(ingredient, unit) %>% 
  summarize(total_quantity = sum(quantity))

###########################################################
## Task Twelve: Wrap up
## In this task, we will wrap up this project by looking at 
## how to create nice visuals of our tidy data.
###########################################################

## Recall the wide data from task three
planet_df %>% 
  pivot_wider(planet, names_from = "metric", values_from = "value") 

## Plot the distance to the sun and temperature
## Plot planet temperature (y-axis) over distance to sun (x-axis)
planet_df %>% 
  pivot_wider(planet, names_from = "metric", values_from = "value") %>% 
  ggplot(aes(x = distance_to_sun, y = temperature)) +
  geom_point(aes(size = diameter)) +
  geom_text(aes(label = planet), vjust = -1) +
  labs(x = "Distance to sun (million km)", 
       y = "Mean temperature (Celsius)") +
  theme(legend.position = "none")

###########################################################
## Task Thirteen: (Optional) Portfolio Activity
## In this task, you will get to work on a portfolio activity
## all on your own. Try your hands on this activity.
###########################################################

## Read and print the planet_wide.csv data
planet = read_csv('planet_wide.csv')
head(planet)

## Tidy the data set
planet %>% 
  pivot_longer(-metric, names_to = 'Planet') %>% 
  pivot_wider(Planet, names_from = 'metric', values_from = 'value')

## Create the plot
planet %>% 
  pivot_longer(-metric, names_to = 'Planet') %>% 
  pivot_wider(Planet, names_from = 'metric', values_from = 'value') %>% 
  ggplot(aes(x=diameter, y=number_of_moons)) + 
  geom_point(aes(size=diameter)) +
  geom_text(aes(label=planet), vjust=-1) + 
  labs(x='Diameter (km)', y='Number of moons') + 
  theme(legend.position='none')
  

#################################################################
##-------------------------------------------------------------##
## THANK YOU FOR LEARNING WITH ME
##-------------------------------------------------------------##
#################################################################











