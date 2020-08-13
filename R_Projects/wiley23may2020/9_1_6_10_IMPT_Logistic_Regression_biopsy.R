##  ================================
##  Logistic Regression
##  - biopsy data from MASS library
##  ================================
  
##  1. Load library and data
##  --------------------------------
    library(MASS) # install.packages("MASS")

    data("biopsy")
    
    str(biopsy)    
        #'data.frame':	699 obs. of  11 variables:
        # $ ID   : chr  "1000025" "1002945" "1015425" "1016277" ...
        # $ V1   : int  5 5 3 6 4 8 1 2 2 4 ...
        # $ V2   : int  1 4 1 8 1 10 1 1 1 2 ...
        # $ V3   : int  1 4 1 8 1 10 1 2 1 1 ...
        # $ V4   : int  1 5 1 1 3 8 1 1 1 1 ...
        # $ V5   : int  2 7 2 3 2 7 2 2 2 2 ...
        # $ V6   : int  1 10 2 4 1 10 10 1 1 1 ...
        # $ V7   : int  3 3 3 3 3 9 3 3 1 2 ...
        # $ V8   : int  1 2 1 7 1 7 1 1 1 1 ...
        # $ V9   : int  1 1 1 1 1 1 1 1 5 1 ...
        # $ class: Factor w/ 2 levels "benign","malignant": 1 1 1 1 1 2 1 1 1 1 ...
    
    head(biopsy,3)
        #       ID V1 V2 V3 V4 V5 V6 V7 V8 V9  class
        # 1 1000025  5  1  1  1  2  1  3  1  1 benign
        # 2 1002945  5  4  4  5  7 10  3  2  1 benign
        # 3 1015425  3  1  1  1  2  2  3  1  1 benign
    
    View(biopsy)
    nrow(biopsy)
    
##  2. Pre-processing
##  ---------------------------------
    ##  (a) get rid of "ID" column
    ##  -----------------------------
    biopsy$ID <- NULL
    
    
    ##  (b) rename the variables
    ##  ----------------------------
    ?biopsy
    
    names(biopsy) <- c("thick", "u.size", "u.shape", "adhsn", "s.size", 
                       "nucl", "chrom", "n.nuc", "mit", "class")

    names(biopsy) #[1] "thick"   "u.size"  "u.shape" "adhsn"   "s.size"  
                  #"nucl"    "chrom"   "n.nuc"   "mit"     "class"   
    
    
    ##  (c) delete missing observations
    ##  ---------------------------------
    biopsy.v2 <- na.omit(biopsy)

 
##  3.  Create training and testing data
##  ----------------------------------------------------
    nrow(biopsy.v2) #[1] 683    
    set.seed(123)
    index <- sample(nrow(biopsy.v2), round(0.7*nrow(biopsy.v2)))
    train <- biopsy.v2[index,]
    test <- biopsy.v2[-index,]
          # View(train)
          # View(test)
    
##  4. create the model on training data
##  ---------------------------------------------------
    train_model <- glm(class~. , family=binomial, data=train)

    
##  5. Fit the trained model on testing data
##  -----------------------------------------------------
    pred.probs <- predict.glm(train_model,           # trained model
                              newdata = test[,-10], # using testing data set; dropping the 10th col
                              type = "response")
    
    ?predict.glm
##  6. create a cut-off measure to interpret the probability
##  ------------------------------------------------------
    pred <- ifelse(pred.probs<mean(pred.probs),"benign","malignant")
    
    
##  7.    Build a classification table (confusion matrix) to assess accuracy
##  -------------------------------------------------------- -----------------    
    table(actual = test$class, predicted = pred)  
          #           pred
          #           benign malignant
          # benign       128         3
          # malignant      0        74
    
  
    accuracy <- mean(pred == test$class)  
    accuracy          #     0.9853659
    
    (misclassification = 1 - accuracy) #[1] 0.01463415
    
    