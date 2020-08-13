##  ===========================================================================
##  K-means Clustering ; Elbow Method (others) - age-spend data
##  Modified from source: https://www.guru99.com/r-k-means-clustering.html
##  ===========================================================================

##  ==========================
##  Part 1 - Kmeans - Basics
##  ==========================

##  1. Create and Visualise data
##  --------------------------------
  df <- data.frame(age = c(18, 21, 22, 24, 26, 26, 27, 30, 31, 35, 39, 40, 41, 42, 44, 46, 47, 48, 49, 54),
                   spend = c(10, 11, 22, 15, 12, 13, 14, 33, 39, 37, 44, 27, 29, 20, 28, 21, 30, 31, 23, 24)
  )
  df
  library(ggplot2)
  ggplot(df, aes(x = age, y = spend)) + geom_point()
  
  
  
##  2.  Create kmeans clusters
##  --------------------------
  ##  (a) Load Libraries
  # install.packages("tidyverse")
  # install.packages("cluster")
  # install.packages("factoextra")
  library(tidyverse)  # data manipulation
  library(cluster)    # clustering algorithms
  library(factoextra) # clustering algorithms & visualization
  
  
  ## (b) Create kmeans models
  set.seed(2)
  k2model <- kmeans(df[,c("age", "spend")], centers=2, nstart=10) ## k = 2
  
  set.seed(1)
  k3model <- kmeans(df[,c("age", "spend")], centers=3, nstart=10) ## k = 3
  
  set.seed(12)
  k4model <- kmeans(df[,c("age", "spend")], centers=4, nstart=10) ## k = 4

  
  ## (c) Visualise CLusters
  fviz_cluster(k2model, data = df)
  fviz_cluster(k3model, data = df)
  fviz_cluster(k4model, data = df)
  
  
  
##  =================================  
##  Part 2 -- Determining optimal k  
##  =================================
##  1. Elbow Method
##  ---------------  
  set.seed(123) # for reproducibility
  fviz_nbclust(df, FUN=hcut, method = "wss")   
  
  
  
##  2. Average Silhouette Method
##  ---------------------------------
  fviz_nbclust(df, FUN=hcut, method = "silhouette")
  
  
##  3. Gap Statistics
##  --------------------------------
  set.seed(123)
  gap_stat <- clusGap(df, FUN = hcut, nstart = 25,
                      K.max = 10, B = 50)
  ##  Print the result
  print(gap_stat, method = "firstmax")
  
  ##  Visualise gap statistics plot
  fviz_gap_stat(gap_stat)
  