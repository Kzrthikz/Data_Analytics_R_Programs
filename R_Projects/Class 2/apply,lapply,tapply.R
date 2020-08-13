#Apply 
X <- matrix(1:4, nrow = 2, ncol = 2)
X

Y <- list(a = 1:2, b=3:4)
Y

counts_df <- data.frame(
  sparrow = c(3,2,4), 
  dove = c(6,5,1), 
  crow = c(8,6,1), 
  gender = c("m", "f", "m")
)
counts_df

X
apply(X, MARGIN = 2, sum) 
apply(X, MARGIN = 1, sum)

X
multiply_2 <- function(y) {
  y * 2
}
lapply(X, multiply_2)

Y 
lapply(Y, mean)

sapply(X, multiply_2)

counts_df
tapply(counts_df$sparrow, INDEX = counts_df$gender, median)