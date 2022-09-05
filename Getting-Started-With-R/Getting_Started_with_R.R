
###########################################################
###########################################################

## Getting Started with R

###########################################################
###########################################################

###########################################################
## Task One: R Overview & Preliminaries
## In this task, you will learn about the R programming
## language and write basic R commands.
###########################################################

### Basic R Commands

### 1.1: Assignments in R

## Assign x to 1, y to 2 and z to 3
## 2 ways of assigning variables:
x = 1
y <- 2
z <- 3

### 1.2: Functions

## Print Hello World
print('Hello World')

### 1.3: Computations

## Add 17 to 5
17 + 5

## Add 5 to x
5 + x

## Add 15 to 5 and store it in a variable called y
y <- 15 + 5

## Find the square root of 16 and store it in a variable called y
y <- sqrt(16)      #Square root function

## Find the square root of 16
y

## Calling variable in R

# Call y, see y value in console
y

# Call x, see x value in console
x


###########################################################
## Task Two: Basic Data Types in R 
## In this task, you will understand the different data types
## in R, and how they are used in R.
###########################################################

### 2.1: Variable Assignment

## Set the variable x to 6 (Numeric Type)
x <- 6

## Set the variable y to "Hello" (Character Type)
y <- "Hello"

## Note: R is case sensitive: The variables 'z' and 'Z' can coexist
## in R environment and have different values.

# Store z to the character 'World'
z <- "World"

# Store the value in a variable Z
Z <- 8

### 2.2: Call Variables

# Call small z
z

# Call capital Z
Z

### 2.3: Adding Object Together
a <- x + Z


## 2.4: What do you think will be the result of this?
# c <- y + z

# Error - R cannot do string addition (unlike python)


### Data Types

### Numeric

## 2.5: Check the data type of the variable a
class(a)

## 2.6: Set a variable num to 8.5
num = 8.5

print(num)   ## Call the variable num

class(num)    ## This is used to check the data type of a variable

### Integers

## 2.7: Change numeric data type to integer
int <- as.integer(num)

class(int)  ## Check the data type of the variable int

### Character
w <- "Hello"
class(w)   # Check the data type of the variable w

## 2.8: Create a character variable from a numeric variable

char <- as.character(a)
## Call the char variable

class(char)

### Boolean/Logical

## 2.9: Create a logical variable and set it as TRUE

bool <- TRUE
class(bool)
              
## Check the data type of log variable

### Factors

## 2.10: Store movie ratings in a variable called fac
fac <- factor(c("3 stars", "2 stars", "1 star"))

class(fac)   ## Check the data type

## 2.11: Check how many levels and the data type of the levels
levels(fac)
nlevels(fac)
class(levels(fac))
## 2.12: Check all variables and objects that have been defined
ls()


###########################################################
## Task Three: Data Structures in R: Vectors
## In this task, you will understand vectors as a data structure
## in R, and how to perform sub-setting on the vector created.
###########################################################

### VECTORS

## 3.1: Create a vector of the marks of 4 students
## use c() to store several values in one variable
marks <- c(14,26,28,30)

## 3.2: Check the data type of the vector
class(marks)

## 3.3: Check the length of the variable
length(marks)

## 3.4: Indexing and Slicing
marks[4]               ## Returns the 4th mark

marks[2:4]               ## Returns the 2nd, 3rd and 4th marks

## (Ex.) What do you think the result will be?
marks[-1] ## This means to take out the first value, not the last value like in python
marks[-2]
marks[-1:-2]

## 3.5: Create a character vector
char_vec <- c("a", "b", "c", "d")


## 3.6 (Ex.): Check the data type and length of the vector
class(char_vec)
length(char_vec)
## 3.7 (Ex.): Retrieve the 1st, 2nd and 3rd characters in the char_vec vector
char_vec[1:3]

## 3.8: Create the variable char_num_vec to take numeric and character types
char_num_vec <- c("a", 3, "b", 4)

## 3.9 (Ex.) : What do you think will be the data type of the vector?
class(char_num_vec)   ## character value overrides the numerical values so it will be type character

## 3.10: Create a vector of odd numbers
odd_vec <- seq(1, 14, by=2)


###########################################################
## Task Four: Data Structures in R: Matrices
## In this task, you will understand matrices as a data structure
## in R, and how to perform sub-setting on the matrix created by
## accessing rows and columns of the matrix
###########################################################

### MATRICES

# 4.1: Create matrix with values from marks, 2 rows and 2 columns
matrix1 <- matrix(data=marks, nrow=2, ncol=2)

# Call the matrix created
matrix1

## 4.2: Change byrow to TRUE
matrix2 <- matrix(data=marks, nrow=2, ncol=2, byrow=TRUE)

# Call the matrix created
matrix2

# 4.3: Create vector with 9 integers from 1 to 9
int <- c(1:9)
matrix3 <- matrix(data=int, nrow = 3, ncol = 3)
matrix3

# 4.4: Access value on second row, second column
matrix3[2,2]

# 4.5: Access second row
matrix3[2,]

# 4.6: Access second column
matrix3[,2]

# 4.7: Access sub-matrix with components on both 
# first 2 rows and first 2 columns
matrix3[1:2,1:2]

