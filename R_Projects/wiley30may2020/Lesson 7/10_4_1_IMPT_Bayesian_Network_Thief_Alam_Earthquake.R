##  ================================
##  Alarm, Thief, Earthquake
##  ================================


##  1. Load library
##  ----------------------
    library(bnlearn)


##  2. Set nodes and arcs (as illustrated in part 1)
##  ------------------------------------------------
    TAERdag <- empty.graph(nodes = c("T", "A", "E", "R"))
    
    ##  Nodes: "from" -> "to"
    arc.set <- matrix(c("T", "A",
                        "E", "A",
                        "E", "R"
                        ),
                      byrow = TRUE, ncol=2,
                      dimnames = list(NULL, c("from", "to")))
    
    arcs(TAERdag) <- arc.set
    
    ##  check arc r/s:
    modelstring(TAERdag) #"[T][E][A|T:E][R|E]"
    plot(TAERdag)
    
##  3. Specify probabilities and insert into dag
##  ---------------------------------------------
    ##  (a) Create discrete variables, specify in levels
    ##  -------------------------------------------------
    T.lv <- c("Y", "N")
    A.lv <- c("Y", "N")
    E.lv <- c("Y", "N")
    R.lv <- c("Y", "N")
    
    
    ##  (b) "T" and "E" are completely independent (no parent)--> uni-dimensional prob.
    ##  -------------------------------------------------------------------------------
    T.prob <- array(c(0.001, 0.999), dim=2, dimnames = list(T = T.lv))
    T.prob
          # T
          # Y     N 
          # 0.001 0.999 

    
    E.prob <- array(c(0.01, 0.99), dim=2, list(E = E.lv))
    E.prob
          # E
          # Y    N 
          # 0.01 0.99 
    
    
    ##  (c) "A" depend on "T" and "E" --> 3D prob tables
    ##  --------------------------------------------------
      ## for testing and calibration
      # A.prob <- array(c(1,2,     # E:Y -- (A:Y, T:Y), (A:N, T:Y)
      #                   3,4,     # E:Y -- (A:Y, T:N), (A:N, T:N)
      #                   5,6,     # E:N -- (A:Y, T:Y), (A:N, T:Y)
      #                   7,8,     # E:N -- (A:Y, T:N), (A:N, T:N)
      #                   1,0),    # E:Y ; E:N
      #                 dim=c(2,2,2),
      #                 dimnames = list(A = A.lv, T=T.lv, E=E.lv))
          # , , E = Y
          # 
          #     T
          # A   Y N
          # Y   1 3
          # N   2 4
          # 
          # , , E = N
          # 
          #     T
          # A   Y N
          # Y   5 7
          # N   6 8
    
    A.prob <- array(c(1,0,     # E:Y -- (A:Y, T:Y), (A:N, T:Y)
                      0.1,0.9, # E:Y -- (A:Y, T:N), (A:N, T:N)
                      1,0,     # E:N -- (A:Y, T:Y), (A:N, T:Y)
                      0,1,     # E:N -- (A:Y, T:N), (A:N, T:N)
                      1,0),    # E:Y ; E:N
                    dim=c(2,2,2),
                    dimnames = list(A = A.lv, T=T.lv, E=E.lv))
   
    
    ##  (d) "R" depends on "E" --> 2D prob tables
    ##  -------------------------------------------------- 
    R.prob <- array(c(0.5, 0.5,   # (R:Y, E:Y); (R:N, E:Y)
                      0, 1),      # (R:Y, E:N); (R:N, E:N)
                    dim = c(2,2),
                    dimnames = list(R = R.lv, E = E.lv))
    

    
    ##  (e) Insert conditional prob into dag
    ##  --------------------------------------
    cpt <- list(T=T.prob, A=A.prob, E=E.prob, R=R.prob)
    bn <-custom.fit(TAERdag, cpt)        

##  5. Query Conditional Prob. (Posterior)
##  ---------------------------------------------------   
    cpquery(bn, event=(T=="Y"), evidence = (A=="Y"), n=10^6) #0.5024631
    
    cpquery(bn, event=(T=="Y"), evidence = (A=="Y")&(R=="Y"), n=10^8) #[1] 0.009710079
    
    # cpquery(bn, event=(R=="Y"), evidence = (E=="Y"), n=10^8) #0.5009767
    # 
    # cpquery(bn, event=(R=="Y"), evidence = (E=="Y")|(E=="N")) # [1] 0.0054
    # 
    
    