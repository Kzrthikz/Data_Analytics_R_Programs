#Handling Missing Values 
salary <- c(2000, 3000, NA, 4000) 
salary 

sum (salary)
length(salary)

is.na(salary)

which(is.na(salary))

complete.cases(salary)
which(complete.cases(salary))

which(!complete.cases(salary))


sum(salary, na.rm = T)
sum(na.omit(salary))
sum(na.exclude(salary))

#Subsetting 
#(i)
salary[!is.na(salary)]
sum(salary[!is.na(salary)])

#(ii)
salary[complete.cases(salary)]
sum(salary[complete.cases(salary)])