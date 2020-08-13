##  ======================================
##  Useful Functions for data wrangling:
##  - substring (substr) & transform
##  ======================================

##  1. Create dataframe
##  --------------------
    data <- data.frame(
                        name = c("Andrew", "Ben", "Candy"),
                        DOB = c("01/02/1978", "02/04/1979", "03/05/1982"),
                        salary = c(4000, 8000, 10000)
    )

    
##  2.  Split data by position using substring and transform
##  --------------------------------------------------------- 
    ##  (a) Extract data by position
    ##  -------------------------------
    ## substr(x, start, stop) ## extract from start position to end position
    substr(data$name, 1,3) #[1] "And" "Ben" "Can"
    substr(data$DOB, 1,2)  #[1] "01" "02" "03"
    
    
    ## (b) using transform function mutate data by creating some new from existing data
    ##  ---------------------------------------------------------------------------------
    ##  transform(data, new_variable = manipulation of old_variable)
    data_new <- transform(data, employee_cpf =  salary*0.20) # new column employee_cpf created
    
    data_new
    
    transform(data, money_contribution = ifelse(salary>6000, 600, 40))
    transform(data, tax = ifelse(salary>6000, 0.10*salary, 0.05*salary))
    
    transform(data, money_ok = ifelse(salary>=9000, "rich", ifelse(salary<9000 & salary>=5000, "so so", "sighhh..")))
  
    
    ##  (c) Combine substr and transform
    ##  ---------------------------------------------------------
    data2 <- transform(data, 
                       birth.month = substr(DOB,4,5), ## create birth.month column
                       birth.year = substr(DOB, 7,10) ## create birth.year column
                       )
    data2
    ?substr
          #     name        DOB birth.month birth.year
          # 1 Andrew 01/02/1978          02       1978
          # 2    Ben 02/04/1979          04       1979
          # 3  Candy 03/05/1982          05       1982
    
    
