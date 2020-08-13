#(A) Loops 

#(1) for loop 
for (i in 1:6) {
  print(i)
}

1:6

#(2) while loop 
i <- 1 
while(i <= 6) {
  print(i)
  i = i+ 1 
}

#(B) If Else 
#(1) if statement 
x <- 5 
if (x > 0) {
  print("Positive number")
}

#(2) If Else statement 
#(a)
x <- 5
if(x >0) {
  print("Positive number/Non-negative number")
} else {
print("Negative number")
}

#(b)
x <- -5 
ifelse(x>0, "Positive number", "negative number")

#(C) 
num = as.integer(readline(prompt = "Enter a number: "))

if ((num %% 2) == 0) {
  print (paste(num, "is Even"))
} else {
  print(paste(num, "is Odd"))
}

#{3} if else ladder
#(a)
x <- -19
if (x<0) {
  print("Negative number")
} else if(x >0) {
  print("Positive number")
} else {
  print("Zero")
}

#(c)
x <- 0 
ifelse(x>0, "Positive number", ifelse(x<0, "Negative number", "Zero"))

#(C) Functions 
score <- c(-2.1, 3.5, 5.1, 7, 6.2, 9.1, 0)
multiply_10 <- function(x,y) {
  x*y
}
multiply_10(score,10)

#(D) 

# using if and else 
marks <- c(49, 50, 70)
marks_new <- NULL 
if(marks[1] < 50) {
  marks_new[1] <- marks[1] + 1
} else {
  marks_new[1] <- marks[1]
}

if(marks[2] < 50) {
  marks_new[2] <- marks[2] + 1
} else {
  marks_new[2] <- marks[2]
}

if(marks[3] < 50) {
  marks_new[3] <- marks[3] + 1
} else {
  marks_new[3] <- marks[3]
}
marks_new 
mean(marks_new)


# using loop and if and else 
marks <- c(49, 50, 70) 
marks_new2 <- vector() 
length(marks) 
for (i in 1:length(marks)) {
  if(marks[i] < 50) {
    marks_new2[i] <- marks[i] + 1 
  } else {
    marks_new2[i] <- marks[i]
  }
}
marks_new2
mean(marks_new2)

#using function, loop and if else 
marks <- c(49, 50, 70) 
compassionate_function <- function(x) {
  marks_new3 <- NULL 
  for (i in 1:length(x)) {
    if(x[i] < 50) {
      marks_new3[i] <- x[i] + 1 
    } else {
      marks_new3[i] <- x[i]
    }
  }
  return (marks_new3)
}
compassionate_function(marks) 
mean(compassionate_function(marks))

#assuming we have another class, we can use back the function to adjust the  marks. 
marks2 <- c(48, 49, 50, 51) 
new_marks2 <- compassionate_function(marks2) 
new_marks2
mean(new_marks2)