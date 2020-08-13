##  =============================================
##  Model Estimation - auto and manual method
##  Time Series Analysis - AirPassenger Dataset
##  =============================================

##  =============================================
##  (A) Exploring the AirPassenger Dataset
##  =============================================

# Build in data set. 
    data(AirPassengers)

    class(AirPassengers) # this tells us that data series is in a time series format

    start(AirPassengers) # this is the start of the time series
      #[1] 1949    1
    
    end(AirPassengers)  # this is the end of the time series 12 - (dec)
      #[1] 1960   12 

    frequency(AirPassengers) # this tells us that the cycle of this time series is 12 mths a yr.
      #[1] 12
    
    summary(AirPassengers)   # the number of passengers are distributed across spectrum
        # Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
        # 104.0   180.0   265.5   280.3   360.5   622.0 
    
    
    plot(AirPassengers) # this will plot the time series. Non-stationary data. 
    
    AirPassengers #this will print the dataset, in a table format. 
    View(AirPassengers) # cannot view. 
    
    abline(reg=lm(AirPassengers~time(AirPassengers))) 
        # this will fit a line in the mean of data
        # note:
        # . The mean of this data is not constant, but increasing over the years.
        # . The variance is also not constant, but increasing over the years.
        # . This time series is therefore not stationary.
        # . As this time series is not stationary, we cannot use ARMA model directly 
        #   on this dataset yet.
        # . We can only apply ARMA model on stationary time series.
        # . There are ways to transform a non-stationary time series into one that 
        #   is stationary.
    
    
    
    plot(aggregate(AirPassengers, FUN=mean)) # trend line
        # This will aggregate the cycles and display a year-on-year trend.
    
    boxplot(AirPassengers~cycle(AirPassengers)) # cycles
        # Box plot across months will give us a sense on seasonal effect.   
        # . In month of Aug, people seem to be travelling more.
    

##  ============================================================================
##  (B) Transformation of non-stationary time series to stationary time series
##  ============================================================================
    ##  .  There are 2 key problems in this non-stationary time series data:
    ##  .   (a) the variance is unequal. We can remove this unequal variance by using log transformation.
    ##  .   (b) there is a trend component. We can remove the trend component by differencing.
    
    ##  . After making the above transformation, we can then apply Augmented Dickey-Fuller (ADF) test
    ##    to find out if the time series has indeed become stationary.
    
##  1. Transforming non-stationary time series
##  ---------------------------------------------    
    ##  (a) Plot original time series
    ##  -------------------------------
        plot(AirPassengers)

    
    ##  (b) Applying Log Transformation
    ##  -------------------------------
        plot(log(AirPassengers)) # To make it homosckedastic. 
            # . Note that the variance is now quite similar (i.e. not diverging from mean)
    
    
    ##  (c) Apply first differencing on logged model
    ##  ------------------------------------------------
        plot(diff(log(AirPassengers))) # Looks stationary. Constant mean and variation. To cfm, use adf test. 
            # . Note that after taking first difference, we have removed the trend component.
            # . Taking first difference is the same as manually specifying the I in ARIMA model
            # . The resulting plot seems to be white noise --> i.e. looks staionary
            # . We can test it formally for stationarity. 
    

    
##  2. Check that the transformed series is indeed stationary; but not white-noise
##  -------------------------------------------------------------------------------  
    ##  (a) ADF test for stationarity (can detect if there is unit root)
    ##  ------------------------------------------------------------------
    ##    . ADF test hypothesis:
    ##      . H0: time series is non-stationary (possible unit root)
    ##      . H1: time series is stationary     (unit root is not detected)
    
    library(tseries)
    adf.test(diff(log(AirPassengers)))  # p-value low 0.01 --> reject H0 --> stationary  (white noise or w correlated lags?)
    
    
    ##  (b) Using Ljung-Box test to check for correlation 
    ##  -----------------------------------------------
    ##  . Ljung-Box hypothesis:
    ##    . H0: autocorrelation is zero
    ##    . H1: autocorrelation is not zero
    ##  for white-noise process, the autocorrelation should be zero
    Box.test(diff(log(AirPassengers)), lag=20, type="Ljung-Box") ## p-value low --> reject H0 --> not white noise
    # can cfm it is with correlated lags. proceed to do model estimation. 
    
    ##  (c) Using ACF to double-confirm result of Ljung-Box test
    ##  --------------------------------------------------------
    acf(diff(log(AirPassengers)), na.action=na.omit)  # many peaks above-boundary lines --> correlations (not white-noise)
    
    
    ## Comment:
    ##  ------
    ##  Since the series is stationary, but not white-noise => we can use ARIMA modelling      
    
    
    
 

##  ===============================================================
##  (C) Automated ARIMA Modelling
##  ===============================================================
    
##  (1) Running the automated modelling search
##  -------------------------------------------
      # install.packages("forecast")
      library(forecast)
    #Can lead to sub optimality. 
      
      ## recommended setting to overcome sub optimality. by setting stepwise and appx false. 
      ##  ------------------
      auto.arima(log(AirPassengers), trace = T, # put it to true, alternative models and AICs can be printed.
                 stepwise = F, # put it to false, otherwise it may produce sub-optimal outcome
                 approximation = F) # put it to false to avoid sub-optimality
      
      # Best model: ARIMA(0,1,1)(0,1,1)[12] #AIC=-483.4
      ##  . In general, the lower the AIC, the better the model.
          
          
      ## If we just want the best model without other results, just set don't set trace parameter
      ## ---------------------------------------------------------------------------------------
      best_model <- auto.arima(log(AirPassengers), 
                                stepwise = F,      
                                approximation = F)
      best_model #ARIMA(0,1,1)(0,1,1)[12]
          
      
