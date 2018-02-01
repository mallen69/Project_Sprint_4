#The start of working with the US Contagious Diseases

#Setting my working Directory in order to be in the folder where my Dirty Excel file is.
setwd("C:/Users/micha/Desktop/DevLeague Begins Nov 7 2017/Project_Sprint_4/")

#Loading libraries and reading my Dirty Excel file into R.

#Loading the library dplyr in order for the 
library(dplyr)

#Loading the libary ggplot2
library(ggplot2)

#Creating the variable "sick" to represent the ""us_contagious_diseases.csv"" 
#which was pulled from the Internet
sick <- read.csv("us_contagious_diseases.csv")


sick <- transform(sick, percentage_sick = count / population)


