##  ================================================
##  Supplementary Exercise 1:
##  - Loops, If Else, Functions
##  ================================================
  ## Loops -- doing tasks repeatedly
  ## If else -- doing tasks conditionally
  ## Functions -- creating commands (=software)

  ## () -- used in commands
  ## [] -- used in dataframes/ vector objects
  ## {} -- used in loops, if else, functions -- to specify the processes
##  =========================
##  (A) Loops
##  =========================

##  (1) "for" Loop
##  -----------------
      for(i in 1:6){
            print(i)
        }


##  (2) "while" Loop
##  -----------------
      i <- 1   # this is to initalise the counter
      while(i<= 6){
        print(i)
        i=i+1
      }       
     
  
        ##  this doesn't work ================    
            i <- 1
            while (i <= 6) {print(i) i=i+1 }  
                
        ##  =====this works===================    
            i <- 1
            while (i <= 6) {print(i); i = i+1}


            
            
##  =========================
##  (B) If Else
##  =========================
      
##  (1) "if" Statement
##  ---------------------      
    x <- 5
    if(x>0){
      print("Positive number")
    }
      

    
##  (2) "if else" statement
##  ------------------------
    ##  (a) "if...else" statement
    ##  -------------------------
          x <- 5
          if (x>0){
            print("Positive number / non-negative number")
            
          } else {
            print("Negative number")
          }
    
                # x <- 5
                # if (x>0){
                #   "Positive number / non-negative number"
                # } else {
                #   "Negative number"
                # }
          
        ##  Alternatively:
          if(x>0) print("Non-negative number") else print("Negative number")
          
          if(x>0) "Non-negative number" else "Negative number"
          
          
          
    ##  (b) "ifelse" statement
    ##  -------------------------
          x <- 5
          ifelse(x>0, "Positive number", "Negative number")
        
            
    ## (c) Another example of if else statement
    ##  -----------------------------------------
          ## run first and key in number in console
          num = as.integer(readline(prompt="Enter a number: "))
          
          ## run later (%% means modulo division --> returns remainder after division)
          if((num %% 2) == 0) {
            print(paste(num,"is Even"))
          } else {
            print(paste(num,"is Odd"))
          }  
          
          
          
          
##  (3) "if...else" ladder (aka nested if else)
##  -------------------------------------------
    ##  (a) Example 1:      
      x <- 0
      if(x< 0){
        print("Negative number")
      }else if (x>0){
        print("Positive number")
      }else{
        print("zero")
      }    
          
    ## (b)  Example 2:
      name <- "Ironman"
      
      if(name == "Aquaman"){
        print("I can swim")
      } else if(name == "Batman"){
        print("They call me 'Dark Knight'")
      } else if (name == "Superman"){
        print("I am faster than a speeding bullet")
      }else{
        print("Err.. what's your name?")
      }

    ## (c) Example 3:  
      x <- 0
      ifelse(x>0, "Positive number", ifelse(x<0, "Negative number", "zero"))
      
      

      
##  ========================
##  (C) Functions
##  ========================
      score <- c(-2.1, 3.5, 5.1, 7, 6.2, 9.1, 0)

      multiply_10 <- function(x){
        x*10
      }

      multiply_10(score)    
        # [1]  -21  35  51  70  62  91   0

   
      
##  =============================================================
##  (D) Exercise 1 - Combining Loops, If Else, Functions
##  =============================================================
      ##  . suppose a teacher is lenient in marking and decides to give students
      ##    who scored below 50, a "compassionate" additional 1 mark.
      
      ##  . Get the mean score of the students' new marks
      
      
##  (1) Manual method -- just using if else statement
##  ------------------------------------------------------------
      marks <- c(49, 50, 70)
      marks_new <- NULL   #initialise the new vector ; vector(); 0
                            # marks_new <- FALSE
    
      if(marks[1]<50){
        marks_new[1] <- marks[1] + 1
      }else{
        marks_new[1] <- marks[1]
      }
      
      if(marks[2]<50){
        marks_new[2] <- marks[2] + 1
      }else{
        marks_new[2] <- marks[2]
      }
      
      if(marks[3]<50){
        marks_new[3] <- marks[3] + 1
      }else{
        marks_new[3] <- marks[3]
      }

      marks_new        #[1] 50 50 70
      
      mean(marks_new)  #[1] 56.66667
      
      


##  (2) Using loops and if and else statements
##  -------------------------------------------------
      marks <- c(49, 50, 70)
      marks_new2 <- vector()  #another way to initialise the new vector
      length(marks)  #[1] 3
      
      
      for(i in 1:length(marks)){
      ##==========insert your if-else statement =====  
        if(marks[i]<50){
          marks_new2[i] <- marks[i]+1
        }else{
          marks_new2[i] <- marks[i]
        }
      ##  ========end of if-else statement ==========  
      }
      
      marks_new2        #[1] 50 50 70
      mean(marks_new2)  #[1] 56.66667
      

##  (3) After using loops, function, and ifelse (##improvement!)
##  ------------------------------------------------------------

      # pre-run this section
      marks <- c(49, 50, 70)
      
      
      compassionate_function <- function(x) {
        marks_new3 <- NULL
      ## ======= this is our loop section ======##
        for(i in 1:length(x)){
          if(x[i]<50){
            marks_new3[i] <- x[i] + 1 
          }else{
            marks_new3[i] <- x[i]
          }
        }
      ##  ==========end of loop section =======##
        return(marks_new3) # print(marks_new3) # marks_new3
      }

# use only 1 line of code by calling the function we created
 
   compassionate_function(marks)  #[1] 50 50 70
   mean(compassionate_function(marks)) #[1] 56.66667

   
##  assuming we have another class, we can use back the function to adjust the marks
    marks2 <- c(48,49,50,51)
    new_marks2 <- compassionate_function(marks2)
    new_marks2 #[1] 49 50 50 51
    mean(new_marks2) # 50
