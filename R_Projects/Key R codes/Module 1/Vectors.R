g <- "Hello" 
yourname <- readline("What is your name?") 
paste(g, yourname) 


sentence_1 <- "The quick brown fox jumps over the lazy dog" 
sentence_1 
is.vector(sentence_1)

strsplit(sentence_1, " ")
is.list(strsplit(sentence_1, " "))

words <- strsplit(sentence_1, " ")[[1]]
words

words[5]
words[2:5]
words[c(1,3)]
words[-1]
tail(words, 1)
strsplit(sentence_1, "")

cap <- toupper(words) 
cap

nocap <- tolower(cap)
nocap

sentence_2 <- "A wolf in cheap clothing" 
sentence_2

gsub("cheap", "sheep's", sentence_2)



#pattern sequencing 

#Print sequence of numbers 
seq(from = 1, to = 5) 
#[1] 1 2 3 4 5
seq(from = 1, to = 5, by = 0.5)
#[1] 1.0 1.5 2.0 2.5 3.0 3.5 4.0 4.5 5.0


rep(1:5)
# [1] 1 2 3 4 5
rep(1:5, each = 2)
# [1] 1 1 2 2 3 3 4 4 5 5

1:5

rep(seq(from = 1, to = 5, by = 0.5), each = 2)
# [1] 1.0 1.0 1.5 1.5 2.0 2.0 2.5 2.5 3.0 3.0 3.5 3.5 4.0 4.0 4.5 4.5 5.0 5.0


