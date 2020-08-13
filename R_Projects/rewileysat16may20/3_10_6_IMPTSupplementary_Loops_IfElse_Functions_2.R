##  ========================================
##  Supplementary Exercises 2
##   - Loops, If Else, Functions
##  ========================================

##  Exercise 2 -- (a) Load "company2.csv" file; (b) write a function to create an additional column 
##  ("job_factor") to mark "1" if job is a manager, or "0" otherwise
##  ------------------------------------------------------------------------------------------------
      #setwd("C:\\Users\\Andy\\Documents\\D_Drive\\R_Projects\\1_Key_R_Codes\\data")
      setwd("/Users/karthika/Desktop/R_Projects/Class 2/data")
      data <- read.csv("company2.csv", header = T, na.strings=c('','.','NA'))
      head(data)
      tail(data)
      head(data,2)
 
          #   gender educ      job salary jobtime prevexp
          # 1 female   12 employee  21450      98     381
          # 2 female    8 employee  21900      98     190
      
      View(data)

      str(data)
        ##... $ job       : Factor w/ 2 levels "employee","manager": 1 1 1 1 1 1 1 1 1 1 ...
      
      
    ## Step-by-Step guide to creating loop with if-else condition: 
    ##  -----------------------------------------------------------    
      
    ##  (1) subset and print the job factor as "character" (convert "factor" to "character")
    ##  -------------------------------------------------------------------------------------
          ## testing with specific rows (e.g. row 1)
      as.character(data[2, "job"]) #[1] "employee" 
      data[2,"job"] # factor form:
                    # [1] employee
                    # Levels: employee manager
      

      
    ##  (2) put in the if else condition
    ##  ---------------------------------------------
          ## testing with specific rows (e.g. row 391)
      if(as.character(data[391, "job"])=="employee"){
        print("0")
      }else{
        print("1")
      }#[1] "1"
      
      ## Alternative:
      if(data[391, "job"]=="employee"){
        print("0")
      }else{
        print("1")
      }#[1] "1"
      
    ##  (3) loop through the dataframe
    ##  --------------------------------------------
          ## test by looping through the whole dataset. Ths will print out 474 records of 1 and 0.
        nrow(data) #[1] 474
      
        for(i in 1:nrow(data)){
          ##  ==== insert if-else statement ===========
          if(as.character(data[i, "job"])=="employee"){
            print("0")
          }else{
            print("1")
          }
          ##  ====end of if-else statement ============
        }
      
    ##  (4) loop through the dataframe and store the value in "job_factor" column
    ##  --------------------------------------------------------------------------
          ## loop through the whole dataset. This will store the data in a job_factor column.
      for(i in 1:nrow(data)){
        if(as.character(data[i, "job"])=="employee"){
          data$job_factor[i] <- 0
        }else{
          data$job_factor[i] <- 1
        }
      }
      
      
        ##  print out the first and bottom few rows to check if job_factor column has been created
        ##  -----------------------------------------------------------------------------------------  
          
          head(data,2)
              #   gender educ      job salary jobtime prevexp job_factor
              # 1 female   12 employee  21450      98     381          0
              # 2 female    8 employee  21900      98     190          0
          
          tail(data,2)
              #     gender educ     job salary jobtime prevexp job_factor
              # 473   male   19 manager  61875      65      26          1
              # 474   male   19 manager  47550      64      27          1
          View(data)
  ## Comment:
  ##  -------
  ##  . Your loop is now complete. However, if you wish to place the loop in a function and call that function next time,
  ##    just follow the steps below.    

      
      
##  ====================================================================================
##  If we wish to create a function that creates a loop to do the same thing as above
##  ====================================================================================
      
    ##  (5) copy the loop inside a function wrapper
    ##  -----------------------------------------------------
      Job_factor_function <- function(x){
        
      ## ======= our  earlier loop function (or leave out the as.character)====  
        for(i in 1:nrow(x)){
          if(x[i, "job"]=="employee"){
            x$job_factor[i] <- 0
          }else{
            x$job_factor[i] <- 1
          }
        }
      ##  ========== end of loop function ======  
        
        return(x)  #this is important, if left out, you may get a "NULL" result. Return must be a new line.
      }

      
    ##  (6) testing to see if it works by calling our created function
    ##  -----------------------------------------------------------------
          ## let's store the output of the function in a new dataset (data2)
      data2<- Job_factor_function(data)   
      
      head(data2,2)
          #   gender educ      job salary jobtime prevexp job_factor
          # 1 female   12 employee  21450      98     381          0
          # 2 female    8 employee  21900      98     190          0
      
      tail(data2,2)
          #     gender educ     job salary jobtime prevexp job_factor
          # 473   male   19 manager  61875      65      26          1
          # 474   male   19 manager  47550      64      27          1
      
      View(data2)
      
      
      data$job  # factor
      as.character(data$job)  #character
      