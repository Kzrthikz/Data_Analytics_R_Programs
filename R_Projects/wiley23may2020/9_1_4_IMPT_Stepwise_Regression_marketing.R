##  =======================================================================================================
##  REGRESSION
##  - STEPWISE REGRESSION  - (Example 2 - MARKETING DATASET)
##  =======================================================================================================
getwd() 
        setwd("~/Desktop/R_Projects/Class 3 /Data")
    
    ##  Load Data
        marketing <- read.csv("marketing.csv", header = TRUE, na.strings=c('','.','NA'))
        View(marketing)
    
    ##  (1) Use Stepwise Approach to build model (backward)
    ##  ---------------------------------------------------
        # install.packages("MASS")
        library(MASS)
        
      ## Method 1: backward stepwise regression
      ##  ----------------------------------------
        full_model <- lm(sales ~ . , data = marketing) ## starts with a full model
        
        backward_step.model <- stepAIC(full_model, direction = "backward") 
        
        formula(backward_step.model)     #sales ~ youtube + facebook

        
        
      ## Method 2: forward step-wise regression  
      ##  ---------------------------------
        intercept_model <- lm(sales~1, data= marketing)  ## starts with the intercept model
        
        forward_step.model <- stepAIC(intercept_model, 
                                      direction="forward", 
                                      scope=list(lower=intercept_model, 
                                                 upper=~newspaper+youtube+facebook))
        
        formula(forward_step.model)    #sales ~ youtube + facebook
        
        
        
      ##  Method 3: "both"
      ##  -----------------
        model_between <- lm(sales~newspaper, data=marketing) ## starts with an assumed model (neither full nor intercept model)
        
        both_model3 <- stepAIC(model_between, 
                               direction="both", 
                               scope=list(lower=intercept_model, 
                                          upper=~newspaper+youtube+facebook))
        
        formula(both_model3)   #sales ~ youtube + facebook
        
 
    
        
## Comment: 
##  . note that the best model is automatically selected through the step-wise procedure.
##  . the best model is selected based on lowest AIC.        
