##  ================================================================
##  Non-stationary ts --> stationary ts transformation
##  Australian Electricity Production Time Series (CBE dataset)
##  
##  Source: "IntroductoryTime Series with R";
##            - Paul SP Cowpertwait; Andrew V. Metcalfe
##  ================================================================
## time series

##  1.  Get Data
##  --------------
  setwd("/Users/karthika/Desktop/R_Projects/Class5") 
  cbe <- read.table("cbe.dat", header=T)  
  head(cbe,2)  
      # choc beer elec
      # 1 1451 96.3 1497
      # 2 2037 84.4 1463
  
  
##  2.  Create Time series
##  ------------------------  
  elec.ts <- ts(cbe[,3], start=1958, frequency = 12)
  
  
##  3. Transforming non-stationary time series
##  ---------------------------------------------  
  plot(elec.ts)            ## non-stationary series
  plot(diff(elec.ts))      ## heteroskedasticity, var is increasing 
  plot(diff(log(elec.ts))) ## looks like stationary ts, after log and diff transformation, constant mean and var
 
   
##  4. Check that the transformed series is indeed stationary; but not white-noise
##  -------------------------------------------------------------------------------    
##  (a) ADF test for stationarity (can detect if there is unit root)
##  ------------------------------------------------------------------
  ##    . ADF test hypothesis:
  ##      . H0: time series is non-stationary (possible unit root)
  ##      . H1: time series is stationary     (unit root is not detected)
  
  library(tseries)
  adf.test(diff(log(elec.ts)))  # p-value low --> reject H0 --> stationary
  
  
  ##  (b) Using Ljung-Box test to check for correlation 
  ##  -----------------------------------------------
  ##  . Ljung-Box hypothesis:
  ##    . H0: autocorrelation is zero
  ##    . H1: autocorrelation is not zero
  ##  for white-noise process, the autocorrelation should be zero
  Box.test(diff(log(elec.ts)), lag=20, type="Ljung-Box") ## p-value low --> reject H0 --> not white noise
  
  
  ##  (c) Using ACF to double-confirm result of Ljung-Box test
  ##  --------------------------------------------------------
  acf(diff(log(elec.ts)), na.action=na.omit)  # many peaks above-boundary lines --> correlations (not white-noise)
  
  
  ## Comment:
  ##  ------
  ##  Since the series is stationary, but not white-noise => we can use ARIMA modelling  
  
  

##  4.  Model Estimation (using automated arima)
##  -----------------------------------------------     
  library(forecast)
  
  auto.arima(log(elec.ts), 
             trace = T,
             stepwise = F,      
             approximation = F)  
  ## best model: ARIMA(0,1,1)(0,1,2)[12] 
  model1 <- Arima(log(elec.ts), c(0,1,1), seasonal = list(order =c(0,1,2), period=12))
  
  
## 5. check residuals of estimated model
##  ------------------------
  ##  (a) adf test - statistical test for stationarity
  ##  -------------------------------------------------
  ##    . ADF test hypothesis:
  ##      . H0: time series is non-stationary (possible unit root)
  ##      . H1: time series is stationary     (unit root is not detected)
  
  library(tseries)
  adf.test(resid(model1))  # p-value low --> reject H0 --> stationary
  
  ##  (b) acf plot - to look at correlations in lags
  ##  ------------------------------------------------
  acf(resid(model1)) # looks like white noise
  
  ##  (c) Ljung Box test - to look at correlations in lags
  ##  -------------------------------------------------------
  ##  . Ljung-Box hypothesis:
  ##    . H0: autocorrelation is zero
  ##    . H1: autocorrelation is not zero
  ##  for white-noise process, the autocorrelation should be zero
  Box.test(resid(model1), lag=20, type="Ljung-Box")  #p-value = 0.08776 --> autocorrelation zero --> white noise
  
  
  ##  Comment:
  ##  the residuals of the fitted model is white noise => the model fit is good!
  
  
##  6. Forecasting using fitted model
##  -----------------------------------
  tail(elec.ts)
  pred_model1 <- predict(model1, n.ahead = 2*12) ## predicting 2 years of forecast
  pred_model1_antilog <- round(2.718^pred_model1$pred, digits=0) ## converting from log scale to normal scale     
  pred_model1_antilog
  
  ts.plot(elec.ts, pred_model1_antilog, linear = "y", lty = c(1,2))  # visualise data
 