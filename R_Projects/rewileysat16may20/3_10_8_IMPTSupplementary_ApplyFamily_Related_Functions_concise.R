##  ======================================================================
##  Supplementary Exercises:
##  - Apply family and related functions 
##  ======================================================================
##  Apply -- to manipulate slices of data from matrices, lists and dataframes in a repetitive way.
##        -- cannot work with vectors per se.

    ##  Generate X matrix
    ##  --------------------------------    
        X <- matrix(1:4, nrow=2,ncol=2)
        X
              #       [,1] [,2]
              # [1,]    1    3
              # [2,]    2    4
        
    ##  Generate Y List
    ##  --------------------------------         
        Y <- list(a=1:2, b=3:4)
        Y
              # $a
              # [1] 1 2
              # 
              # $b
              # [1] 3 4
        
     
    ##   generate dataframe counts_df
    ##  -------------------------------
        counts_df <- data.frame(
          sparrow = c(3,2,4),
          dove = c(6,5,1),
          crow = c(8,6,1),
          gender = c("m","f","m")
        )
        
        counts_df
              #     sparrow dove crow gender
              # 1       3    6    8      m
              # 2       2    5    6      f
              # 3       4    1    1      m
        
 
        
## ============================================================================================
##  apply() Function
##    - select specific column / row, based on condition (e.g. max/min/average/sum)
## ============================================================================================
  ##  . if we wish to avoid NA values, we use na.rm=TRUE e.g. apply(df,2,max,na.rm=TRUE)
  ##  . select row/column based on conditions (e.g. max/min/average/sum);
  ##      . MARGIN=1 (=>row); MARGIN=2 (=>col); 
  ##      . you can also define your own function and use it as a condition for 
  ##        apply (e.g. is.matrix(x))
      X
            #       [,1] [,2]
            # [1,]    1    3
            # [2,]    2    4
          
      apply(X, MARGIN=2, sum) #[1] 3 7
        
      apply(X, MARGIN=1, sum) #[1] 4 6
      
      



##  ==============================================================================================
##  lapply() Function
##  . apply function/operation to EACH ELEMENT --> output as LIST (with SAME LENGTH as input list)
##  . same as sapply, except output as list (and not vector) => "l" in lapply
##  ==============================================================================================
    ##  (1) Process each element
    ##  ------------------------
           X
               #       [,1] [,2]
               # [1,]    1    3
               # [2,]    2    4
       
          multiply_2 <- function(y)
          {
            (y)*2
          }
      
          lapply(X, multiply_2) 
                # [[1]]
                # [1] 2
                # 
                # [[2]]
                # [1] 4
                # 
                # [[3]]
                # [1] 6
                # 
                # [[4]]
                # [1] 8
          
          Y
                # $a
                # [1] 1 2
                # 
                # $b
                # [1] 3 4
          
          lapply(Y, mean)
                # $a
                # [1] 1.5
                # 
                # $b
                # [1] 3.5

      
          

          
## =======================================================================
##  SAPPLY 
##    - apply function/operation to each element --> output as vector
##    - similar to lapply, except that output is vector (instead of list)    
## =======================================================================
  ## multiply each elements in matrix by 2 --> output into a vector
      sapply(X, multiply_2)
      # [1] 2 4 6 8
          
          
## =========================================================================
## TAPPLY 
##    - examine specific column, by factor cut, after applying function/operation
## =========================================================================
      counts_df    
              #     sparrow dove crow gender
              # 1       3    6    8      m
              # 2       2    5    6      f
              # 3       4    1    1      m
          
## Using Tapply to zoom into specific column by factor cut, and apply median function    
    tapply(counts_df$sparrow, INDEX=counts_df$gender, median) #INDEX: list containing factor (for applying function)
          # f   m 
          # 2.0 3.5

    