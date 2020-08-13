##  ===================================================================
##  Social Media Analytics and Opinion Mining
##  - Making Connection to Twitter using API
##  ===================================================================

##  =============================================================
##  (A) Connecting to Twitter using "Direct Connection" Method
##  =============================================================

##  (1) Install packages & Load Libraries
##  -------------------------------------
    # install.packages("twitteR")
    # install.packages("bitops")
    # install.packages("digest")
    # install.packages("RCurl")
    # install.packages("ROAuth")
    # install.packages("tm")
    # install.packages("stringr")
    # install.packages("plyr")

    library(plyr)
    library(twitteR)
    library(ROAuth)
    library(RCurl)
    library(stringr)
    library(tm)


##  (2) set up your twitter authentication (Direction Connection)
##  ---------------------------------------------------------------        
    ## (a) set up SSL
    ##  --------------
    options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))        


    ## (b) set up twitter authentication
    ##  --------------------------------
    api_key <- "<enter API key>"
    
    api_secret <- "<enter API secret key>"
    
    access_token <- "<enter Access token>"
    
    access_token_secret <- "<Access token secret>"
    
    setup_twitter_oauth(api_key, api_secret, access_token, access_token_secret)

