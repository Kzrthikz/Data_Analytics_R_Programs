getwd()
setwd("/Users/karthika/Desktop/R_Projects/Class 2/data)

#testing without using na.strings() 
#has blank spaces, ., <NA> not consistent
data_no_nastrings <- read.csv("heros_missingdata.csv", header = TRUE) 
data_no_nastrings

#Testing with na.strings() parameter 
#missing cells, some missing cells denoted with '.', NA 
#When it sees '', '.'NA' to recognise everything as NA. Mark everything as NA. 
#VERY VERY IMPORTANT to have na.strings = c(...)
data_with_nastrings <- read.csv("heros_missingdata.csv", header = TRUE, na.strings = c('', '.','NA'))
data_with_nastrings

#4. Filter out missing values 
#Case 1: data with no nastrings 
data1 <- data_no_nastrings[complete.cases(data_no_nastrings), ]
data1

#Case 2: data with nastrings 
data2 <- data_with_nastrings[complete.cases(data_with_nastrings),]
data2