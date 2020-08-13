#ChallengeQn1 
#1. Create dataframes 
staff_data <- data.frame(
  name = c("Adam", "Bruce", "Carol", "David"), 
  role = c("director", "engineer", "finance support", "marketing"), 
  stringsAsFactors = F
)
staff_data 

new_role <- data.frame(
  old_title = c("engineer", "finance support", "marketing", "mentor", "manager"), 
  new_title = c("data scientist", "finance analyst", "marketing specialist", "guru", "managment specialist"), 
  stringsAsFactors = F
)
new_role 

?merge
#2. Merge Outer Join 

#a. Outer Join
merge(
  x= staff_data,
  y = new_role,
  by.x = "role", 
  by.y = "old_title", 
  all = "TRUE"
)

#b.Left Outer Join 
merge(
  x= staff_data,
  y = new_role,
  by.x = "role", 
  by.y = "old_title", 
  all.x = "TRUE"
)

#c.Right Outer join 
merge(
  x= staff_data,
  y = new_role,
  by.x = "role", 
  by.y = "old_title", 
  all.y = "TRUE"
)

#d. Cross join 
merge(
  x= staff_data,
  y = new_role,
  all = NULL
)

#e. Inner Join
merge(
  x= staff_data,
  y = new_role,
  by.x = "role", 
  by.y = "old_title", 
)

# 3. Update role titles 
staff_data2 <- merge(
  x= staff_data,
  y = new_role,
  by.x = "role", 
  by.y = "old_title", 
  all.x = "TRUE"
)
staff_data2[!complete.cases(staff_data2$new_title), "new_title"] <- staff_data2[!complete.cases(staff_data2$new_title), "role"]
staff_data2 <- staff_data2[-1] 
names(staff_data2) <- c("name", "role") 
staff_data2

