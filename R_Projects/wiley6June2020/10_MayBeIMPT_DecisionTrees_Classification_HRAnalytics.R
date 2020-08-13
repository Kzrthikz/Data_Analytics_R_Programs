##  ===================================================
##  Decision Tree - Why people leave
##  - using HR Data for Analytics dataset from Kaggle
##  - script source: https://rpubs.com/brenborbs/312639
##  ===================================================

##  1. Load data
##  -------------
getwd()
    setwd("/Users/karthika/Desktop/R_Projects/Class5")

    hr <- read.csv("HR_comma_sep.csv", header=T, na.strings=c('','.','NA'))

    View(hr) 
    
    str(hr)
        # 'data.frame':	14999 obs. of  10 variables:
        # $ satisfaction_level   : num  0.38 0.8 0.11 0.72 0.37 0.41 0.1 0.92 0.89 0.42 ...
        # $ last_evaluation      : num  0.53 0.86 0.88 0.87 0.52 0.5 0.77 0.85 1 0.53 ...
        # $ number_project       : int  2 5 7 5 2 2 6 5 5 2 ...
        # $ average_montly_hours : int  157 262 272 223 159 153 247 259 224 142 ...
        # $ time_spend_company   : int  3 6 4 5 3 3 4 5 5 3 ...
        # $ Work_accident        : int  0 0 0 0 0 0 0 0 0 0 ...
        # $ left                 : int  1 1 1 1 1 1 1 1 1 1 ...
        # $ promotion_last_5years: int  0 0 0 0 0 0 0 0 0 0 ...
        # $ sales                : Factor w/ 10 levels "accounting","hr",..: 8 8 8 8 8 8 8 8 8 8 ...
        # $ salary               : Factor w/ 3 levels "high","low","medium": 2 3 3 2 2 2 2 2 2 2 ...
    
    #if u see char: 
    # hr$sales <- as.factor(hr$sales)
    # hr$salary <- as.factor(hr$salary)
    
    nrow(hr) #[1] 14999 huge data set 
    
    colnames(hr)
        # [1] "satisfaction_level"    "last_evaluation"       "number_project"        "average_montly_hours" 
        # [5] "time_spend_company"    "Work_accident"         "left"                  "promotion_last_5years"
        # [9] "sales"                 "salary" 
    
    
##  2. Create Tree
##  ---------------------
    require(rpart.plot)

    set.seed(1234) # set seed for reproducibility
    
    ##  (a) Create training 80% and testing set
    ##  -------------------------------------
    index <- sample(nrow(hr), round(0.8*nrow(hr)))
    
    hr_train <- hr[index,]
    
    hr_test <- hr[-index,]    
    View(hr_train)
    
    ##  (b) train decision tree using only training model. Using shorthand. ~. use all col except left to predict left. 
    ##  ------------------------------------ 
    # Method = classification 
    trained_model <- rpart(left~., data = hr_train, method = "class")
    
        ## (b.1) predict using trained model on training set
        ##  ------------------------------------------------
        #"Like cheating" want to get a baseline. -7: drop 7th col which is left col. 
          pred.train <- predict(trained_model, hr_train[,-7], type = "class")
          
          mean(pred.train == hr_train$left) #[1] 0.9685807 quite high. 

    
          
        ##  (b.2) predict using trained model on testing set (unseen data)
        ##  ----------------------------------
          # Typically we work on this. 
          pred.test <- predict(trained_model, hr_test[,-7], type = "class")
      
          mean(pred.test == hr_test$left) #[1] 0.968 Drop is insignificant. Do not need to prune tree. Overfitting issue. 
        
        ##  Comment: This is a very high accuracy
    
    
    ##  (c) Plot the decision tree
    ##  ------------------------------
    rpart.plot(trained_model, cex=0.54)
    
    
##  Comment:
##  ---------
##  Profile 1 of people who left:
##  . if they stayed less than 7 years;
##  . if they spent > 217 average monthly hours (over worked)
##  . if they received > 0.82 in their last evaluation (high performers) 
    
##  Profile 2 of people who left:
##  . if they have satisfaction level < 0.47 (disastisfied people)
    
## Profile 3 of people who left:    
##  . If they are disastisfied, and
##  . had less than 3 projects and
##  . mid-scorer in their last eval (<0.58, >0.45).   