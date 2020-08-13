##  ======================================
##  Dataframe -- adding rows and columns
##  cbind(), c(), rbind()
##  c() = concatenate (= combine)
##  ======================================

##  Create two dataframes:
##  ----------------------
      df1 <- data.frame(name = c("Andrew", "Bruce", "Carol", "Dan"), 
                        married_year = c(2016, 2015, 2016, 2008))

      df2 <- data.frame(birth_place = c("Singapore", 
                                        "Malaysia", 
                                        "Thailand", 
                                        "Indonesia"), 
                        birth_year = c(1988, 
                                       1990, 
                                       1989, 
                                       1984))      

      df1      
            #     name married_year
            # 1 Andrew         2016
            # 2  Bruce         2015
            # 3  Carol         2016
            # 4    Dan         2008
      
      df2
            #   birth_place birth_year
            # 1   Singapore       1988
            # 2    Malaysia       1990
            # 3    Thailand       1989
            # 4   Indonesia       1984
     
      
##  ==========================================      
##  1. Adding columns  
##  ==========================================
    ##  (a) Method 1 -- Using c() to insert data directly into specified subsetted column
    ##  ---------------------------------------------------------------------------------
      df1$profession <- c("analyst", "data scientist", "accountant", "business man")
      df1      
              #     name married_year     profession
              # 1 Andrew         2016        analyst
              # 2  Bruce         2015 data scientist
              # 3  Carol         2016     accountant
              # 4    Dan         2008   business man
      
      
    ##  (b) Method 2 -- Using cbind() to combine columns
    ##  ---------------------------------------------------------------------------------
      cbinded_df <- cbind(df1, df2)
      cbinded_df      
            #     name married_year     profession birth_place birth_year
            # 1 Andrew         2016        analyst   Singapore       1988
            # 2  Bruce         2015 data scientist    Malaysia       1990
            # 3  Carol         2016     accountant    Thailand       1989
            # 4    Dan         2008   business man   Indonesia       1984

      df3 <- data.frame(salary = c(5000,6000,5500,6500))
      cbinded_df <- cbind(cbinded_df, df3)
      cbinded_df
      
      # alternative:
      # cbinded_df <- cbind(cbinded_df, data.frame(salary = c(5000,6000,5500,6500)))
      # cbinded_df
            #     name married_year     profession birth_place birth_year salary
            # 1 Andrew         2016        analyst   Singapore       1988   5000
            # 2  Bruce         2015 data scientist    Malaysia       1990   6000
            # 3  Carol         2016     accountant    Thailand       1989   5500
            # 4    Dan         2008   business man   Indonesia       1984   6500
      
      
     ## (c) Method 3 - data.frame on dataframes
      ##  -------------------------------------
      new_df <- data.frame(df1, df2)
      new_df
            #     name married_year     profession birth_place birth_year
            # 1 Andrew         2016        analyst   Singapore       1988
            # 2  Bruce         2015 data scientist    Malaysia       1990
            # 3  Carol         2016     accountant    Thailand       1989
            # 4    Dan         2008   business man   Indonesia       1984
      
      
##  =============================================
##  2. Adding rows
##  =============================================
      new_rows <- data.frame(
        name = c("Elson", "Freddy"),
        married_year = c(2009, 2010),
        profession = c("lawyer", "dentist"),
        birth_place = c("UK", "China"),
        birth_year = c(1985,  1996),
        salary = c(6000, 9000)
      )
      
      new_rows
            #     name married_year profession birth_place birth_year salary
            # 1  Elson         2009     lawyer          UK       1985   6000
            # 2 Freddy         2010    dentist       China       1996   9000
      
      
    ##  (a) using rbind() to add new rows to dataframe
    ##  -------------------------------------------------------------------
      new_data <- rbind(cbinded_df, new_rows)
      new_data
            # name married_year     profession birth_place birth_year salary
            # 1 Andrew         2016        analyst   Singapore       1988   5000
            # 2  Bruce         2015 data scientist    Malaysia       1990   6000
            # 3  Carol         2016     accountant    Thailand       1989   5500
            # 4    Dan         2008   business man   Indonesia       1984   6500
            # 5  Elson         2009         lawyer          UK       1985   6000
            # 6 Freddy         2010        dentist       China       1996   9000
      
    
      