#Revision on DataFrame Subsetting 

#Create Dataframe 
characters <- c("Superman", "Batman", "Wonder woman", "Flash", "Aquaman", "Cyborg")
price <- c(50, 45, 40, 43, 30, 25) 
rating <- c(4, 6, 3, 2, 1, 5) 
hero <- data.frame(characters, price, rating) 
hero 

str(hero)

hero$characters 
#[1] Superman     Batman       Wonder woman Flash        Aquaman      Cyborg      
#Levels: Aquaman Batman Cyborg Flash Superman Wonder woman

hero$characters <- as.character(hero$characters)
hero$characters

hero$characters 

hero[["characters"]]

hero["characters"]

hero[[1]]
hero[[1]][1]
hero[["characters"]][1]
hero$characters[1]
hero[[1]][2]
hero[[2]]
hero[[3]]
hero[1]
hero[1,]
hero[2,]

hero
hero[,1]
hero[[1]]
hero[["characters"]]
hero$characters
hero$c
hero$ch

#(3) Subsetting 
hero[hero$price >40,]
hero[hero$price >40,"characters"]
hero[hero$price == 40,"characters"]
hero[hero$price < 40,"characters"]
hero[hero$price < 40,1]
hero[hero$price >= 40,"characters"]
hero[hero$price <= 40,"characters"]
hero[hero$price != 40,"characters"]

#AND conditon 
hero[hero$price > 40 & hero$rating > 4, "characters"]

#OR condition 
hero[hero$price > 40 | hero$rating > 4, "characters"]
hero[hero$characters == "Batman", "rating"]
hero
hero[hero$characters %in% c("Batman", "Superman"), "rating"]


#(4) 
hero[hero$price > 40, c("characters", "rating")]
hero[hero$price > 40, c(1,3)]
hero[hero$price > 40, c(1,3,2)]

hero2 <- hero[hero$price > 40, c(1,3,2)]
hero2
colnames(hero2)
names(hero2)
names(hero2) <- c("personalities", "score", "value")
hero2

hero2[,c(1,3,2)]
hero2[,c(1,3)]
hero2[,-2]
hero2[,-c(2,3)]




