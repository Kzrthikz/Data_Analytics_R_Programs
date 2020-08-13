##  ================================================================
##  Handling Missing Values - part 2 (missing values in dataframe)
##  - Data Imputation Techniques 1 (using "sales_missing_data.csv")
##  ================================================================

    ##  Load dataset
    ##  ------------
        setwd("C:\\Users\\Andy\\Documents\\D_Drive\\R_Projects\\1_Key_R_Codes\\data")
       
        sales_data <- read.csv("sales_missing_data.csv", header=T, na.strings = c('', '.', 'NA'))
        sales_data
            #     company   sales expenses profit country          city
            # 1        A  200000    10000 190000      US    California
            # 2        B    <NA>    20000 450000      UK        London
            # 3        C $400000    30000 370000      US San Francisco
            # 4        D  500000       NA     NA    <NA>     Singapore
            # 5        E 1000000    50000 950000    <NA>  Kuala Lumpur
            # 6        F  800000    60000 740000   China      Bei Jing
            # 7        G  900000    50000     NA    <NA>     San Diego
            # 8        H $500000    40000 460000   China      Nan Jing
            # 9        I  600000    30000 570000   China    Chong Qing
            # 10       J  700000    20000     NA   China        Hu Bei
        
        
          # colnames(sales_data)[1] <- "new_name" ## If wish to change colnames of first column
        

    ##  Exploring Data
    ##  --------------
        str(sales_data)
            # 'data.frame':	10 obs. of  6 variables:
            # $ company : Factor w/ 10 levels "A","B","C","D",..: 1 2 3 4 5 6 7 8 9 10
            # $ sales   : Factor w/ 9 levels "$400000","$500000",..: 4 NA 1 5 3 8 9 2 6 7
            # $ expenses: int  10000 20000 30000 NA 50000 60000 50000 40000 30000 20000
            # $ profit  : int  190000 450000 370000 460000 950000 740000 NA 460000 570000 NA
            # $ country : Factor w/ 3 levels "China","UK","US": 3 2 3 NA NA 1 NA 1 1 1
            # $ city    : Factor w/ 10 levels "Bei Jing","California",..: 2 6 9 10 5 1 8 7 3 4
        

        
##  ==========================
##  (I) Data pre-processing
##  ==========================
        ## we may wish to convert sales to numeric, but we need to be careful of "factor variable trap"
        
    ##  (1) Be Wary of "Factor Variable Trap"
    ##  -------------------------------------
        as.numeric(sales_data[sales_data$company, "sales"])
            #[1]  4 NA  1  5  3  8  9  2  6  7
        
        as.numeric(as.character(sales_data[sales_data$company, "sales"]))
            # [1] 2e+05    NA    NA 5e+05 1e+06 8e+05 9e+05    NA 6e+05 7e+05

            ##  Comment:
            ##  . Do not convert from factor --> numeric 
            ##  . we can overcome the "factor variable trap" by converting from factor --> character --> numeric.
            ##  . note that values with '$' are regarded as NA => we need to remove '$' first
        
        
    ##  (2)  Removing symbols ('$') using gsub ("regular expressions" (regex))
    ##  ---------------------------------------------------------------------------
        # gsub(pattern, replacement, x, ignore.case = FALSE, perl = FALSE,
        #      fixed = FALSE, useBytes = FALSE)
        
        sales_data$sales
            # [1] 200000  <NA>    $400000 500000  1000000 800000  900000  $500000 600000  700000 
            # Levels: $400000 $500000 1000000 200000 500000 600000 700000 800000 900000
        
        sales_data$sales <- gsub("[$,]", "", sales_data$sales)  #replace all characters  starting with '$'
            ## gsub("[2,]", "", sales_data$sales) ## if we want to replace all characters starting with '2'
        

            #[1] "200000"  NA        "400000"  "500000"  "1000000" "800000"  "900000"  "500000"  "600000"  "700000" 
        
        class(sales_data$sales) #[1] "character"
        
        
    ##  (3) Converting vectors in dataframe to the appropriate class we need
    ##  --------------------------------------------------------------------
        sales_data$company <- as.character(sales_data$company)
        sales_data$country <- as.character(sales_data$country)
        sales_data$city <- as.character(sales_data$city)
        sales_data$sales <- as.numeric(sales_data$sales)
        sales_data$expenses <- as.numeric(sales_data$expenses)
        sales_data$profit <- as.numeric(sales_data$profit)
        
        str(sales_data)
            # 'data.frame':	10 obs. of  6 variables:
            # $ company : chr  "A" "B" "C" "D" ...
            # $ sales   : num  200000 470000 400000 500000 1000000 800000 900000 500000 600000 700000
            # $ expenses: num  10000 20000 30000 NA 50000 60000 50000 40000 30000 20000
            # $ profit  : num  190000 450000 370000 NA 950000 740000 NA 460000 570000 NA
            # $ country : chr  "US" "UK" "US" NA ...
            # $ city    : chr  "California" "London" "San Francisco" "Singapore" ...


