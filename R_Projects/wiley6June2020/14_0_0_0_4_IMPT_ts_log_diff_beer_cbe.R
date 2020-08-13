##  ===================================================================
##  Transforming Non-stationary time series to stationary time series
##  Australian Beer Production Time Series (CBE dataset)
##  
##  Source: "Introductory Time Series with R";
##            - Paul SP Cowpertwait; Andrew V. Metcalfe [Australian data] 
##  ==================================================================

##  1.  Get Data
##  -----------------
getwd()
    setwd("/Users/karthika/Desktop/R_Projects/Class5") 
    cbe <- read.table("cbe.dat", header=T)  
    head(cbe,2)  
      #   choc beer elec
      # 1 1451 96.3 1497
      # 2 2037 84.4 1463
    
    
##  2.  Create Time series
##  ------------------------  
    beer.ts <- ts(cbe[,2], start=1958, frequency = 12)  
    beer.ts 
    #Yearly data, monthly interval, using ts() command to convert into time series data. 
    
##  3. Check of the series is stationary, and transform the series if they are not stationary
##  -----------------------------------------------------------------------------------------    
    plot(beer.ts)           ## non-stationarity: mean is going up. Not a constant. Use differencing to make it stationary. 
    plot(diff(beer.ts))     ## heteroskedasticity
    plot(diff(log(beer.ts)))## looks stationarity after transformation: constant mean and variance. 
    
    
##  4. Check that the transformed series is indeed stationary; but not white-noise
##  -------------------------------------------------------------------------------    
    ##  (a) ADF test for stationarity (can detect if there is unit root)
    ##  ------------------------------------------------------------------
    ##    . ADF test hypothesis:
    ##      . H0: time series is non-stationary (possible unit root)
    ##      . H1: time series is stationary     (unit root is not detected)
    
    library(tseries)
    adf.test(diff(log(beer.ts)))  # p-value low --> reject H0 --> stationary
    
    
    ##  (b) Using Ljung-Box test to check for correlation 
    ##  -----------------------------------------------
    ##  . Ljung-Box hypothesis:
    ##    . H0: autocorrelation is zero
    ##    . H1: autocorrelation is not zero
    ##  for white-noise process, the autocorrelation should be zero
    y<- na.omit(diff(log(beer.ts)))
    Box.test(y, lag=20, type="Ljung-Box") ## p-value low --> reject H0 --> not white noise

    
    ##  (c) Using ACF to double-confirm result of Ljung-Box test
    ##  --------------------------------------------------------
    acf(diff(log(beer.ts)), na.action=na.omit)  # many peaks above-boundary lines --> correlations (not white-noise)
    
    
    ## Comment:
    ##  ------
    ##  we have therefore successfully transformed the series from a non-stationary ts to a stationary ts
    ##  Since the series is stationary, but not white-noise => we can use ARIMA modelling
    ##  However, for some ts, even  ARIMA modelling may not work (such as this case)
    
    
