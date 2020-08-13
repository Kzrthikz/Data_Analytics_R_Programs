##  ====================================================
##  Module 6 Session 2 - Artificial Neural Networks
##  - using Phone Churn Dataset (Supplementary Dataset)
##  ====================================================

##  ================================
##  (A) Preparation
##  ================================
getwd()
    ##  Load Dataset
    ##  ----------------------------------------
        setwd("/Users/karthika/Desktop/R_Projects/Class4/Data")
        
        phone <- read.csv("phone.csv")

        
        View(phone)
        
        str(phone)
            # 'data.frame':	1000 obs. of  6 variables:
            # $ tenure : int  13 11 68 33 23 41 45 38 45 68 ...
            # $ age    : int  44 33 52 33 30 39 22 35 59 41 ...
            # $ income : int  64 136 116 33 30 78 19 76 166 72 ...
            # $ educ   : int  4 5 1 2 1 2 2 2 4 1 ...
            # $ members: int  2 6 2 1 4 1 5 3 5 3 ...
            # $ churn  : int  1 1 0 1 0 0 1 0 0 0 ...
        
        head(phone,2)
            #   tenure age income educ members churn
            # 1     13  44     64    4       2     1
            # 2     11  33    136    5       6     1


    ##  (1) create the training set and the test set
    ##  -----------------------------------------------
        set.seed(123)
        n <- sample(1000, 500)
        
        phone_train <- phone[n,]
        
        phone_test <- phone[-n,]


##  ===================================================
##  (B) Training
##  ===================================================

    ##  (2) train the network
    ##  ------------------------------------------------
        ##  (a) Load packages
        ##  -------------------
        # install.packages("neuralnet")
        require(neuralnet)
        names(phone_train) # colnames(phone_train)
        
        ### (b) create the formula
        ##  ------------------------
        
        formula <- churn~tenure+age+income+educ+members
        
        class(formula) #[1] "formula"
        
        
        ##  (c) Create a trained neuralnet model using training data
        ##  ---------------------------------------------------------------
        ?neuralnet
        net <- neuralnet(formula, phone_train, algorithm = "rprop-", hidden = 10,
                         err.fct = "sse", act.fct = "logistic", rep = 1, stepmax = 1e06,
                         threshold = 0.01, linear.output = FALSE)
        
              # .algorithm = "rprop-" - means resilient backpropagation without weight
              #             backtracking
        
              # .hidden - a vector of integers specifying the number of hidden neurons 
              #           (vertices) in each layer
        
              # .err.fct - (error function) a differentiable function that is used for the calculation 
              #           of the error. Alternatively, the strings 'sse' and 'ce' which 
              #           stand for the sum of squared errors and the cross-entropy can 
              #           be used.
        
              # .act.fct - a differentiable function that is used for smoothing the result 
              #           of the cross product of the covariate or neurons and the weights. 
              #           Additionally the strings, 'logistic' and 'tanh' are possible for 
              #           the logistic function and tangent hyperbolicus.
        
              # .rep - the number of repetitions for the neural network's training.
        
              # .stepmax - the maximum steps for the training of the neural network. 
              #           Reaching this maximum leads to a stop of the neural network's 
              #           training process.
        
              # .threshold - a numeric value specifying the threshold for the partial 
              #             derivatives of the error function as stopping criteria.
        
              # .linear.output - logical. If act.fct should not be applied to the output 
              #                 neurons set linear output to TRUE, otherwise to FALSE.
        
        ?neuralnet #for more info


