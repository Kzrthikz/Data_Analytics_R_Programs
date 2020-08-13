##  =========================================================
##  Hierarchical Clustering - Manual Calculation Comparison
##  =========================================================

##  1. Create Data
##  ----------------
    hdata1 <- data.frame(vector=c("A", "B", "C", "D"),
               x = c(18,22,43,42),
               y = c(0,0,0,0))
    
    row.names(hdata1) <- hdata1$vector
    hdata1$vector <- NULL
    hdata1

    
##  2. Create hierarchical clustering
##  -------------------------------------- 
    # install.packages("cluster")
    library(cluster)
    hc1 <- agnes(hdata1, method = "complete")
    pltree(hc1, cex = 0.6, hang = -1, main="Dendrogram of agnes")
?agnes
    