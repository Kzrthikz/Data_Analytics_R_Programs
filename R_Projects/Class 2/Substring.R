#Useful functions for data wrangling: 
#-substring (substr) and transform 

#1. Create dataframe 
data <- data.frame(
  name = c("Andrew", "Ben", "Candy"), 
  DOB = c("01/02/1978", "02/04/1979", "03/05/1982"), 
  salary = c(4000, 8000, 10000)
)
data

#2. Substring extract data by position 
#(a) substr
substr(data$name, 1,3) 
substr(data$DOB, 1,2) #date
substr(data$DOB, 4,5) #month
substr(data$DOB, 7,10) #year

#(b) transform
data_new <- transform(data, employee_cpf = salary * 0.20)
data_new 

transform(data, money_contribution = ifelse (salary > 6000, 600, 40))

transform(data, money_ok = ifelse(salary >= 9000, "rich", ifelse(salary < 9000 & salary>= 5000, "so so", "sighhhh...")))

#(c) combine substr and transform 
data2 <- transform(
  data, 
  birth.month = substr(DOB, 4,5), 
  birth.year = substr(DOB, 7,10)
)
data2 



