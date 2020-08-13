
## ===============================================================
##  Supplementary 
### Decision Tree - growing & pruning a classification tree
### - Using Phone Dataset
## ===============================================================

##  =============================
##  Part 1 - growing the tree
##  =============================

    ##  Setwd and Load dataset
    ##  ------------------------
          setwd("~/Desktop/R_Projects/Class4/Data")
          phone <- read.csv("phone.csv")
          View(phone)

 
    ##  Objective:
    ##  ------------------------
        ### we will predict whether a customer will abandon the company
        ### the target variable is churn (1 - yes, 0 - no)
        ### the predictors are tenure, age, income, education and family members

          
    ##  (1) Load Decision Tree Packages
    ##  -------------------------------
          require(rpart)
          
          require(rpart.plot)

          
    ##  (2) create the training set and the test set
    ##  ---------------------------------------------
          set.seed(1000) # set seed for reproducibility
          
          i <- sample(1000, 500)
          
          phone_train <- phone[i,]
          
          phone_test <- phone[-i,]

          
    ##  (3) Grow Decision Tree - ("Classification Trees" Method)
    ##  ------------------------------------------------------------
        ### grow the classification tree with the rpart() function
        ### the method parameter must be set to "class"

          fit <- rpart(churn~., data = phone_train, method = "class")

?rpart          
    ##  (4) plot the tree
    ##  ------------------------------------------------------------
          ##  (a) Method 1 -- plot the tree with the prp() function
          ##  -----------------------------------------------------
              prp(fit)
      
            
          ##  (b) Method 2 -- plot the tree with the rpart.plot() function
          ##  ------------------------------------------------------------          
              #rpart.plot(fit)
              rpart.plot(fit, cex=0.49)  
              ##  *Comments:
              ##    - root node: consists of 100% of total sample; it is predicted that 27% will abandon the company; 
              ##      73% will not (since it is > 50% => we predicted that overall root node (entire sample) is "0" i.e. 
              ##      we predicted that the customers will not abandon the company)
          
              ##    - on the left branch of the root node, we have the customers with tenure >=31; on the right branch we have 
              ##      customers with tenure <31
          
              ##    - first terminal node: we have 57% of total customer population. We predicted that this group will not 
              ##      abandon the company (why? because the node is "0". why? because we predicted that only 13% of this group
              ##      will abandon the company. Since this is less than 50%, our prediction is that they will not abandon (hence, "0"))
              
              ##    - sixth terminal node: we have 3% of total customer population. We predicted that this group will abandon 
              ##      the company (since the predicted result is "1"). We predicted that 79% of this population will abandon. Since
              ##      this is greater than 50%, therefore the overall predicted result is "1" (i.e. abandon)

          
          
    ##  (5) print the CP table (complexity parameter table)
    ##  ---------------------------------------------------
          
              printcp(fit)
                  # Classification tree:
                  #   rpart(formula = churn ~ ., data = phone_train, method = "class")
                  # 
                  # Variables actually used in tree construction:
                  #   [1] age     educ    income  members tenure 
                  # 
                  # Root node error: 136/500 = 0.272
                  # 
                  # n= 500 
                  # 
                  #         CP nsplit rel error  xerror     xstd
                  # 1 0.062500      0   1.00000 1.00000 0.073164
                  # 2 0.058824      2   0.87500 1.02941 0.073823
                  # 3 0.036765      3   0.81618 1.00735 0.073331
                  # 4 0.014706      4   0.77941 0.98529 0.072823
                  # 5 0.010000      9   0.70588 1.02206 0.073661

         ## *Comment:
          ##  . error = (last rel error)*(root node error) = (0.70588)*(0.272) = 0.191999
          ##  . prediction accuracy in training set = 1 - error = 1 - 0.191999 =  0.808001
          
          
    ## (4) compute the predictive accuracy in the training set 
    ##  ---------------------------------------------------------
      ### the type parameter must be set to "class"
      
      pred <- predict(fit, phone_train, type = "class")
          
      mean(pred == phone_train$churn) #[1] 0.808 (same as what we manually calculated)
      

    ##  (5) compute the predictive accuracy in the test set
    ##  ----------------------------------------------------------
      # pred2 <- predict(fit, phone_test, type = "class")
      pred2 <- predict(fit, phone_test[,-6], type = "class") # if wish to hide the answer (in col 6)
      
      mean(pred2 == phone_test$churn) #[1] 0.736
          ## *Comment: 
          ##  . predictive accuracy in test set lower than training set
          ##  . => problem with handling new data
      

##  ===========================
##  Part 2 -- Prune the tree
##  ===========================
      ##  (1) we will prune the tree with the prune() function
      ##  ----------------------------------------------------
      ### extract the cp corresponding to the
      ### lower cross-validation error
      printcp(fit)
      ocp <- fit$cptable[which.min(fit$cptable[,"xerror"]),"CP"]
      
      ocp #[1] 0.01470588
          
      
      prfit <- prune(fit, ocp)
      
      rpart.plot(prfit, cex = 0.6)
      
      
      ##  (2) compute the prediction accuracy in the test set
      ### for the pruned tree
      ##  ---------------------------------------------------
      prpred <- predict(prfit, phone_test, type = "class")
      
      mean(prpred == phone_test$churn) #[1] 0.748 (we get a slightly higher accuracy)
      
     
      
  