##  =================================================
##  Analysing White noise model
##  =================================================


##  1. Generate a white noise model
##  ---------------------------------
    set.seed(123)
    
    ##  (a) Generate 2000 random white-noise values
    ##  -----------------------------------
        w <- rnorm(2000, mean=0, sd=1)  ## the mean and sd are optional in generating whitenoise
        
        
    ##  (b) visualise plot
    ##  --------------------
        plot(w, type = "l") ##* type = "l" for lines plot
        
        
        
##  2. Examine correlograms (acf plot)
##  ----------------------------------------------        
    acf(w)   # autocorrelation is zero
  

##  ================        
##  Formal tests
##  ================        
        ##  . A white noise is a stationary process. But just because a process is stationary
        ##    doesn't mean that it must be white noise. Correlations may still be present in 
        ##    time series that are stationary.
        ##  . A stationary process has zero mean and variance. (However, it may have autocorrelations)
        ##  . A white noise process has zero mean, variance, and no serial correlation.
    
        
##  =====================================
##  (A) Formal test for stationarity
##  =====================================         

##  1. ADF test for stationarity (can detect if there is unit root)
##  ------------------------------------------------------------------
    ##    . ADF test hypothesis:
    ##      . H0: time series is non-stationary (possible unit root)
    ##      . H1: time series is stationary     (unit root is not detected)
    
    # install.packages("tseries")
    library(tseries)
    adf.test(w)
    # Augmented Dickey-Fuller Test
    # 
    # data:  w
    # Dickey-Fuller = -12.994, Lag order = 12, p-value = 0.01
    # alternative hypothesis: stationary
    
    ##  Comment:
    ##  ---------
    ##    . As p-value is smaller than 0.05, we can reject the null hypothesis of non-stationarity
    ##      in favour of alternative hypothesis of stationarity        
        
        
##  =====================================
##  (B) Formal test for auto-correlation
##  =====================================    

        
##  1.  Ljung-Box test for serial correlations
##  -------------------------------------------
    ##  . Ljung-Box hypothesis:
    ##    . H0: autocorrelation is zero
    ##    . H1: autocorrelation is not zero
    ##  for white-noise process, the autocorrelation should be zero
    
    Box.test(w, lag=20, type="Ljung-Box") # to test whether there is serial correlation up to lag 20vs
          # Box-Ljung test
          # 
          # data:  w
          # X-squared = 17.423, df = 20, p-value = 0.6253
    
    ##  comment:
    ##  ------------
    ##  . as p-value > 0.05, cannot reject H0 that autocorrelation is zero
    
        
        
