getwd()
setwd("/Users/karthika/Desktop/R_Projects/Key R codes/data")

data1 <- read.csv("load_test1.csv", header=T, na.strings=c('','.', 'NA'), stringsAsFactors=F)
data1
str(data1)

data2 <- read.csv("load_test2.csv", header=T, na.strings=c('','.', 'NA'), stringsAsFactors=F)
data2

data3 <- rbind(data1, data2) 
data3

data4 <- cbind(data1, data2) 
data4

write.csv(data3, "processed_data_test3.csv") 
write.csv(data3, "processed_data_test3.csv", row.names = FALSE)