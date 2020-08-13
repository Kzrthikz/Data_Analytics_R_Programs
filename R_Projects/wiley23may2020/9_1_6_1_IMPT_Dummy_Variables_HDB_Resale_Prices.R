##  ====================================================
##  Creating Dummy Variables
##  - Using HDB Resale Prices (downloaded on 7 Aug 2019)
##  ====================================================

##  1. Set working directory and load data
##  ----------------------------------------
    setwd("~/Desktop/R_Projects/Class 3 /Data")

    data <- read.csv("hdb_resale_price_Aug2019.csv", header=T, na.strings=c('','.','NA'))
        ## data.gov.sg --> hdb resale price (get the latest data)
    View(data)    

    
##  2. Data Preprocessing I       
##  -------------------------
    data2 <- data[,c(3,7,11)]  # get only selected columns we wanted
    View(data2)
    str(data2)  # "flat_type" column is a factor; while rest are numeric
    
                # data2$flat_type <- as.factor(data2$flat_type)
    
    levels(data2$flat_type)
        # [1] "1 ROOM"           "2 ROOM"           "3 ROOM"           "4 ROOM"           "5 ROOM"          
        # [6] "EXECUTIVE"        "MULTI-GENERATION"
    
    
      ##  Comment:
      ##  --------
      ##  . There are 7 categorical variables. We need to create only 6 dummy variables. 
      ##  . Note: it is always n-1 dummies if there are n variables in total.
    
##  =========================================================================================
##  Method 1: Doing the regression as per normal - keeping qualitative variables as factors 
##  =========================================================================================
    ##  Note: Dummy variables are automatically created using this method
    
    library(MASS) ## install.packages("MASS")
    full_model1 <- lm(resale_price ~ . , data = data2) ## starts with a full model
    
    backward_step.model1 <- stepAIC(full_model1, direction = "backward") 
    
    formula(backward_step.model1)
    summary(backward_step.model1)
    
    
##  ==================================================
##  Method 2: Manually create the dummy variables
##  ==================================================
    ## we have more control over which dummy variables to drop in this approach
    
##  3.  create dummies
##  -------------------------------------------------------
    ##  (a) Using "dummies" package to create dummies
    ##  ---------------------------------------------------------------------
        # install.packages("dummies")
        library(dummies)
?dummy
        data2 <- cbind(data2, dummy(data2$flat_type, sep = "_"))
        
        View(data2)
            
            
    ##  (b) delete last dummy, and re-order cols
    ##  ----------------------------------------------------
        data2 <- data2[, c(-1,-10)] # drop first and last col
        data2 <- data2[,c(1,3,4,5,6,7,8,2)] # re-order cols
        
        
        
##  4.  create multi-linear regression
##  -------------------------------------------------------
        # install.packages("MASS")
        library(MASS)
        
        full_model2 <- lm(resale_price ~ . , data = data2) ## starts with a full model
        
        backward_step.model2 <- stepAIC(full_model2, direction = "backward") 
        
        formula(backward_step.model2) 

        summary(backward_step.model2) #p-value: < 2.2e-16; Adjusted R-squared:  0.4134
        