##  ================================================================
##  Handling Missing Data - why na.strings() argument is important
##  ================================================================

##  1. set working directory
##  -------------------------
    #setwd("C:\\Users\\Andy\\Documents\\D_Drive\\R_Projects\\2_QuantitativeMethods_Visualisation_R_Codes\\stats_data")
    setwd("C:\\Users\\Andy\\Documents\\D_Drive\\R_Projects\\1_Key_R_Codes\\data")


##  2. testing without using na.strings() parameter
##  -------------------------------------------------
    data_no_nastrings <- read.csv("heros_missingdata.csv", header = TRUE)
    data_no_nastrings    
          #     name     alias score
          # 1 Clark  Superman    95
          # 2 Peter Spiderman    80
          # 3 Diana              75
          # 4 Barry     Flash      
          # 5  Tony   Ironman     .
          # 6 David      <NA>    70
          # 7  <NA>         .    60
          # 8          Marvel    95
    
    
##  3. testing with na.strings() paramater
##  -------------------------------------------------
    data_with_nastrings <- read.csv("heros_missingdata.csv", header = TRUE, na.strings = c('','.','NA'))
    data_with_nastrings 
          #     name     alias score
          # 1 Clark  Superman    95
          # 2 Peter Spiderman    80
          # 3 Diana      <NA>    75
          # 4 Barry     Flash    NA
          # 5  Tony   Ironman    NA
          # 6 David      <NA>    70
          # 7  <NA>      <NA>    60
          # 8  <NA>    Marvel    95
 ?read.csv   
    
##  4. Filter out missing values
##  -----------------------------

##  case (1) -- data_no_nastrings
##  =================================
    
    ##  complete.cases
    ##  --------------------
    data1 <- data_no_nastrings[complete.cases(data_no_nastrings),]
    data1   
            #     name     alias score
            # 1 Clark  Superman    95
            # 2 Peter Spiderman    80
            # 3 Diana              75
            # 4 Barry     Flash      
            # 5  Tony   Ironman     .
            # 8          Marvel    95
 
    
##  case (2) -- data_with_nastrings
##  ==================================
    
    ##  complete.cases
    ##  --------------------
    data2 <- data_with_nastrings[complete.cases(data_with_nastrings),]
    data2    
        #     name     alias score
        # 1 Clark  Superman    95
        # 2 Peter Spiderman    80
    
    
    ##  Comment:
    ##  ---------
    ##  . Using NA filters (e.g. complete.cases) are effective only if we are able to tag the 
    ##    NAs well at the outset using na.strings()
    
    