##  ===============================================================================================
##  Social Media Analytics and Opinion Mining (Improved version using cleantext and gdapRegex packages)
##  - processing and analysing data (using Syuzhet Package) on Donald Trump's tweets
##  - Pie Charts
##  ===============================================================================================

##  ===================================================
## (1) Extract data
##  ===================================================
    input_tweets <- userTimeline("realDonaldTrump", n=300)  # Donald Trump's tweets
        #use this if wish to search what people are tweeting on Donald Trump:
        # inputs_tweets <- searchTwitter("DonaldTrump", n=100, lang = "en")
           # input_tweets <- userTimeline("@leehsienloong", n=300)
    # input_tweets <- userTimeline("@sporeMOH", n=300)
    
    input_tweets[1:3] # extract first 3 rows of tweets
    
    class(input_tweets) #[1] "list"

    ##  (a) Option 1: change from list to character
    ##  ------------------------------------------
        tweet <- sapply(input_tweets, function(x) x$getText())
        ## getText() is used to extract the text content of tweets
        
        
        class(tweet) #[1] "character" 
        
        tweet[1:3] # prints first 3 rows of tweet
        
    
    ##  (b) Option 2: change list to Dataframe 
    ##  ---------------------------------------------
        tweet_df <- twListToDF(input_tweets) # convert to dataframe
        
        class(tweet_df) #[1] "data.frame"
        
        # View(tweet_df)
        
        tweet_df$text[1:3]  # prints the first 3 rows
    

##  =================================================
##  (2) Data pre-processing
##  =================================================
    ##  Load libraries
    ##  ---------------
        # install.packages("textclean")
        library(textclean)
        # install.packages('qdapRegex')
        library(qdapRegex)

        
##  Cleaning up words and numbers in the text ########        

    ##  (a) remove non-ASCII characters (e.g. foreign language) #from qdapRegex
    ##  -------------------------------------------------------------------------
        tweet_text <- rm_non_ascii(tweet_df$text)
        # View(tweet_text)
        is.vector(tweet_text) #[1] TRUE
        
            # tweet_text <- replace_non_ascii(tweet_df$text, replacement="", remove.nonconverted=TRUE) # from textclean
            # View(tweet_text)
            # is.vector(tweet_text) #[1] TRUE
            
        
    
    ##  (b) remove urls using qdapRegex package
    ##  ----------------------------------------
        tweet_text <- rm_twitter_url(tweet_text)    #  remove only twitter-type url (e.g. "t.co/N1kq0F26tG")
        tweet_text <- rm_url(tweet_text)            #  remove all other urls (non-twitter urls)
        # View(tweet_text)
        
    
    ##  (c) remove email (from qdapRegex library)
    ##  ----------------------------------------------------------
        tweet_text <- rm_email(tweet_text)
        # View(tweet_text)
       
        
    ##  (d) remove hash tag (e.g. #WRETE, #sazdd) (from qdapRegex library)
    ##  ------------------------------------------------------------------
        tweet_text <- rm_hash(tweet_text)
        # View(tweet_text)
        
        
    ##  (e) replace @ tag and equivalent words (e.g. @hadley) (from qdapRegex library)
    ##  ------------------------------------------------------------------------------
    ##  (i) we need to convert all caps to lower first (else some @ tags won't be removed)
    ##  ----------------------------------------------------------------------------------
        tweet_text <- tolower(tweet_text)
        # View(tweet_text)
        
    ##  (ii)  run the command to remove tag
    ##  ---------------------------------------------------------------------------------
        tweet_text <- rm_tag(tweet_text)
        # View(tweet_text)
        
        
    ##  (f) replace money to words equivalent  (textclean package)
    ##  -----------------------------------------------------------
        tweet_text <- replace_money(tweet_text)
        # View(tweet_text)
        
    
    ##  (g) replace numbers to words equivalent (textclean package)
    ##  ------------------------------------------------------------
        tweet_text <- replace_number(tweet_text) # note even year (e.g. 2019) will also be convereted to words
        # View(tweet_text)
        
        
    
    ##  (h) remove time (e.g. 12:45:20) (qdapRegex package)
    ##  ------------------------------------------------------------
        tweet_text <- rm_time(tweet_text)
        # View(tweet_text)
        
    
    ##  (i) remove word elongation (e.g. 'real coooool!) (textclean package)
    ##  ---------------------------------------------------------------------
        tweet_text <- replace_word_elongation(tweet_text)
        # View(tweet_text)
        
        
    ##  Cleaning up symbols, punctuations, special characters in the text ########        
    
    ##  (j) replace emoticons with word equivalent (from cleantext library)
    ##  -------------------------------------------------------------------
        tweet_text <- replace_emoticon(tweet_text)
        # View(tweet_text)
        
    
    ##  (k) remove non-words (e.g. symbols, punctuations, numbers)
    ##  ----------------------------------------------------------
        tweet_text <- rm_non_words(tweet_text) #note: aprostrophe still remains
        # View(tweet_text)
        
    
    ##  (l) removes all symbols and punctuations
    ##  -----------------------------------------------------------------------------------
        tweet_text <- strip(tweet_text, char.keep = "~~", digit.remove = TRUE,
                            apostrophe.remove = TRUE, lower.case = TRUE)
        # View(tweet_text)
        
        
    ##  further cleaning up to remove specific characteristics of content (e.g. rt)
    
    ##  (m) removes "rt" from content
    ##  ----------------------------------------------------------------------------------
    ## note: need to ensure no caps (i.e. ran tolower command first before using removewords)
        tweet_text <- removeWords(tweet_text, "rt")
        # View(tweet_text)
        
    
    ##  (n)  remove stopwords
    ##  ---------------------------------------------------------
    ## note: need to ensure no caps (i.e. ran tolower command first before using removewords)

        tweet_text <- removeWords(c(tweet_text), stopwords("english"))
        # View(tweet_text)
     
        
    ##  (o)  remove white space in beginning and end of each sentence (qdapRegex package)
    ##  -----------------------------------------------------------------------------------
        tweet_text <- rm_white_lead_trail(tweet_text)
        # View(tweet_text)


