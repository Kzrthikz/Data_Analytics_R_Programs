##  =========================================================================
##  SVM - Linear,polynomial, radial kernels with tuning
##  - using svm_data1.csv dataset (artificial dataset)
##  
##  =========================================================================

##  1. Load data
##  -----------------
getwd()
    setwd("/Users/karthika/Desktop/R_Projects/Class5")
    nonlineardata <- read.csv("svm_data1.csv", header=T, na.strings = c('','.','NA'))
    View(nonlineardata) 



##  2. Visualise data
##  ------------------
    # install.packages("ggplot2")
    library(ggplot2)
    
    ggplot(data=nonlineardata, aes(x=x2, y = x1, color=factor(y))) + geom_point()
    
    ## note that the points is such that it is difficult to separate y into different
    ## classes using linear kernel

    
##  3. Split data into training-testing set
##  -----------------------------------------    
    nrow(nonlineardata) #87
    
    set.seed(123)
    index <- sample(nrow(nonlineardata), round(0.8*(nrow(nonlineardata))))
    train <- nonlineardata[index,]    
    test <- nonlineardata[-index,]   
    View(train)
    View(test)
    
## =============================
## Part I - SVM with No Tuning
##  ============================    
    

##  (A) using linear kernel
##  =======================
    # install.packages("e1071")
    library(e1071)
    
    ##  (a) Create svm model
    svm_linear <- svm(y~.,
                          data = train,
                          type = "C-classification",
                          cost = 1,
                          kernel = "linear"
                     )
    
    ##  (b) predict using trained model
    pred <- predict(svm_linear, test)
    
    mean(pred == test$y) #[1] 0.8823529
    
    ## (c) Visualise model
    plot(svm_linear, data = nonlineardata) #on entire dataset
    plot(svm_linear, data = train) # on training set
    plot(svm_linear, data = test)  # on testing set
    
    
##  (B) Using polynomial kernel
##  ============================
    library(e1071)
    
    ##  (a) Create svm model
    svm_polynomial <- svm(y~.,
                          data = train,
                          type = "C-classification",
                          cost = 1,
                          kernel = "polynomial",
                          degrees = 2
                          )
    
    ##  (b) predict using trained model
    pred <- predict(svm_polynomial, test)

    mean(pred == test$y) #[1] 0.9411765
    
    
    ## (c) Visualise model
    plot(svm_polynomial, data = nonlineardata) # on full dataset
    plot(svm_polynomial, data = train) # on training set
    plot(svm_polynomial, data = test) # on testing set
    


##  (C) Using a radial kernel
##  ============================
    library(e1071)
    
    ##  (a) Create svm model
    svm_radial <- svm(y~.,
                      data = train,
                      type = "C-classification",
                      cost = 1,
                      kernel = "radial",
                      gamma = 0.01
                      )
    
    ##  (b) predict using trained model
    pred <- predict(svm_radial, test)

    mean(pred == test$y) #[1] 0.8823529
    
    ## (c) Visualise model
    plot(svm_radial, data = nonlineardata) # full data set
    plot(svm_radial, data = train)  # on training set
    plot(svm_radial, data = test) # on testing set
    
    
    ## Comment:
    ## - despite that points are non-linearly separable, our linear model performs well
    ## - this is because the SVM model is based on a "soft-margin" classifier.


    
    

## ===============================
##  Part II -  SVM with  Tuning   
##  ==============================
 
