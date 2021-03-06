#KAGGLE!------------------------------------
#https://www.kaggle.com/ronitf/heart-disease-uci/version/1
data <- read.csv(file.choose())
#libraries-----------------------------------
library(MASS)
#functions-----------------------------------
t.sim <- function(v1,v2,ns,lim){
  n = 50000
  sds <- sd(c(v1,v2))
  mu <- mean(c(v1,v2))
  meanDIFF <- rep(NA,n)
  for (i in 1:n){
    g <- rnorm(ns,mu, sds)
    k <- rnorm(ns,mu, sds)
    meanDIFF[i] <- mean(g) - mean(k)
  }
  
  hist(meanDIFF,xlim= c(-lim,lim))
  ourDIFF <- mean(v1)-mean(v2)
  segments(ourDIFF,0,ourDIFF,10000, col = "red")
  
}
#explore-------------------------------------
head(UScereal)
UScereal$name <- rownames(UScereal)

summary(UScereal)

#graph---------------------------------------
hist(UScereal$calories)
hist(UScereal$protein)

plot(UScereal$calories,UScereal$sugar)
plot(UScereal$mfr,UScereal$calories) #what is the median?

#Simple Inference----------------------------

#REVIEW:
#mean
#standard deviation

#But how can we be sure?
#T-test
subSet <- UScereal[UScereal$mfr %in% c("G","K"),
                   c( "mfr","calories")]
head(subSet)

plot(factor(subSet$mfr), subSet$calories)
plot(as.numeric(subSet$mfr), subSet$calories)

#LET'S THINK---------------------------------
#Would this be the same if we drew another sample?
#https://www.youtube.com/watch?v=QZ7kgmhdIwA
#--distribution of sample means-----------------

#what if no diff?
mn <- mean(subSet$calories)
Greal<- subSet[subSet$mfr == "G","calories"]
Kreal <- subSet[subSet$mfr == "K","calories"]
ourDIFF <- mean(Greal) - mean(Kreal)

g <- rnorm(20,mn, sd(subSet$calories))
k <- rnorm(20,mn, sd(subSet$calories))
labs <- factor(c(rep("G",20), rep("K", 20)))
dat <- c(g,k)


plot(labs,dat)
mean(g) - mean(k)

t.sim(Greal,Kreal,20,40)


#VARIATION is important. What does it tell you?

t.test(subSet[subSet$mfr == "G","calories"],
       subSet[subSet$mfr == "K","calories"],
       var.equal = T)


#--more t-tests------------------------------
head(iris)
set <- iris[iris$Species == "setosa","Sepal.Length"]
vers <- iris[iris$Species == "versicolor","Sepal.Length"]

labs2 <- factor(c(rep("set",length(set)),
           rep("vers", length(vers))))

alldata <- c(set,vers)

plot(labs2,alldata)

t.test(set,vers,var.equal = T)

t.sim(set,vers,50,1.5)

