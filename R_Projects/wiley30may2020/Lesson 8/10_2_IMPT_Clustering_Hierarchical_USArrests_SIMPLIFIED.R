##  ==================================================
##  Hierarchical Clustering - hclust() and agnes()
##  - US Arrests (Simplified version)
##  ==================================================


##  1.  Load essential packages
##  -----------------------------
    library(tidyverse)  # data manipulation; install.packages("tidyverse")
    library(cluster)    # clustering algorithms; install.packages("cluster")
    library(factoextra) # clustering visualization; install.packages("factoextra")
    library(dendextend) # for comparing two dendrograms; install.packages("dendextend")


##  2.  Load data and preprocessing
##  -----------------------------------
    df <- USArrests #    ?USArrests; View(df)

    df <- na.omit(df) # removing missing values

    df <- scale(df) ## scaling can reduce the dependency on an arbitrary variable unit


##  =====================================
##  (A) Hierarchical Clustering Methods  
##  =====================================    

##  1.  Agglomerative Hierarchical Clustering
##  -----------------------------------------
##  Method 1: using hclust [in stats package]
##  ------------------------------------------
    ##  Compute the dissimilarity values with dist --> feed into hclust --> plot dendrogram

    ##  (a) Dissimilarity matrix
    d <- dist(df, method = "euclidean") 

    
    ##  (b) Hierarchial clustering using Complete Linkage
    hc1 <- hclust(d, method = "complete") 
        ##?hclust   ; 
        ## other methods: "ward.D" ; "ward.D2"; "single", "complete", "average", 
        ##                 "mcquitty"; "median", "centroid"

    
    ##  (c) Plot the dendrogram
    plot(hc1, cex = 0.6, hang = -1) 
        ## hang: fraction of plot height which labels should hang below rest of plot
        ##       -ve value will cause labels to hang down from 0



    
##  Method 2: using agnes [in cluster package]
##  ------------------------------------------    
    ##  we can achieve the same using agnes function. This function can get the 
    ##  agglomerative coefficient that measures amount of clustering structure
    ##  (values closer to 1 => strong clustering structure --> we can then assess the
    ##  strongest clustering structure based on the different methods)
    
    ##  Option 1  : use plot() on agnes()  
    ##  ------------------------------------------
    plot(agnes(df, diss=FALSE, metric="euclidan")) 


    ## Option 2  : use pltree() on agnes() 
    ##  --------------------------------------------------------
    hc2 <- agnes(df, method = "complete")
    pltree(hc2, cex = 0.6, hang = -1, main="Dendrogram of agnes")
       
    
    
    
    
##  ===========================================    
##  SUPPLEMENTARY: More Fine-tuning on agnes()
##  ===========================================    
    
  
## 1. Agglomerative coefficient
    hc2$ac  #0.8531583

    ##  with the agnes function you can also get the agglomerative coefficient, 
    ##  which measures the amount of clustering structure found (values closer 
    ##  to 1 suggest strong clustering structure).


## 2. Analysing which methods can give the strongest clustering structure using 
##     agglomerative coefficient
    m <- c("average", "single", "complete", "ward")
    names(m) <- c("average", "single", "complete", "ward")
    
    ac <- function(x){
      agnes(df, method = x)$ac
    }
    
    map_dbl(m, ac) # apply the ac function to every element and return a vector
    # average    single  complete      ward 
    # 0.7379371 0.6276128 0.8531583 0.9346210
    
    ## Comment: Ward's method seems to show the strongest clustering structure
    

##  3. Plot the dendrogram using Ward's method
##  ---------------------------------------------
    hc3 <- agnes(df, method="ward")
    pltree(hc3, cex = 0.6, hang = -1, main="Dendrogram of agnes")

    rect.hclust(hc3, k = 4, border = 2:5) # if want four clusters
