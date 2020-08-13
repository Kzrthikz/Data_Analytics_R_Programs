##  ============================
##  Vector Manipulation
##  ============================
   
    
##  1. Vectors - talking back script
##  ---------------------------------
    g <- "Hello"
    yourname <- readline("what is your name?")
    paste(g,yourname)



    
## 2. Vectors - text manipulations
##  ------------------------------
    sentence_1 <- "The quick brown fox jumps over the lazy dog"
    sentence_1    
    is.vector(sentence_1) 
    
    
    strsplit(sentence_1, " ")
        # [[1]]
        # [1] "The"   "quick" "brown" "fox"   "jumps" "over"  "the"   "lazy"  "dog"  
    

    is.list(strsplit(sentence_1, " ")) #[1] TRUE

      #?list
    
    words <- strsplit(sentence_1, " ")[[1]]
    
    words   # "The"   "quick" "brown" "fox"   "jumps" "over"  "the"   "lazy"  "dog" 
    
    words[1]       # "The"
    words[2]       # "quick"
    words[1:2]     # "The"   "quick"
    words[1:3]     #"The"   "quick" "brown"
    words[3:4]     #"brown" "fox"
    words[c(1, 3)] #"The"   "brown"
    
    tail(words,1)  #[1] "dog"
    
 
    strsplit(sentence_1, "")
        # [[1]]
        # [1] "T" "h" "e" " " "q" "u" "i" "c" "k" " " "b" "r" "o" "w" "n" " " "f" "o" "x" " " "j" "u"
        # [23] "m" "p" "s" " " "o" "v" "e" "r" " " "t" "h" "e" " " "l" "a" "z" "y" " " "d" "o" "g"
    
    
##  upper and lower case
##  --------------------
    cap <- toupper(words)
    cap #[1] "THE"   "QUICK" "BROWN" "FOX"   "JUMPS" "OVER"  "THE"   "LAZY"  "DOG"  

    
    nocap <- tolower(cap)
    nocap
    #[1] "the"   "quick" "brown" "fox"   "jumps" "over"  "the"   "lazy"  "dog"  
    
    
##  3. search and replace (using regular expressions ("regex"))
##  ------------------------------------------------------------
    sentence_2 <- "A wolf in cheap clothing"
    sentence_2 #[1] "A wolf in cheap clothing"
    
    gsub("cheap", "sheep's", sentence_2)
    # [1] "A wolf in sheep's clothing"

    
##  Optional:
##  --------
    strsplit(sentence_1, " ")[[1]][1:2] #[1] "The"   "quick"
    paste(strsplit(sentence_1, " ")[[1]][1:2], collapse=" ") #"The quick"
    