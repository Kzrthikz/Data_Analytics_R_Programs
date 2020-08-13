##  =======================================================================================================
##  REGRESSION (Simplied version)
##  - MULTIPLE LINEAR REGRESSION  - (using - MARKETING DATASET)
##   
##  Sources: 
##  (1) http://www.sthda.com/english/articles/40-regression-analysis/168-multiple-linear-regression-in-r/#examples-of-data
##  (2) formal definition of RSE - https://stats.stackexchange.com/questions/110999/r-confused-on-residual-terminology    
##  =======================================================================================================
getwd() 
    ##  Load library and data
          setwd("/Users/karthika/Desktop/R_Projects/Class 3 /Data")
          
    ##  Load Data
          marketing <- read.csv("marketing.csv", header = TRUE, na.strings=c('','.','NA'))
          head(marketing)
          
##  ===================================
##  (A) Model Building
##  ===================================          

##  (1) Building models & examine the p-values of variables
##  -------------------------------------------------------
##  (a) model 1 - use all independent variables
##  --------------------------------------------
    model_1 <- lm(sales ~youtube + facebook + newspaper, data = marketing)
    summary(model_1)  
          # Call:
          #   lm(formula = sales ~ youtube + facebook + newspaper, data = marketing)
          # 
          # Residuals:
          #   Min       1Q   Median       3Q      Max 
          # -10.5932  -1.0690   0.2902   1.4272   3.3951 
          # 
          # Coefficients:
          #               Estimate Std. Error t value Pr(>|t|)    
          #   (Intercept)  3.526667   0.374290   9.422   <2e-16 ***
          #   youtube      0.045765   0.001395  32.809   <2e-16 ***
          #   facebook     0.188530   0.008611  21.893   <2e-16 ***
          #   newspaper   -0.001037   0.005871  -0.177     0.86    
          # ---
          #   Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
          # 
          # Residual standard error: 2.023 on 196 degrees of freedom
          # Multiple R-squared:  0.8972,	Adjusted R-squared:  0.8956 
          # F-statistic: 570.3 on 3 and 196 DF,  p-value: < 2.2e-16       
  
  ##  *Comment: all variables except "newspaper" are significant


##  (b) model 2 - drop the newspaper variable
##  ------------------------------------------
    model_2 <- lm(sales~youtube + facebook, data = marketing)
    summary(model_2) 
          # Call:
          #   lm(formula = sales ~ youtube + facebook, data = marketing)
          # 
          # Residuals:
          #   Min       1Q   Median       3Q      Max 
          # -10.5572  -1.0502   0.2906   1.4049   3.3994 
          # 
          # Coefficients:
          #   Estimate Std. Error t value Pr(>|t|)    
          # (Intercept)  3.50532    0.35339   9.919   <2e-16 ***
          #   youtube      0.04575    0.00139  32.909   <2e-16 ***
          #   facebook     0.18799    0.00804  23.382   <2e-16 ***
          #   ---
          #   Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
          # 
          # Residual standard error: 2.018 on 197 degrees of freedom
          # Multiple R-squared:  0.8972,	Adjusted R-squared:  0.8962 
          # F-statistic: 859.6 on 2 and 197 DF,  p-value: < 2.2e-16
    
     ## *Comment: p-values for variables and model are good. High adj-R-Squared value          
    ##            Therefore model seems pretty good.

    
    
##  =================================            
##  (B) Model Assessment
##  =================================
    
##  (a) Examine the statistics from regression summary (focusing on model_2)
##  ----------------------------------------------------------------------------
    ## (i) Does the regression residuals have a normal distribution?
    ##  ------------------------------------------------------------
          # Residuals:
          #   Min       1Q   Median       3Q      Max 
          # -10.5572  -1.0502   0.2906   1.4049   3.3994             
    
    ##  *Comment:looks slightly skewed to left (comparing 3Q and 1Q)
    
    
    ##  (ii) Are the coefficients significant?
    ##  ------------------------------------------------------------
          # Coefficients:
          #               Estimate Std. Error t value Pr(>|t|)    
          #   (Intercept)  3.50532    0.35339   9.919   <2e-16 ***
          #   youtube      0.04575    0.00139  32.909   <2e-16 ***
          #   facebook     0.18799    0.00804  23.382   <2e-16 ***
          #   ---
          #   Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    
    ##  *Comment: p-value of coefficients very low => they are valid
    
    
    ##  (iii) (adj) R-squared (coefficient of determination) -- assess model quality
    ##  ----------------------------------------------------------------------------
          ##Multiple R-squared:  0.8972      Adjusted R-squared:  0.8962 
    
    ##  *Comment: the bigger the R-squared, the better. We have large R-squared.
    ##            The model explains 89% of the variance of sales, and the remaining
    ##            11% is unexplained. We shall use Adjusted R-square as it takes into
    ##            account of number of variables to provide more accurate assessment.
    
    
    ##  (iv)  F-Statistic -- Is the model significant?
    ##  ----------------------------------------------------------------------------
          # F-statistic: 859.6 on 2 and 197 DF,  p-value: < 2.2e-16
    
    ##  *Comment: The F-stastic is large, and p-value is small => highly significant

    
    
##  (b) Checking for Multicollinearity (i.e. are the independent variables correlated?)
 # -----------------------------------------------------------------------------------
    install.packages("car")
    require(car) #library(car)
    vif_model1 <- vif(model_1)
    vif_model2  <- vif(model_2)
    vif_model1
              # youtube  facebook newspaper 
              # 1.004611  1.144952  1.145187
    vif_model2
              # youtube facebook 
              # 1.003013 1.003013 
    
    # *Comment: If VIF >5 => multicollinearity 
    #           Here, the explanatory variables are not strongly correlated with 
    #           one another
    
    
##  (c) Prediction Errors (= Residual Standard Error / mean) --> coefficient of variation
##  ---------------------------------------------------------------------------------------
    predictionError_model_1 <- sigma(model_1)/mean(marketing$sales)
    predictionError_model_1     #[1] 0.1202004
          # note: here, RSE = sigma(model_1)
    
    predictionError_model_2 <- sigma(model_2)/mean(marketing$sales)
    predictionError_model_2     #[1] 0.1199045       
    
    ##  *Comment: we can compare the prediction error values with other models to 
    ##    ascertain which one is better
    ##  . Model 2 is better (as it has lower error rate)
    ##            The lower the better --> model 2 better.
    
    
    
## Alternatively if you wish to use mse (mean square error)
##  --------------------------------------------------------
    mse_model_1 <- mean(model_1$residuals^2)  ## alternatively: mean((marketing$sales - predict(model_1))^2)
    mse_model_1  #4.009142

    
    mse_model_2 <- mean(model_2$residuals^2)
    mse_model_2  #4.009781  
    
    ##  * Comment:
    ##  . In this case, if we are to use mse, we will select model 1 as it 
    ##    provides a lower error rate.
    
    
    
## More alternatives:
    
    ## RMSE
    RMSE <- function(error) { sqrt(mean(error^2)) }  ## Function for Root Mean Squared Error
    RMSE(model_1$residuals) #2.002284
    RMSE(model_2$residuals)  #2.002444
    

    
    ## MAE
    mae <- function(error) { mean(abs(error)) }  ## Function for Mean Absolute Error
    mae(model_1$residuals) #1.502413
    mae(model_2$residuals)  # 1.504497
    