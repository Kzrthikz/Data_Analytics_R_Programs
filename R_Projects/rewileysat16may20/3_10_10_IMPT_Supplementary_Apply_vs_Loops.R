##  ================================================
##  Supplementary Exercises 3:
##  - Comparing Apply family of Functions vs Loops
##  ================================================

##  Exercise 3 -- (a) Load "company2.csv" file; (b) write a function to create an additional column 
##  ("job_factor") to mark "1" if a manager, or "0" otherwise
##  ------------------------------------------------------------------------------------------------

    #setwd("C:\\Users\\Andy\\Documents\\D_Drive\\R_Projects\\1_Key_R_Codes\\data")
    setwd("/Users/karthika/Desktop/R_Projects/Class 2/data")
    data <- read.csv("company2.csv", header = T, na.strings=c('','.','NA'))
    head(data,2)
        #   gender educ      job salary jobtime prevexp
        # 1 female   12 employee  21450      98     381
        # 2 female    8 employee  21900      98     190
    View(data)
    str(data)
        ##... $ job       : Factor w/ 2 levels "employee","manager": 1 1 1 1 1 1 1 1 1 1 ...

##  ===========================================================
##  (A) Using Loops to process each component in the dataframe
##  ===========================================================


    ##  (1) create a loop inside a function wrapper
    ##  -----------------------------------------------------
    Job_factor_function <- function(x){
      for(i in 1:nrow(x)){
        if(as.character(x[i, "job"])=="employee"){
          x$job_factor[i] <- "0"
        }else{
          x$job_factor[i] <- "1"
        }
      }
      return(x)  #this is important, if left out, you get a "NULL" result
    }

##  (6) testing to see if it works 
##  -------------------------------------------------------
    data2<- Job_factor_function(data)   
    
    head(data2,2)
        #   gender educ      job salary jobtime prevexp job_factor
        # 1 female   12 employee  21450      98     381          0
        # 2 female    8 employee  21900      98     190          0
        
    tail(data2,2)
        #     gender educ     job salary jobtime prevexp job_factor
        # 473   male   19 manager  61875      65      26          1
        # 474   male   19 manager  47550      64      27          1



##  ===========================================================
##  (B) Using sapply to process each component in the dataframe
##  ===========================================================

##  (1) define sorting function for each row (we can use the if-else condition)
##  ---------------------------------------------------------------------------

    ## original if-else condition
        if(as.character(data[200, "job"])=="employee"){
          print("0")
        }else{
          print("1")
        }#[1] "0"
    
    ##  modified if-else condition as a function
        job_factor_sorter <- function(x){
          if(as.character(x)=="employee"){
            print("0")
          }else{
            print("1")
          }
        }

    str(data$job) #factor

##  (2) use sapply function to process each element
##  -------------------------------------------------
    data$job_factor <- sapply(data$job, job_factor_sorter)
    
    head(data,2)
        #   gender educ      job salary jobtime prevexp job_factor
        # 1 female   12 employee  21450      98     381          0
        # 2 female    8 employee  21900      98     190          0
    
    tail(data,2)
        # gender educ     job salary jobtime prevexp job_factor
        # 473   male   19 manager  61875      65      26          1
        # 474   male   19 manager  47550      64      27          1
    View(data)
    