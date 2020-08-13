##  =========================================================
##  k-Means Clustering - Manual Calculation Comparison
##  =========================================================

##  1. Create data and visualise plot
##  -------------------------------------
    iris_data <- data.frame(
      Petal.Length = c(4.5, 4.7, 4.6, 4.8, 4.9, 4.5),
      Petal.Width = c(1.6, 1.5, 1.4, 1.8, 1.8, 1.7)
    )
    
    iris_data

    
    ## Visualise data
    library(ggplot2) #install.packages("ggplot2")
    ggplot(iris_data, aes(x = Petal.Length, y = Petal.Width)) + 
      geom_point()
    

##  2. Load libraries   
##  ----------------------------    
    library(tidyverse)  # data manipulation
    library(cluster)    # clustering algorithms
    library(factoextra) # clustering algorithms & visualization
    
    
##  3. Create Clusters
##  -----------------------------    
    set.seed(101)

    k2 <- kmeans(iris_data, centers=2, nstart = 20) 
        ## *we pass the first 4 columns; 3 species;  nstart is the number of random start (here = 20)
    k2
    
    
    ##  Visualise clusters
    fviz_cluster(k2, data = iris_data)
    