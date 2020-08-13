df1 <- data.frame(name = c("Andrew", "Bruce", "Carol", "Dan"), 
                  married_year = c(2016, 2015, 2016, 2008))

df2 <- data.frame(birth_place = c("Singapore", 
                                  "Malaysia", 
                                  "Thailand", 
                                  "Indonesia"), 
                  birth_year = c(1988, 
                                  1990, 
                                  1989, 
                                  1984))

df1
df2 

#Adding columns 
#Method 1 : Using c() 
df1$profession <- c("analyst", "doctor", "Biz man", "teacher")
df1
#Method 2: Using cbind() to combine columns 
cbinded_df <- cbind(df1, df2) 
cbinded_df

df3 <- data.frame(salary = c(5000, 6000, 5500, 6500))
cbinded_df <- cbind(cbinded_df, df3) 
cbinded_df

#alternative
#cbinded_df <- cbind(cbinded_df, data.frame(salary = c(5000, 6000, 5500, 6500)))
#cbinded_df


#Method 3: data.frame 
new_df <- data.frame(df1, df2)
new_df


#Adding Rows
new_rows <- data.frame(
  name = c("Elson", "Freddy"), 
  married_year = c(2009, 2010), 
  profession = c("lawyer", "dentist"), 
  birth_place = c("UK", "China"), 
  birth_year = c(1985, 1996), 
  salary = c(6000, 9000)
)
new_rows

new_data <- rbind(cbinded_df, new_rows) 
new_data 