##  (2) Predict 1960 data from our best model
##  ------------------------------------------
    ##  Let's split dataset into training set, and hide one year (1960) data for validation  
          datawide <- ts(AirPassengers, frequency = 12, start=c(1949,1), end=c(1959,12))
          
    ##  Using the model on training set  
          best_model <- Arima(log(datawide), c(0,1,1), seasonal = list(order =c(0,1,1), period=12))
          ## don't use arima(), as it will not calculate constant parameter
          best_model
          
    ## Let's predict using trained model  & compare with original data for 1960    
          pred_best_model <- predict(best_model, n.ahead = 10*12) # predict next 10 years         
          
          pred_best_dec <- 2.718^pred_best_model$pred    ## converting from log scale to normal scale      
          
          data_best <- head(pred_best_dec, 12) ## we are taking first 12 mths of data (=1960 data)
          
          predicted_best_1960 <- round(data_best, digits = 0)  # rounding off to integer values
          predicted_best_1960 
          #[1] 419 399 466 454 473 547 622 630 526 462 406 452
          
          ## comparing original dataset for 1960
          original_1960 <- tail(AirPassengers, 12)
          original_1960 
          #[1] 417 391 419 461 472 535 622 606 508 461 390 432
          
### ====================END============================================
          
          
          
##  ==============================================================================
##  OPTIONAL SECTION - manual method of model fitting
##  -  Using ACF and PACF to ascertain the order of p,d,q in ARIMA(p,d,q) model
##  ==============================================================================
          
##  (1) Autocorrelation Function (ACF) and Partial Autocorrelation Function (PACF) plot
##  ------------------------------------------------------------------------------------
##    (a) Before transformation
##    ----------------------------
        acf(AirPassengers) 
        # . this acf plot is prior to transforming it to stationary.
        # . Almost all the lines are above the threshold (blue) lines.

##    (b) After transformation
##    ----------------------------
    ## (i) method 1 -- using acf() and pacf() from RBase
    ##  ------------------------------------
        acf(diff(log(AirPassengers))) #  acf gives value of q
        # . Note the acf starts with 0 (zero-line). we should ignore that line.
        # . i.e. We start counting the line after zero line (as the first line)
        # . the value of q is 1 (as it is the first line above the blue line).
    
        pacf(diff(log(AirPassengers))) # pacf gives value of p
        # . Note the pacf starts with 1 (first line and not the zero line). 
        # . i.e. We start counting that as the first line.
        # . the value of p is 1 (as it is the first line above the blue line).
        
        ## possible models: AR1, MA1, ARMA(1,1) => ARIMA(1,0,1)

    ##  (ii) method 2 -- using tsdisplay from forecast package (better approach)
    ##  ----------------------------------------------------------------------
        # install.packages("forecast")
        library(forecast)
        tsdisplay(diff(log(AirPassengers)))
        # . clearer from this set of correlograms (acf, pacf)
        #   that possible models: ARIMA(0,1,1), ARIMA(1,1,0), ARIMA(1,1,1)...etc
        # . Here, just count off the first line as 1 in both acf and pacf

    ##  Comment
    ##  . since we take the difference once => d=1
    ##  . Possible models could be ARIMA(0,1,1), ARIMA(1,1,0), ARIMA(1,1,1), and others.



##  (2)  Fitting ARIMA(1,1,1) model to predict future 10 years
##  -----------------------------------------------------------
      ## Note: we should always start from the simplest likely model (i.e. ARIMA(0,1,1) in
      ##       our case). But let's go ahead and develop an ARIMA(1,1,1) model
      
      library(forecast)
      arima_1_1_1 <- Arima(log(AirPassengers), c(1,1,1), seasonal = list(order=c(1,1,1), period=12))
      ### . don't use arima(), as it will not calculate constant parameter
      ##  . instead use Arima() from forecast package
      ##  . no need to take diff() as this is provided for in d=1 of ARIMA(p,d,q)


##  fitness check
##  -------------
    arima_1_1_1 #AIC=-480.31
    checkresiduals(arima_1_1_1) #looks normal
    
    pred1 <- predict(arima_1_1_1, n.ahead = 10*12) #10 years of 12 mths
    
    pred1_dec <- 2.718^pred1$pred 
    # to convert from log to dec form (exponential value is 2.718)
    # we need not do this step if we didn't do a log transformation earlier.
    
    ts.plot(AirPassengers, pred1_dec, log = "y", lty = c(1,3))
    ts.plot(AirPassengers, pred1_dec, linear = "y", lty = c(1,2))
    

##  (3) Testing predictions of our model
##  ------------------------------------------------------------
    datawide <- ts(AirPassengers, frequency = 12, start=c(1949,1), end=c(1959,12))
    
    fit <- Arima(log(datawide), c(1,1,1), seasonal = list(order =c(1,1,1), period=12))
    ## don't use arima(), as it will not calculate constant parameter
    
    pred2 <- predict(fit, n.ahead = 10*12)  # predict next 10 years        
    
    pred2_dec <- 2.718^pred2$pred          
    
    data1 <- head(pred2_dec, 12)
    
    predicted_1960 <- round(data1, digits = 0)
    predicted_1960 
    #[1] 418 396 463 451 469 544 618 627 523 459 403 448
    
    original_1960 <- tail(AirPassengers, 12)
    original_1960 
    #[1] 417 391 419 461 472 535 622 606 508 461 390 432
    
    ##  Comment:
    ##    . The predicted values are quite close to the actual figures.
    ##    . We should develop other ARIMA models and compare the AIC values.
    ##    . The model with lowest AIC should be selected.
