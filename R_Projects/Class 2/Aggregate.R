#Aggregate 
?iris 
View(iris)
head(iris)
unique(iris$Species)
length(unique(iris$Species))
str(iris)

#Aggregate function 
aggregate(iris[,1:4], by=list(iris$Species), FUN = mean, na.rm = T)

#tapply if we only wish to analyse 1 column eg. sepal length 
tapply(iris$Sepal.Length, INDEX = iris$Species, FUN = mean)
