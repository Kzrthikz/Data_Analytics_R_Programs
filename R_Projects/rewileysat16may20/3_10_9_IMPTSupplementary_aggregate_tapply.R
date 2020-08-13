##  ========================================
##  Useful functions for data wrangling
##  - aggregate
##  ========================================

##  1. dataset
##  -------------
    ?iris
    View(iris)
    head(iris,2)
          #  Sepal.Length Sepal.Width Petal.Length Petal.Width Species
          # 1          5.1         3.5          1.4         0.2  setosa
          # 2          4.9         3.0          1.4         0.2  setosa

    unique(iris$Species)
        # [1] setosa     versicolor virginica 
        # Levels: setosa versicolor virginica
    
    length(unique(iris$Species)) #3
    
    str(iris)
    
##  2. Using Aggregate Function to  compute summary statistics
##  -------------------------------------------------------------------
    ## aggregate(x, by, FUN)
    
    aggregate(iris[,1:4], by=list(iris$Species), FUN=mean, na.rm=T)
        #       Group.1 Sepal.Length Sepal.Width Petal.Length Petal.Width
        # 1     setosa        5.006       3.428        1.462       0.246
        # 2 versicolor        5.936       2.770        4.260       1.326
        # 3  virginica        6.588       2.974        5.552       2.026


    
##  3.  Using tapply (if we only wish to analyse 1 column e.g. Sepal.Length)
##  ------------------------------------------------------------------------
    tapply(iris$Sepal.Length, INDEX=iris$Species, FUN = mean)
        # setosa versicolor  virginica 
        # 5.006      5.936      6.588 
    

   
    