##  =================================================================================
##  Building Decision Trees in R - REGRESSION Tree Method using "mcycle" dataset
##  =================================================================================
##  additional resource: https://cran.r-project.org/web/packages/rpart/rpart.pdf
    ##  Purpose:
    ##    . In this project, we attempt to grow decision tree to look
    ##      at identify the types of  "acceleration" (response variable)
    ##      based on the "times" (explanatory variable).
    ##      ("times" is a proxy to shock absorbed by helmet?--> 
    ##      we then use that to estimate acceleration?)


    ## Load mcycle dataset from MASS Library
    ##  -------------------------------------
        data() #list all available datasets

        library(MASS) # Load MASS Library
  
        data(mcycle) # Load mcycle dataset
        
        ?mcycle
          # A data frame giving a series of measurements of head 
          # acceleration in a simulated motorcycle accident, used 
          # to test crash helmets.
        
          # .times - in milliseconds after impact.
          # .accel - in g
        

        
    ##  Explore dataset
    ##  ---------------
        head(mcycle,2) 
            #   times accel
            # 1   2.4   0.0
            # 2   2.6  -1.3
        
        str(mcycle)
            # 'data.frame':	133 obs. of  2 variables:
            #   $ times: num  2.4 2.6 3.2 3.6 4 6.2 6.6 6.8 7.8 8.2 ...
            #   $ accel: num  0 -1.3 -2.7 0 -2.7 -2.7 -2.7 -1.3 -2.7 -2.7 ...

        plot(accel~times, data=mcycle)
        

