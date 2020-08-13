##  ======================================
##  Import csv file into dataframe
##  Export csv file
##  ======================================
getwd()
setwd("C:\\Users\\Andy\\Documents\\D_Drive\\R_Projects\\1_Key_R_Codes\\data")



##  1. Load external csv file ("load_test1.csv") into R studio as dataframe
##  -----------------------------------------------------------------------
    ## For Mac:
      ## use the menu "Session/set working directory/Choose Directory"  to set your working directory manually
      ## use getwd() to find the path of working directory
      # setwd("C:/Users/Andy/Documents/D_Drive/R_Projects/1_Key_R_Codes/data") # mac


    ## for Windows:
    # setwd("C:\\Users\\Andy\\Documents\\D_Drive\\R_Projects\\1_Key_R_Codes\\data") ## for window
    # getwd()

    
    data1 <- read.csv("load_test1.csv", header=T, na.strings=c('','.', 'NA'), stringsAsFactors=F)
    data1
str(data1)


##  2. Load external csv file ("load_test2.csv") into R studio as dataframe
##  -----------------------------------------------------------------------
    data2 <- read.csv("load_test2.csv", header = T, na.strings = c('','.','NA'), stringsAsFactors = F)
    data2    



##  3. Try out following codes
##  ----------------------------
    data3 <- rbind(data1, data2)
    data3

    data4 <- cbind(data1,data2)
    data4


##  4. Export processed files as csv
##  ---------------------------------
    write.csv(data3, "processed_data_test3.csv")
    write.csv(data3, "processed_data_test3.csv",row.names=FALSE)