##  ========================================================================================
##  (3) get sentiment score for each tweet (shows different emotions present in each tweets)
##  ========================================================================================
    # install.packages("syuzhet") #need this for sentiment analysis
    # install.packages("bindr") #syuzhet library need this dependency
    library(bindr)
    library(syuzhet)
    
    
    tweet_text <- as.vector(tweet_text)
    emotion_text <- get_nrc_sentiment(tweet_text) #from syuzhet package
    emotion_2 <- cbind(tweet_text, emotion_text)
    View(emotion_2)
    
    ## you can access the scores and create your sentiment index: 
    length(emotion_2$anger)
    sum(emotion_2$anger)
    sum(emotion_2$anger)/length(emotion_2$anger)
    


##  ==========================================================================
##  (4) use get_sentiment function to extract sentiment score for each tweets
##  ==========================================================================
    
        sent.value <- get_sentiment(tweet_text)
        sent.value        
?get_sentiment
    

    ## (a) find most positive tweet
    ##  -----------------------------------
        most.positive <- tweet_text[sent.value == max(sent.value)]
        most.positive
        
        
        which(sent.value == max(sent.value)) # to get row numbers that have most positive tweets
    
    
    ##  (b) find most negative tweet
    ##  -----------------------------------
        most.negative <-tweet_text[sent.value == min(sent.value)]
        most.negative    
        
        which(sent.value == min(sent.value)) # to get row numbers that have most negative tweets
    

##  ===========================================================================   
##  (5) Segregating positive, negative tweets and neutral tweets
##  ===========================================================================
    positive.tweets <- tweet_text[sent.value > 0]
    head(positive.tweets, 2)
    
    
    
    negative.tweets <- tweet_text[sent.value < 0]
    head(negative.tweets,2)
    
    
    
    neutral.tweets <- tweet_text[sent.value == 0]
    head(neutral.tweets, 2)
    


##  Alternative method to classify tweets into positive, negative, and neutral
##  --------------------------------------------------------------------------
    category_senti <- ifelse(sent.value < 0, "Negative", ifelse(sent.value > 0, "Positive", "Neutral"))
    head(category_senti)  #[1] "Neutral"  "Neutral"  "Positive" "Neutral"  "Positive" "Neutral"    
    
    category_senti2 <- cbind(tweet_text, category_senti, sent.value)
    head(category_senti2,2)
    View(category_senti2)

##  ===========================================================
##  (6) Pie chart - to analyse tweet sentiments
##  ===========================================================
    ##  (a) Place in table for easier analysis
    ##  ----------------------------------------
        table(category_senti)
    
    
    ##  (b) Simple Pie Chart
    ##  ----------------------------------------
        negative_count <- length(category_senti[category_senti=="Negative"])
        neutral_count <- length(category_senti[category_senti=="Neutral"])
        positive_count <- length(category_senti[category_senti=="Positive"])
        
        # simple pie chart
        slices <- c(negative_count, neutral_count, positive_count)
        label_names <- c("Negative", "Neutral", "Positive")
        pie(slices, labels=label_names, main="Pie Chart of Tweet Sentiments")
        
    
    ##  (c) complex pie chart (with percentages)
    ##  ------------------------------------------
        slices <- c(negative_count, neutral_count, positive_count)
        label_names <- c("Negative", "Neutral", "Positive")
        pct <- round(slices/sum(slices)*100)
        label_names <- paste(label_names, pct) # add percents to labels
        label_names <- paste(label_names, "%", sep="") # add % to labels
        pie(slices, 
            labels=label_names, 
            # col= rainbow(length(label_names)),
            # col=heat.colors(length(label_names)),
            # col=terrain.colors(length(label_names)),
            col=c("green", "lightblue", "gold"),
            main="Pie Chart of Tweet Sentiments")
        
    
    ## Others:
    ## saving data
    #       
    #       setwd("C:/Users/Andy/Documents/D_Drive/R_Projects/1_Key_R_Codes/data")
    #       setwd("C:\\Users\\Andy\\Documents\\D_Drive\\R_Projects\\1_Key_R_Codes\\data")
    # 
    #       save(input_tweets, file="input_tweet_1.RData")
    # #       
    # # ##get back the saved data
    #       x <- get(load("input_tweet_1.RData"))
    #       x


