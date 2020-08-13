##  ==============================================
##  Flu and App 
##  ==============================================


##  1. Load library
##  ----------------------
    # install.packages("bnlearn")
    library(bnlearn)


##  2. Set nodes and arcs (as illustrated in part 1)
##  ------------------------------------------------
    FluAppdag <- empty.graph(nodes = c("F", "A"))

    ##  Nodes: "from" -> "to"
    arc.set <- matrix(c("F", "A"),
        byrow = TRUE, ncol=2,
        dimnames = list(NULL, c("from", "to")))
        
    arcs(FluAppdag) <- arc.set
    
    ##  check arc r/s:
    modelstring(FluAppdag) # [1] "[F][A|F]"
    plot(FluAppdag)
    
##  3. Specify probabilities and insert into dag
##  ---------------------------------------------
    ##  (a) Create discrete variables, specify in levels
    ##  -------------------------------------------------
    F.lv <- c("Y", "N")
    A.lv <- c("Y", "N")

    
    
    ##  (b) "F" is completely independent (no parent)--> uni-dimensional prob.
    ##  -------------------------------------------------------------------------------
    F.prob <- array(c(0.05, 0.95), dim=2, dimnames = list(F = F.lv))
    F.prob    
    
    
    ##  (c) "A" depends on "F" --> 2D prob tables
    ##  -------------------------------------------------- 
    A.prob <- array(c(0.75, 0.25,       # (A:Y, F:Y); (A:Y, F:NY)
                      0.20, 0.80),      # (A:N, F:Y); (A:N, F:N)
                    dim = c(2,2),
                    dimnames = list(A = A.lv, F = F.lv))
    
    ##  (d) Insert conditional prob into dag
    ##  --------------------------------------
    cpt <- list(A=A.prob, F=F.prob)
    bn <-custom.fit(FluAppdag, cpt)        
    
    
##  5. Query Conditional Prob. (Posterior)
##  ---------------------------------------------------   
    cpquery(bn, event=(F=="Y"), evidence = (A=="Y"), n=10^6) #[1] 0.1650705   
    