##  ===================================================
##  (C) Assess Results
##  ===================================================    

    ## (3) plot the neural network
    ##  ------------------------------------------------
    
        plot(net)
        
        plot(net, show.weights = FALSE)    ### plot the neural network without weights


    ## (4) generate the main results (in table format)
    ##  ---------------------------------------------------
    
        net$result.matrix ##generate the results matrix
            # [,1]
            # error                   3.342505e+01
            # reached.threshold       9.507080e-03
            # steps                   5.794300e+04
            # Intercept.to.1layhid1   3.457169e+01
            # tenure.to.1layhid1      1.677534e+00
            # age.to.1layhid1        -8.007115e+00
            # income.to.1layhid1      8.932969e-03
            # ...
 
            # Intercept.to.churn      2.277409e+00
            # 1layhid1.to.churn       1.670738e+00
            # 1layhid2.to.churn      -3.795812e+01
            # ...

  
        ##  *Comment (to interpret the nerual network):
        ##    . error - refers to the final error of the neural network (3.342505e+01)
        ##    . threshold - note that this value (9.507080e-03) is lower than 0.01 
        ##    . steps - this ANN has undergone over 57K steps 
        ##    . Intercept.to.1layhid1 - refers to weights from intercept to first node
        ##    . tenure.to.1layhid1 - refers to weights from tenure to first node
        ##    . age.to.1layhid1 - refers to weights from age to first node
        ##    . Intercept.to.churn - refers to weights from intercept to dependent variable (churn)
        
        
        net$weights     ### generate the weights list
            # [[1]]
            # [[1]][[1]]
            # [,1]      [,2]        [,3]       [,4]       [,5]        [,6]        [,7]        [,8]
            # [1,]  34.571694543 -8.293159  0.04715443 -0.1887799 -55.692232 -26.6955837 -290.840361 -100.849308
            # [2,]   1.677533792  2.955227  1.30019868  0.2892072 -23.021586  32.7784044   33.835456   -4.017174
            # [3,]  -8.007114789  0.495931  2.29307897  1.0450130   3.444193   0.9588972    6.267446    6.840321
            # [4,]   0.008932969 -3.073942  1.54758106  1.1625280   2.476286   2.9639333   -1.662658   -2.742818
            # [5,]  66.784596286 -5.889922 -0.13315096  0.8843094   5.119960 -47.2617399   39.929194   40.599567
            # [6,] -20.144750530 -4.165856 -1.75652740 -1.1952743  15.809499 -32.9408589    1.897814    2.784189
            # [,9]       [,10]
            # [1,] -5.065503 -20.7670430
            # [2,]  1.753288   0.8450402
            # [3,] -1.120133  -3.2214967
            # [4,] -1.128867  -0.4412958
            # [5,] -2.049472 -24.0545077
            # [6,]  1.032292  21.4926415
            # 
            # [[1]][[2]]
            # [,1]
            # [1,]   2.2774087
            # [2,]   1.6707378
            # [3,] -37.9581193
            # [4,]   0.3747260
            # [5,]   0.6241862
            # [6,]   1.4301998
            # [7,]  -4.3314517
            # [8,]  -1.6560639
            # [9,]   1.6007720
            # [10,]  37.6406998
            # [11,] 181.7291626
        
            ## . There will be 10 columns (because we have 10 hidden nodes)
            ## . For each hidden nodes, there will be 6 values because we have 5 dependent 
            ##    variables + 1 intercept
            ## . There is additional output (see above). The first row (2.2774087) refers 
            ##    to intercept for output node
            ##    The rest is the value of the activation function for each of the 10 hidden nodes.
            


    ## (5) make predictions in the test set
    ##  --------------------------------------------------    
        
    ##  (a) using the compute function
    ##  --------------------------------------------------
        pred <- compute(net, phone_test[,-6]) # apply the trained model in testing set
                # . We use compute() function to do predictions using trained network and 
                #   test dataset
                # . In the test dataset, we have phone_test[,-6], because we want to hide 
                #   the real results
                #   in column 6 (i.e. "churn", our dependent variable), so that we can 
                #   ascertain how well our predictions are.
        
        
        ##  alternatively:
        ##  --------------------
        # which(colnames(phone_test)=="churn") #6
        # pred <- compute(net, phone_test[,-which(colnames(phone_test)=="churn")])

        
        
        pred2 <- pred$net.result #we access the predicted value in the "net.result" object
        
        head(pred2, 5)
            # [,1]
            # 2  0.57806937
            # 3  0.06231600
            # 4  0.06229927
            # 8  0.06231600
            # 10 0.06232954

        
    ### (b) create a categorical predicted value
    ##  -----------------------------------------    
        # predcat <- ifelse(pred2<0.5, 0, 1) 
              # we create this categorical predicted value to 0 and 1 depending on 0.5 threshold
        
        
        predcat2 <- ifelse(pred2<mean(pred2),0,1)
        
        
    ##  (c) build the classification table
    ##  --------------------------------------    
        # table(predcat, phone_test$churn) #compares our predicted churn (predcat) vs actual churn (phone_test$churn)
            # predcat   0   1
            #       0 305  80
            #       1  56  59
        
        
        table(predicted = predcat2, actual = phone_test$churn)

              # predcat2   0   1
              #         0 304  76
              #         1  57  63

        
    ##  (d) compute the predictive accuracy
    ##  -------------------------------------    
        # mean(predcat == phone_test$churn) #[1] 0.728
    
        mean(predcat2 == phone_test$churn) #[1] 0.734
        
        
    ##alternatively:
        # accuracy = (304+63)/(304+76+57+63)
        # accuracy 

        