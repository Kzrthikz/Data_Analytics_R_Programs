##  ===========================================
##  How Old is the Universe?
##  ===========================================


##  1.  Load packages and data
##  -------------------------------
      # install.packages("gamair")
      library(gamair) # contains 'hubble' data
      data(hubble)
      
      View(hubble)
      #head(hubble)
      ?hubble
          ## Galaxy -- factor identifying the galaxy
          ## y -- galaxy's relative velocity in km per sec
          ## x -- galax's distance in Mega parsecs (1 parsec is 3.09e13 km)
      
      #str(hubble)
      
      
##  2.  Create a linear model with no intercept
##  --------------------------------------------
      hubble.model <- lm(y~x-1,data=hubble)
      summary(hubble.model)

              # Call:
              #   lm(formula = y ~ x - 1, data = hubble)
              # 
              # Residuals:
              #   Min     1Q Median     3Q    Max 
              # -736.5 -132.5  -19.0  172.2  558.0 
              # 
              # Coefficients:
              #   Estimate Std. Error t value Pr(>|t|)    
              # x   76.581      3.965   19.32 1.03e-15 ***
              #   ---
              #   Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
              # 
              # Residual standard error: 258.9 on 23 degrees of freedom
              # Multiple R-squared:  0.9419,	Adjusted R-squared:  0.9394 
              # F-statistic: 373.1 on 1 and 23 DF,  p-value: 1.032e-15
      
      ##  Comment:
      ##  --------
      ##  . very low p-value --> good.
      
      
##  3.  Check if residuals are homoskedastic -- by ploting residuals against 
##      the fitted values
##  -------------------------------------------------------------------------

  ##  (a) Create a scatter plot
  ##  ----------------------------
      plot(x = fitted(hubble.model),
           y = residuals(hubble.model),
           xlab="fitted values",
           ylab="residuals")

          ##  Comment:
          ##  --------
          ##  . Note that there is heteroskedasticity --> violation of constant variance
          ##  . But the cause of the heteroskedasticity could be due to (two) outliers.
          ##    --> we can eliminate these 2 outliers and see if the results improved.
      

  ##  (b) Finding which are the 2 outliers?
  ##  ------------------------------------------
        data_residuals <- data.frame(x=fitted(hubble.model),
                                     y=residuals(hubble.model))
        
        max(data_residuals$y) #[1] 557.9799
        min(data_residuals$y) #[1] -736.4867
        
        data_residuals[which(data_residuals$y==max(data_residuals$y)),]
              # x        y
              # 3 1236.02 557.9799
        
        data_residuals[which(data_residuals$y==min(data_residuals$y)),]
              # x         y
              # 15 1355.487 -736.4867
        
            ##  Comment:
            ##  --------
            ##  rows 3 and 15 are the 2 outlier records.
        
        
      
##  4.  Omit offending points and produce new residual plot
##  -----------------------------------------------------------
      hubble.model1 <- lm(y~x-1,data=hubble[-c(3,15),]) # delete rows 3 and 15 
      summary(hubble.model1)
      
            # Call:
            #   lm(formula = y ~ x - 1, data = hubble[-c(3, 15), ])
            # 
            # Residuals:
            #   Min     1Q Median     3Q    Max 
            # -304.3 -141.9  -26.5  138.3  269.8 
            # 
            # Coefficients:
            #   Estimate Std. Error t value Pr(>|t|)    
            # x    77.67       2.97   26.15   <2e-16 ***
            #   ---
            #   Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
            # 
            # Residual standard error: 180.5 on 21 degrees of freedom
            # Multiple R-squared:  0.9702,	Adjusted R-squared:  0.9688 
            # F-statistic: 683.8 on 1 and 21 DF,  p-value: < 2.2e-16
      
      ##  Comment:
      ##  -------
      ##  . small p-value --> good
      

##  5. Check if residuals are homoskedastic
##  -------------------------------------------
      plot(x = fitted(hubble.model1),
           y = residuals(hubble.model1),
           xlab="fitted values",
           ylab="residuals")

      ##  Comment:
      ##  ---------
      ##  . This model looks better as it is more homoskedastic compared to earlier version.
      ##  . But variance of errors still appear slighly diverging (some heteroskedastcity)
      ##    still present.
      
 
           
##  6. Estimate Hubble's Constant
##  ------------------------------
      ##  . theory: age is reciprocal of hubble constant
      ##  . 1 mega parsec (mpc) = 3.09x10^16 km
      
      ##  . Hubble constant(H0) = v/d , where:
      ##    . v = radial velocity
      ##    . d = distance
      ##    . H0 where 0 denotes the hubble constant in present time.
      ##    . The value for the Hubble constant is given in kilometres per second per mega parsec (Mpc)
      ##        i.e. 1 mega-parsec (mpc) is 3.09 x 10^19 km
      ##              Hubble constant (km / s) per mpc
      ##              => H0 km/s per (3.09 x 10^19 km)
      ##              => (H0/3.09x10^19) per sec
      ##    . 1/H0 will give age in sec          
      
      hubble.const <- c(coef(hubble.model),coef(hubble.model1))/3.09e19  
                        ## this give hubble constant in per sec
      
      age <- 1/hubble.const  # this is the age in secs.
      age/(60^2*24*365) ## divide to get the age in years:
                        ## 60 secs a minute, 60 minute an hour, 24hr a day, 365 days a yr 
                        ## after dividing, you should have the age in years.

          # x           x 
          # 12794692825 12614854757
      
      ##  Comment:
      ##  -------
      ##  . Both estimates tell us that universe is about 13b years old.
   