##  =========================================================
##  (II) Data processing -- without applying data imputation
##  =========================================================
    ##  calculating the mean sales while ignoring NA values
        
    mean(sales_data$sales) # applying mean without ignoring NA will result in NA
          #[1] NA
        

    ##  working on perfect values using suitable NA detection methods
    ##  -----------------------------------------------------------------
    # sales_data[!is.na(sales_data$sales), "sales"] #[1] 2e+05 4e+05 5e+05 1e+06 8e+05 9e+05 5e+05 6e+05 7e+05
    mean(sales_data[!is.na(sales_data$sales), "sales"] )
        #[1] 622222.2
        
        
    # sales_data[complete.cases(sales_data$sales), "sales"] #[1] 2e+05 4e+05 5e+05 1e+06 8e+05 9e+05 5e+05 6e+05 7e+05
    mean(sales_data[complete.cases(sales_data$sales), "sales"])
        #[1] 622222.2
    
        
        
##  =========================================================
##  (III) Data processing -- with data imputation, if possible
##  =========================================================  
    
##  (A) Data Exploration
##  ------------------------------------------------------------------------------------------
    
    ##  ** Extracting all missing data ** we shall use this to check for missing data at every step
    ##  ---------------------------------------------------------------------------------------
    sales_data[!complete.cases(sales_data),] #extract all rows with missing data
        #     company sales expenses profit country         city
        # 2        B    NA    20000 450000      UK       London
        # 4        D 5e+05       NA     NA    <NA>    Singapore
        # 5        E 1e+06    50000 950000    <NA> Kuala Lumpur
        # 7        G 9e+05    50000     NA    <NA>    San Diego
        # 10       J 7e+05    20000     NA   China       Hu Bei
    
    
##  (B) Data Imputation (For missing "Sales" data) - by calculation from known values
##  -----------------------------------------------------
    ## we can estimate the missing sales data from profit and expenses
    ##  ------------------------------------------------------------------
        sales_data[is.na(sales_data$sales), "sales"] <- sales_data[is.na(sales_data$sales), "profit"] + 
          sales_data[is.na(sales_data$sales), "expenses"]

    
        
##  (C) Data Imputation (for missing "expenses" data) - by using median imputation technique 
##  -----------------------------------------------------------
    ##  note: we use median -- as median is not so influenced by extreme values as compared to mean
        
    ##  We can estimate missing expenses values from median expenses values of the data
    ##  -----------------------------------------------------------------------------------
        sales_data[is.na(sales_data$expenses),"expenses"] <- median(sales_data[!is.na(sales_data$expenses),"expenses"])


        
##  (D) Data Imputation (for missing "Profit" data) - by calculation from known values
##  -------------------------------------------------------
    ##  We can estimate the missing profit from known sales and expenses values
        sales_data[is.na(sales_data$profit), "profit"] <- sales_data[is.na(sales_data$profit), "sales"] - 
          sales_data[is.na(sales_data$profit), "expenses"]

        
##  (E) Data Imputation (for missing "country" data) - by factual analysis
##  ---------------------------------------------------------------------------
      ## we can infer the country from the cities; and doing a fact check from internet (e.g. wikipedia)

      sales_data[sales_data$city=="Singapore", "country"] <- "Singapore"
      sales_data[sales_data$city=="Kuala Lumpur", "country"] <- "Malaysia"
      sales_data[sales_data$city=="San Diego", "country"] <- "US"

      
      
##  (F) Data Review and calculation of mean sales from all the data, including imputed numbers
##  ------------------------------------------------------------------------------------------
## Let's view all the data with inputed figures   
    sales_data      
    #     company   sales expenses profit   country          city
    # 1        A  200000    10000 190000        US    California
    # 2        B  470000    20000 450000        UK        London
    # 3        C  400000    30000 370000        US San Francisco
    # 4        D  500000    30000 470000 Singapore     Singapore
    # 5        E 1000000    50000 950000  Malaysia  Kuala Lumpur
    # 6        F  800000    60000 740000     China      Bei Jing
    # 7        G  900000    50000 850000        US     San Diego
    # 8        H  500000    40000 460000     China      Nan Jing
    # 9        I  600000    30000 570000     China    Chong Qing
    # 10       J  700000    20000 680000     China        Hu Bei
    
    
  mean(sales_data$sales) ## the mean sales would differ with inclusion of imputed data
  #[1] 607000
