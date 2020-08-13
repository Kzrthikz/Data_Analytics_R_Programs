##  ===========================================================================
##  
##  Bayesian Network - using bnLearn Package
##  - using ASIA (Lung Cancer) Dataset in bnlearn Package (Further SIMPLIED Version)
##  - sources: https://kevintshoemaker.github.io/NRES-746/Bayes_Network_Markdown_Final.html#additional_resources
##  ===========================================================================

      ##  Load package and dataset
      ##  --------------------------
          # install.packages("bnlearn")
          library(bnlearn)
          head(asia)
          View(asia)

          class(asia) #[1] "data.frame" (It's already in dataframe, so no need to convert)

          str(asia)
                  # 'data.frame':	5000 obs. of  8 variables:
                  # $ A: Factor w/ 2 levels "no","yes": 1 1 1 1 1 1 1 1 1 1 ...
                  # $ S: Factor w/ 2 levels "no","yes": 2 2 1 1 1 2 1 2 2 2 ...
                  # $ T: Factor w/ 2 levels "no","yes": 1 1 2 1 1 1 1 1 1 1 ...
                  # $ L: Factor w/ 2 levels "no","yes": 1 1 1 1 1 1 1 1 1 1 ...
                  # $ B: Factor w/ 2 levels "no","yes": 2 1 1 2 1 1 1 2 2 2 ...
                  # $ E: Factor w/ 2 levels "no","yes": 1 1 2 1 1 1 1 1 1 1 ...
                  # $ X: Factor w/ 2 levels "no","yes": 1 1 2 1 1 1 1 1 1 1 ...
                  # $ D: Factor w/ 2 levels "no","yes": 2 1 2 2 2 2 1 2 2 2 ...
          
 ?asia         
      ## Purpose:
          # . We shall create a bayesian network to examine the factors related to lung diseases
          #
          # . 'ASIA' is a synthetic data set from Lauritzen and Spiegelhalter (1988) 
          #   about lung diseases (tuberculosis, lung cancer or bronchitis) and visits 
          #   to Asia. 
          
          # . Shortness-of-breath (dyspnoea) may be due to tuberculosis, 
          #   lung cancer or bronchitis, or none of them, or more than one of them. 
          #   A recent visit to Asia increases the chances of tuberculosis, while 
          #   smoking is known to be a risk factor for both lung cancer and bronchitis. 
          #   The results of a single chest X-ray do not discriminate between lung cancer 
          #   and tuberculosis, as neither does the presence or absence of dyspnoea."
          
          # . The ASIA dataset contains the following variables and data:
            #   
            # D (dyspnoea), a two-level factor with levels yes and no.
            # T (tuberculosis), a two-level factor with levels yes and no.
            # L (lung cancer), a two-level factor with levels yes and no.
            # B (bronchitis), a two-level factor with levels yes and no.
            # A (visit to Asia), a two-level factor with levels yes and no.
            # S (smoking), a two-level factor with levels yes and no.
            # X (chest X-ray), a two-level factor with levels yes and no.
            # E (tuberculosis versus lung cancer/bronchitis), a two-level factor with levels yes and no.
          
      ##  (1) Network Structure Learning 
      ##  ---------------------------------

          ##  (a) Model 1 - create network using Hill Climbing (HC) Algorithm (Score-based Learning)
          ##  --------------------------------------------------------------------------------------
              model1_hc <- hc(asia)
                    ##other models:
                    ##  . Incremental Association Markov Blanket (iamb): iamb(asia)
                    ##  . Max-Min Hill Climbing (MMHC) Algorithm (hybrid Learning): mmhc(asia)
              plot(model1_hc)
              
              ##  If we create various models, there are ways we can assess these models:
              ##  . (1) AIC - we can calculate the aic score 
              ##  . This is useful to compare between models --> best model has lowest aic score
              ##  . To calculate aic, we do: score(model1_hc, asia, type="aic") #[1] -11051.9
              
              ##  . (2) K-fold CV -- Use cross-validation, and look at expected loss
              ##  . the best model has lowest expected loss from cross validation
              ##  . To calculate expected loss of "hc" approach, we do: bn.cv(asia, bn="hc", k=10) 
                    #expected loss: 2.209813

              
              ## comment:
              ##  . note that node A is not connected. 
              ##    For DAG, we need all nodes to be connected, but not cyclically.
              ##  . we can connect node A to T (if domain experts say so)
              
              
          ## Node A is not connected. Let's connect A to T (based on experts' opinion)
          ##  ---------------------------------------------------------------------
              ## Intuitively: experts think that there is a link between visits to Asia and Tubercolosis
              model1_hc_modified <- set.arc(model1_hc, from = "A", to ="T")
              plot(model1_hc_modified)
              
              
    ##  (2) Training the network (aka Parameter Learning)
    ##  -------------------------------------------------
        ##  note: training is necessary, else we can't make inferences 
        ##  We need 'bn.fit' object for this
              
              
              
              model1_fit <- bn.fit(model1_hc_modified, asia)
              model1_fit

              
    ## (3) Making Inferences
    ##  --------------------
            #set.seed(1000) # to enhance reproducibility
            cpquery(model1_fit, event=(X=="yes"), evidence = (A=="yes")) #[1] 0.2222222

            ## *comment:
            ##    .The probability is about 22.22% that your x-ray results is "yes" 
            ##     (i.e. shows symptoms of lung diseases) when you have been
            ##      to Asia (results may vary)
            
              
            cpquery(model1_fit, event=(L=="yes"), evidence = (S=="yes")) #[1] 0.121521
            ## Comment:
              ## there is 12.1% probability of lung cancer --> if I am a smoker.

            ## Notes:
     ##   . Results of cpquery are based on Monte Carlo particle filters, and therefore they
     ##     may return slightly different values on different runs.

    ##  . We can reduce the variability by : (1) setting seed; and (ii) increasing the number of
    ##    draws in the sampling procedure by using the tuning parameter, n (but takes longer time)
            set.seed(1)
            cpquery(model1_fit, event=(E=="yes"), evidence = (S=="yes")) 
            cpquery(model1_fit, event=(E=="yes"), evidence = (S=="yes"), n=10000000) #[1] 0.1257425
            cpquery(model1_fit, event=(E=="yes"), evidence = (S=="yes"), n=10000000) #[1] 0.1256002
            # ?cpquery
            
            #set.seed(NULL)
         
            