##  Part I - Grow tree
##  ==================================
    ##  (1) Load decision tree packages
    ##  -------------------------------
        # install.packages("rpart")
        # install.packages("rpart.plot")
        require(rpart)
        
        require(rpart.plot)

        
    ##  (2) Create the training set and the test set
    ##  ---------------------------------------------
        View(mcycle)
        nrow(mcycle) #[1] 133
        
        set.seed(1234) # set seed for reproducibility
        
        i <- sample(133, 100)  # we create a training set of 100 randomly out of total 133
        
        mcycle_train <- mcycle[i,] # training set will consist of 100 rows
        
        mcycle_test <- mcycle[-i,] # test set will consist of 33 rows
        
        View(mcycle_train)
        
        rownames(mcycle_train) <- NULL #reset row names
        
        rownames(mcycle_test) <- NULL #reset row names
  
        
    ##  (3) Grow Decision Tree -- using rpart() command
    ##  --------------------------------------------------
        ## we need to choose between "regression tree" or "classification tree"
        
        ## "Regression Tree" - using method = "anova" parameter
        ##  ----------------------------------------------------
            # regression_tree_model <- rpart(accel~times, data=mcycle, method = "anova") ## entire regression tree data
              ## note: 
              ##  . if we wish to do a "Classification Tree", then we use method = "class"
              ##  . but in classification tree, target must be categorical variable.
              ##  . Since this dataset is "continuous" --> we build a regression tree model
        
            regression_tree_model <- rpart(accel~times, data=mcycle_train, method = "anova") ## only training data
    ?rpart
    ##  (4) Plot the tree
    ##  --------------------------------------------------------
          ## note: .Can use plot(regression_tree_model) and text(regression_tree_model),
          ##        but tricky to format the generated tree. May be cut off partially.

        
        ##  (a) Method 1 -- plot the tree with the prp() function
        ##  -----------------------------------------------------
            prp(regression_tree_model)

        
        ##  (b) Method 2 -- plot the tree with the rpart.plot() function
        ##  ------------------------------------------------------------
            #rpart.plot(regression_tree_model) # looks nicer
            rpart.plot(regression_tree_model, cex=0.6) #larger fonts
        
        ?rpart.plot
            ##  Comment:
            ##    . root node contains 100% of data, and that is when acceleration is -26g
            ##    . first node is split by times < 27ms after impact:
            ##        . 63% have less than 27ms after impact (with acceleration -47g)
            ##        . while remaining 37% have more than 27ms after impact (with acceleration 12g)
            ##    . first terminal node:
            ##        . 9% have acceleration of -115g
            ##    . second terminal node:
            ##        .11% have acceleration of -86g
        
        
        
    ##  (5) Print the cp table (cp table = complexity parameter table)
    ##  --------------------------------------------------------------
        printcp(regression_tree_model)
                # Regression tree:
                #   rpart(formula = accel ~ times, data = mcycle, method = "anova")
                # 
                # Variables actually used in tree construction:
                #   [1] times
                # 
                # Root node error: 308223/133 = 2317.5
                # 
                # n= 133 
                # 
                #         CP nsplit rel error  xerror     xstd
                # 1 0.350721      0   1.00000 1.01621 0.114360
                # 2 0.271788      1   0.64928 0.64618 0.067277
                # 3 0.095322      2   0.37749 0.43874 0.057411
                # 4 0.038295      3   0.28217 0.37713 0.048350
                # 5 0.023638      4   0.24387 0.34279 0.051369
                # 6 0.017449      5   0.22024 0.33749 0.050616
                # 7 0.010000      6   0.20279 0.32401 0.048086
      # *Comment:
        ##      - nsplit    -- splitting nodes
        ##      - rel error -- relative error corresponds to the error in training set, decreases with no. of splits
        ##                      prediction accuracy is = 1 - 0.20279 (last node) = about 80% (aka R-squared)
        ##      - cp        -- complexity parameter is how much error is being reduced.
        ##                      e.g. after first split, error is being reduced from 1 to 0.64928 = 0.35072
        ##                      so if the cp goes below a certain threshold, the splitting stops (0.01 in our case)
        ##      - xerror    -- cross-validation error
        ##      - xstd      -- standardised values of cross-validation error
        
        
        
    ## (6)  compute the goodness-of-fit in the TEST set
    ##  ---------------------------------------------------
        
        ##  (a) predict using trained model on testing dataset
        ##  ----------------------------------------------------
        pred2 <- predict(regression_tree_model, mcycle_test)
          #pred2[1:10] # to see the first 10 results of our predictions
        
        ##  (b) Compute accuracy of our predictions
        ##  ----------------------------------------------------
        mse <- sum((pred2 - mcycle_test$accel)^2)/33
            # note: n= size of testing data is 33
        
        var.y <- sum((mcycle_test$accel - mean(mcycle$accel))^2)/32
        
        rsq <- 1 - mse/var.y
        
        rsq #[1] 0.7033378
 
               
##  Part II - Prune the regression Tree 
##  -----------------------------------
        
        ##  (1) to prune the tree we use the prune() function
        ##  --------------------------------------------------
        ### this function has two main arguments:
        ### the tree (fit) and the complexity parameter value
        
        ### (a) extract the cp value corresponding to
        ### the lowest cross-validation error (xerror)
        ##  --------------------------------------------
        ocp <- regression_tree_model$cptable[which.min(regression_tree_model$cptable[,"xerror"]),"CP"] 
        #we extract the cp of lowest xerror
        
        ocp  #[1] 0.01
        
        
        ### (b) prune the tree
        ##  --------------------------------------------
        prfit <- prune(regression_tree_model, ocp)
        
        rpart.plot(prfit) 
        ## . In this case, we were not able to get a simpler tree based on lowest xerror. 
        ##    It is essentially the same tree as before.
        
      ##Alternatively:
        ## . If however, we are satisfied with xerror of 0.31785 (instead of 0.30221), then we can prune
        ##   by extracting the cp value (0.023638)
   
        ### (a) extract the cp value corresponding to
        ### the acceptable cross-validation error (xerror)
        ##  --------------------------------------------
        ocp <- 0.014024 

        
        ### (b) prune the tree
        ##  --------------------------------------------
        prfit <- prune(regression_tree_model, ocp)
        
        rpart.plot(prfit) 
         # we get a simpler tree that is easier to interpret