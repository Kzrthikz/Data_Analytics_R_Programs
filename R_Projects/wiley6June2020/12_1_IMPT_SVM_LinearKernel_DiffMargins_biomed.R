##  =========================================================================
##  SVM - Linear Kernel; comparing between narrow vs wide margins
##  - using biomed.csv dataset
##  Source: "Knowledge discovery with Support vector machines; Lutz Hamel"
##  =========================================================================

##  1. Load data
##  -----------------
getwd()
    setwd("/Users/karthika/Desktop/R_Projects/Class5")
    biomed <- read.csv("biomed.csv", header=T, na.strings = c('','.','NA'))
    View(biomed) 
    colnames(biomed) #[1] "Systolic.Blood.Pressure" "White.Blood.Count"       "Diagnosis"
    str(biomed) # Has to be a factor 
      # biomed$Diagnosis <- as.factor(biomed$Diagnosis)
    
##  2. Visualise data    
##  ---------------------
    library(ggplot2) # install.packages("ggplot2")
    ggplot(data = biomed, aes(x = White.Blood.Count, 
                              y = Systolic.Blood.Pressure, 
                              color=factor(Diagnosis))) + 
      geom_point()
      
    ## Note that the points are linearly separable.
    ##  Hence using a linear kernel may be a good idea.
    
    
        
##  3. Create Models and Visualise results
##  ---------------------------------------    
        
##  (A) Narrow Margin
##  ====================   
##  (a) Create SVM Model with Linear Kernel, large cost (=> narrow margin)
##  -------------------------------------------------------------------
    #install.packages("e1071")
    library(e1071)
    
    #~. predict all the col of diagnosis except diagnosis. 
    # 1.0 is a large c to get a small margin 
    # Train model 
    svm.narrow.margin <- svm(Diagnosis~., 
                     data = biomed,
                     type = "C-classification",
                     cost = 1.0,
                     kernel = "linear")

    
##  (b) Prediction from fitted model
##  ---------------------------------------    
    pred <- fitted(svm.narrow.margin)    
    pred == biomed$Diagnosis   # TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
    mean(pred == biomed$Diagnosis) #  1 ==> all data fitted correctly, 100% accuracy : narrow margin --> better accuracy 
    
    
##  (c)  Visualised fitted model
##  -----------------------------
    plot(svm.narrow.margin, 
         biomed)

    
##  (B) Wide Margin
## ===================   
    ##  (a) Create SVM Model with Linear Kernel, Small cost (=> Wide margin)
    ##  -------------------------------------------------------------------
    library(e1071)
    
    svm.wide.margin <- svm(Diagnosis~., 
                             data = biomed,
                             type = "C-classification",
                             cost = 0.045,
                             kernel = "linear")
    
    
    ##  (b) Prediction from fitted model
    ##  ---------------------------------------    
    pred <- fitted(svm.wide.margin)    
    pred == biomed$Diagnosis   # TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE FALSE  TRUE
    mean(pred == biomed$Diagnosis) #  0.8888889 ==> not all data fitted correctly
    
    
    ##  (c)  Visualised fitted model
    ##  -----------------------------
    plot(svm.wide.margin, 
         biomed)    
    
##  Comment:
##  - with Narrow Margin (i.e. high cost) --> more accuracy (note: 2 support vectors with 'x')
##  - with wide margin (i.e. low cost) --> less accuracy with some misclassifications
##    (note: all points in wide margin case are support vectors)
    
     