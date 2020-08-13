##  ==========================================================================
##  Module 5 Session 4 - BAYESIAN NETWORK 
##  ==========================================================================

##  ===============================================
##  (A) Hypertension example - using "deal" package
##  ===============================================
    ##  sources: 
    ##    . Wiley's Lab Lesson
    ##    . https://pdfs.semanticscholar.org/80b6/e813fb11a73c7e82dffc2e3ad8f02d9eddce.pdf
    ##    . https://core.ac.uk/download/pdf/6303113.pdf

    ##  Load library and dataset
    ##  -------------------------
        # install.packages("deal")
        library("deal") # invoke DEAL
        data(ksl)       # read data in DEAL
        View(ksl)
        
        ?ksl
          # .Data from a study measuring health and social 
          #  characteristics of representative samples of Danish 
          #  70 year olds, taken in 1967 and 1984.
        
          # .A data frame with variables of both discrete and continuous types.
          #   .FEV    - Lung function Forced ejection volume
          #   .Kol    - Cholesterol
          #   .Hyp    - Hypertension (no/yes)
          #   .logBMI - Logarithm of Body Mass Index
          #   .Smok   - Smoking (no/yes)
          #   .Alc    - Alcohol consumption (seldom/frequently)
          #   .Work   - Working (yes/no)
          #   .Sex    - male/female
          #   .Year   - Survey year (1967/1984)
          
        head(ksl,2)
            #   FEV Kol Hyp   logBMI Smok Alc Work Sex Year
            # 1 116 745   1 3.360375    1   2    2   2    2
            # 2 252 680   1 3.477232    2   2    2   1    2
        # View(ksl)
        str(ksl)
    ##  Purpose:
    ##    . The purpose of our analysis is to find dependency relations between variables.
    ##    . One interest is to determine which variables influence the presence or
    ##      absence of hypertension.
        
        
    ##  (1) Create an empty Directed Acyclic Graph (DAG), also known as Bayesian Networks
    ##  because no dependency is known in advance
    ##  -----------------------------------------------------------------------------
        ksl.nw <- network(ksl) #creates "empty" DAG (aka Bayesian Networks); although ksl has values
        ksl.nw
              ##  9 ( 5 discrete+ 4 ) nodes;score=  ;relscore=  
              # 1	FEV	continuous() 
              # 2	Kol	continuous() 
              # 3	Hyp	continuous() 
              # 4	logBMI	continuous() 
              # 5	Smok	discrete(2) 
              # 6	Alc	discrete(2) 
              # 7	Work	discrete(2) 
              # 8	Sex	discrete(2) 
              # 9	Year	discrete(2)
                
        

    ##  (2) Use created network to join the distribution of discrete variables
    ##  -----------------------------------------------------------------------------
        ## jointprior: 
        ## .  Given a network with a prob property for each node, derives the joint probability distribution. Then 
        #     the quantities needed in the local master procedure for finding the local parameter priors are deduced.
        ksl.prior <- jointprior(ksl.nw)
        ksl.prior    #the Bayesian Networks now have values after connecting them
        
        
    ##  (3) Create a banlist
    ##  ------------------------------------------------------------------------------
        ##  .Purpose is to prevent  arrows into Sex and Year, as none of the other variables
        ##    can influence theses variables.
        ##  .The banlist is a matrix with two columns. Each row contains directed edge that
        ##    is not allowed.
        
        banlist <- matrix(c(5,5,6,6,7,7,9,
                            8,9,8,9,8,9,8),ncol=2)
        banlist
            #       [,1] [,2]
            # [1,]    5    8
            # [2,]    5    9
            # [3,]    6    8
            # [4,]    6    9
            # [5,]    7    8
            # [6,]    7    9
            # [7,]    9    8
        
        ksl.nw$banlist <- banlist

        
    ##  (4) Assign variables as parameters to a tree
    ##  ------------------------------------------------------------------------------
      ##  (a) learn the network
      ##  ----------------------
            # ?learn
            # . Updates the distributions of the parameters in the network, 
            #   based on a prior network and data. Also, the network score is calculated.
        
        ksl.nw <- learn(ksl.nw,ksl,ksl.prior)$nw
       

       
      ##  (b) Do structural search
      ##  --------------------------
        ksl.search <- autosearch(ksl.nw,ksl,ksl.prior,trace=TRUE)
        #?autosearch
        
      ##  (c) Perturb 'thebest' and rerun search twice
      ##  ---------------------------------------------
        #?heuristic
        ksl.heuristic <- heuristic(ksl.search$nw,
                                   ksl,
                                   ksl.prior,
                                   restart=2,
                                   degree=10,
                                   trace=TRUE,
                                   trylist = ksl.search$trylist)
        
        thebest2 <- ksl.heuristic$nw
        thebest2
        ##  9 ( 5 discrete+ 4 )   nodes;score= -15957.9103855045 ;relscore= 1 
          # 1	FEV	    continuous()	    5	  8	  9 
          # 2	Kol	    continuous()	    8	  9 
          # 3	Hyp	    continuous()	    1	  4 
          # 4	logBMI	continuous()	    2	  8 
          # 5	Smok	  discrete(2)	      8	  9 
          # 6	Alc	    discrete(2)	      5	  8	  9 
          # 7	Work	  discrete(2)	      6	  8	  9 
          # 8	Sex	    discrete(2) 
          # 9	Year	  discrete(2) 
        
        
        plot(thebest2)
        
        ##  *Comment:
        ##    . Hypertension (Hyp; node 3) is directly dependent on FEV (Forced 
        ##      ejection volume - lung function; node 1), and logBMI (Body 
        ##      Mass Index; node 4). It is independent on rest of variables.
        ##    . In turn, FEV is dependent on Smoking (node 5), and Sex (m/f; node 8)
        ##    . Additionally, LogBMI is in turn dependent on Kol(Cholestrol, node 2)
        ##      and Sex (m/f, node 8)
        
        ##    . In this analysis, we treat Hypertension as a continuous variable.
        ##      However, it is not continuous by nature. Other analyses should be
        ##      performed treating it as a discrete variable (e.g. logistic regression with
        ##      Hyp as a response variable and remaining as explanatory variables). Such
        ##      analyses may indicate that Sex and Smok may influence Hyp.
        
        

        
        # savenet(thebest2, "ksl.net")  
        
        ## Alternatively:
          # result <- heuristic(ksl.nw,ksl,ksl.prior,restart=2,degree=10,trace=TRUE)
          # thebest <- result$nw[[1]]

        
        
##  =======================================================     
##  (B) bnlearn package
##  =======================================================
    ## refer to supplementary notes