# 4.8: Access sub-matrix with components that are 
# not on 3rd row and 3rd column
matrix3[-3,-3]


###########################################################
## Task Five: Data Structures in R: Data frames
## In this task, you will understand data frames as a data structure
## in R, and how to access specific rows and columns of a data frame.
###########################################################

### DATA FRAMES

## 5.1: Create data frame with 2 columns: marks and char_vec
df <- data.frame(char_vec, marks)
df
class(df)     ## Look at data frame's overall type

## 5.2: Check the structure of each variable/feature in the data frame
str(df)

# 5.3: Look at columns' data types
class(df$char_vec)
# 5.4: Call a column in a data frame
df[,1]

# OR
df$char_vec

# 5.5: Create sub data frame with first 3 rows only
df1 <- df[1:3,]
df1
## 5.6: Create a new data frame with 3 rows and explore it

data <- data.frame(
  Name = c("Olayinka", "Ayomikun", "Juliet"),
  Age = c(24, 21, 19),
  Height = c(1.67, 1.60, 1.66),
  Salary = c(25000, 12000, 10000)
)

## Call the data frame 
print(data) 

class(data)  ## Check the data type 

nrow(data)  # This returns the number of rows in the data frame
ncol(data)  # This returns the number of columns in the data frame

## 5.7: Create another data frame with 2 rows

data1 <- data.frame(
  Name = c("Daniel", "Yusuf"),
  Age = c(23, 26),
  Height = c(1.68, 1.69),
  Salary = c(35000, 37000)
)

## 5.8: Use rbind and cbind to append new data to an existing dataset

## rbind - A row bind appends new values in row fashion
df2 <- rbind(data, data1)
df2

## Create two new columns; Gender and LastName
Gender = c("M", "F", "F", "M", "M")
LastName = c("Arimoro", "Isijola", "James", "Akinbote", "Khalid")

## cbind - A column bind appends new values in column fashion
df3 <- cbind(df2, Gender, LastName)


## Check the dataframe and its structure
df3
str(df3)


###########################################################
## Task Six: Data Structures in R: Lists
## In this task, you will understand list as a data structure
## in R, and how to perform sub-setting on the list created.
###########################################################

### LISTS

# 6.1: Create a list with 4 objects
list <- list(char_vec, marks, matrix1, df)
list
# 6.2: Accessing each object in the list

# Access the first and second objects
list[[1]]
list[[2]]

# (Ex.): Access the third and fourth objects
list[[3]]
list[[4]]

# 6.3: Call First row of 3rd list's objects.
list[[3]][1,]


###########################################################
## Task Seven: Installing Packages in R
## In this task, you will learn how to install packages in R
## using the R studio console and the install.packages function.
## In addition, you will learn how to set the right working
## directory in R.
###########################################################

### Importing Packages

# 7.1: Install package on computer (from CRAN repository)


# load package in R session
library(readr)

# 7.2: Install readxl package to machine
## install.packages("readxl")

## Load in Rsession to use read_excel() fucntion
library(readxl)

### WORKING DIRECTORY

# 7.3: Set working directory (tells R where to import files from/export files to)
setwd("C:/Users/User/OneDrive - The University of Melbourne/Projects/Coursera-Courses/Getting-Started-With-R")

# Get working directory
getwd()


###########################################################
## Task Eight: Importing Datasets into R
## In this task, you will learn how to import different datasets
## into R
###########################################################

### 8.1: Import .Txt with space separated values and explore it

# read.table() function to import .txt files
txtdata <- read.table("dataset.txt", header=TRUE)
txtdata

## See all data
View(txtdata)

## See first 5 rows
head(txtdata, 5)

## See last rows
tail(txtdata)

## Check the structure of the data 
str(txtdata)

## Check the summary of the data
summary(txtdata)

## Change column's type to character
## Sales column is overwritten by 
## "character" version of Sales column
txtdata$Sales <- as.character(txtdata$Sales)

## Change column's type to factor
txtdata$Sales <- as.factor(txtdata$Sales)
str(txtdata)
### 8.2: Import .txt with comma separated values

# read.table() function to import .txt files
# I will add a sep= "," for comma separated files
orange <- read.table(file="Orange_comma_separated.txt", header=TRUE, sep=",")
head(orange)

## Check the summary of the data
summary(orange)

## Check the structure of the data
str(orange)

## (Ex.): Change the Tree feature to factor
orange$Tree <- as.factor(orange$Tree)
str(orange)

### 8.3: Import .csv file

# load readr for read_csv() function
library(readr)

#  Use read.csv() to import .csv files and explore it
diabetes <- read.csv("diabetes.csv")
head(diabetes)

## (Ex.) Check the data type
class(diabetes)

## (Ex.) Retrieve the first 5 rows
head(diabetes, 5)

## (Ex.) Check the number of rows and columns
dim(diabetes)

## (Ex.) Check the structure of the data
str(diabetes)

## (Ex.) Check the summary of the data 
summary(diabetes)

### 8.4: Import excel document

## Use read_excel() to import xlsx documents
exdata <- read_excel("dataset.xlsx")
head(exdata, 5)
## Note: We can also use Rstudio interface

## Check the data type
class(exdata)

# Make the data a proper data frame object
exdata <- as.data.frame(exdata)
class(exdata)
str(exdata)