## (A) using Linear Kernel
##  ========================
    library(e1071)
    
    ##  (a) Tuning the linear kernel SVM model
    ##  --------------------------------------
    set.seed(123) #more consistent answers 
    tuned_svm_linear <- tune.svm(y~., 
                      data = train, 
                      cost = c(0.052, 0.054, 0.056, 0.058, 0.060, 0.062, 0.064, 0.066, 0.068, 0.07), 
                      kernel = "linear")
    
    tuned_svm_linear$best.parameters
          # cost
          # 1 0.052
    
    
    ##  (b) Insert tuned parameters into model & recalculate
    ##  -----------------------------------------------------
    tuned_svm_linear <- svm(y~.,
                      data = train,
                      type = "C-classification",
                      cost = 0.052,
                      kernel = "linear")
    
    ##  (c) predict, check accuracy and visualise svm
    ##  -----------------------------------------------------
    pred <- predict(tuned_svm_linear, test)
    
    mean(pred == test$y)  #[1] 0.9411765
        ## Linear model improved
    
    plot(tuned_svm_linear, data = nonlineardata)    # full dataset
    plot(tuned_svm_linear, data = train) # on training set
    plot(tuned_svm_linear, data = test) # on testing set
    
    
    
##  (B) Using polynomial kernel
##  ============================

    ##  (a) Tuning the polynomial kernel SVM model
    ##  --------------------------------------
    set.seed(111)
    tuned_svm_polynomial <- tune.svm(y~., 
                                 data = train, 
                                 cost = c(0.5, 1.0, 1.5, 2.0, 2.5, 3, 3.5, 4.0, 4.5, 5.0),
                                 kernel = "polynomial",
                                 # degree = c(1.5, 2.0, 2.5)
                                 degree = 2:5 #range from 2 to 5
                                 , coef0=c(1,2,3,4)  ## used in polynomial and sigmoid kernels to overcome limitations, by properly scaling data. 
                                 )                  ## (powers of values smaller than one gets closer and closer to 0, while the same power of value bigger than one grows to infinity)
    # ?svm
    tuned_svm_polynomial$best.parameters # most optimal tuning parameters. degree = 5, coef0 = 2, cost = 0.5 

    
    
    ##  (b) Insert tuned parameters into model & recalculate
    ##  -----------------------------------------------------
    tuned_svm_polynomial <- svm(y~.,
                            data = train,
                            type = "C-classification",
                            # cost = 3.5,
                            cost = 0.5,
                            kernel = "polynomial",
                            degree = 5
                             ,coef0 = 2
                            )
    
    
    
    ##  (c) predict, check accuracy and visualise svm
    ##  -----------------------------------------------------
    pred <- predict(tuned_svm_polynomial, test)
    
    mean(pred == test$y)  
    
    plot(tuned_svm_polynomial, data = nonlineardata)  
    plot(tuned_svm_polynomial, data = train)
    plot(tuned_svm_polynomial, data = test)
    
    
    ##  (B) Using a radial kernel
    ##  ============================
    library(e1071)
    
    ##  (a) Tuning the radial kernel SVM model
    ##  --------------------------------------
    set.seed(111)
    tuned_svm_radial <- tune.svm(y~., 
                                     data = train, 
                                     cost = c(1.8, 2.0, 2.2, 2.4, 2.6, 2.8, 3.0, 3.2, 3.4, 3.6, 3.8, 4.0, 4.2), 
                                     kernel = "radial",
                                     gamma = c(0.001, 0.01, 0.10, 1, 10))
    
    tuned_svm_radial$best.parameters # gamma = 1, cost = 1.8 
     
    
    
    ##  (b) Insert tuned parameters into model & recalculate
    ##  -----------------------------------------------------
    tuned_svm_radial <- svm(y~.,
                                data = train,
                                type = "C-classification",
                                cost = 1.8,
                                kernel = "radial",
                                gamma = 1)
    
  
    
    ##  (c) predict, check accuracy and visualise svm
    ##  -----------------------------------------------------
    pred <-predict(tuned_svm_radial, test)
    
    mean(pred == test$y)  #[1] 1
    ## our radial model improved!
    
    plot(tuned_svm_radial, data = nonlineardata)  
    plot(tuned_svm_radial, data = train)
    plot(tuned_svm_radial, data = test)
    
    ## Comment:
    ##  - accuracy of svm models is very sensitive to the data and the kernel used for classification  
    ##  - tuning can significantly improve our model 
