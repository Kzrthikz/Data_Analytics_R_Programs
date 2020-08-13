##  =================================================================================
##  Basic Stats for Time Series
##  - Transforming Random Walk Model to a stationary process 
##  
##  =================================================================================

##  1. Generate values
##  -------------------------
    set.seed(2)

  ##  (a) Generate 2000 white-noise values
  ##  -----------------------------------
    w <- rnorm(2000, mean=0, sd=1)  

    
  ##  (b) Create 2000 items with value 0 for the x(t) time series
  ##  -----------------------------------------------------------
    x <- rep(0, 2000)
    
    
##  2. Create Random Walk model
##  -----------------------------
    ##  note: Random Walk is x(t) = x(t-1) (previous value) + w (white noise)
    ##  x(t) =x(t-1) +w
    ##  x(t) - x(t-1) = w
          ### other models: x(t) = x(t-1) + x(t-2) +...+ w(t-1) +w(t-2))+...
    
    for(t in 2:2000){   # t starts from 2 as the first value is 0
      x[t] <- x[t-1] +w[t]
    }
    
    head(x)
    
    
##  3. Visualise Plot
##  ------------------
  ##  (a) Create line plot
  ##  -----------------------  
    plot(x, type = "l") ## type = "l" for lines plot

        
  ##  (b) Create autocorrelation plot
  ##  -------------------------------
    acf(x)

      ##  Commment:
      ##  ---------
      ##  . acf drops slowly => non-stationary process.
      ##  . We can try differencing to make this a stationary process.
    
    
##  4. Differencing transformation
##  --------------------------------
    acf(diff(x), na.action=na.omit)
    
      ##  Comment:
      ##  ---------
      ##  . the acf drops quickly => stationary process, after applying differencing transformation.
    
    
    ##  looking at the plot after differencing
    ##  --------------------------------------
    plot(diff(x), na.action=na.omit, type="l") ## looks like white noise, because it is.
    

##  =====================================
##  (A) Formal test for stationarity
##  =====================================         

##  1. ADF test for stationarity (can detect if there is unit root)
##  ------------------------------------------------------------------
    ##    . ADF test hypothesis:
    ##      . H0: time series is non-stationary (possible unit root)
    ##      . H1: time series is stationary     (unit root is not detected)

    library(tseries)
    
    ## before differencing transformation
    adf.test(x)    # it is not stationary (as p is high)
    
    ## after differencing transformation
    adf.test(diff(x)) # it is stationary (p is low)

    
##  =============================
##  (B)Testing for correlation
##  =============================

##  (1) Using Ljung-Box test
##  -------------------------
    ##  . Ljung-Box hypothesis:
    ##    . H0: autocorrelation is zero
    ##    . H1: autocorrelation is not zero
    ##  for white-noise process, the autocorrelation should be zero
    y<- na.omit(diff(x))
    Box.test(y, lag=20, type="Ljung-Box") 
          # Box-Ljung test
          # 
          # data:  y
          # X-squared = 22.503, df = 20, p-value = 0.3139
    
    ##  Comment:
    ##  --------
    ##  . as p-value > 0.05 => no autocorrelation => process is stationary after differencing
    ##  . we can check that if we take the Ljung-Box test before differencing it will have autocorrelation 
    ##  Box.test(x, lag=20, type="Ljung-Box")  ## p-value will be small --> reject H0 --> correlation

    
    

    
    