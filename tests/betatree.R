options(digits = 4)
suppressWarnings(RNGversion("3.5.0"))

## package and data
library("betareg")
data("ReadingSkills", package = "betareg")

## augment with random noise
set.seed(1071)
n <- nrow(ReadingSkills)
ReadingSkills$x1 <- rnorm(n)
ReadingSkills$x2 <- runif(n)
ReadingSkills$x3 <- factor(sample(0:1, n, replace = TRUE))

## fit beta regression tree
rs_tree <- betatree(accuracy ~ iq | iq, ~ dyslexia + x1 + x2 + x3,
  data = ReadingSkills, minsize = 10)

## methods
print(rs_tree)
## IGNORE_RDIFF_BEGIN
summary(rs_tree) ## possibly small deviations in number of BFGS/Fisher iterations
## IGNORE_RDIFF_END
coef(rs_tree)
if(require("strucchange")) sctest(rs_tree)
