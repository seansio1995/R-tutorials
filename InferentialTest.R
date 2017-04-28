set.seed(2489)
ourdata=rnorm(1000,mean=600,sd=80)
hist(ourdata)


sorted.object<-ifelse(ourdata>700,"yes","no")
table(sorted.object)
# sorted.object
# no yes 
# 898 102 

?prop.test
mytest=prop.test(x=102,n=1000,alternative = "two.sided")

prop.test(x=102,n=1000,alternative = "less")

prop.test(x=102,n=1000,alternative = "greater")


names(mytest)
mytest$estimate
# p 
# 0.102 


qqnorm(ourdata)

set.seed(2489)
ouruniformdata<-runif(1000)
hist(ouruniformdata)
qqnorm(ouruniformdata)

#Test the normality of data
shapiro.test(ourdata)
shapiro.test(ouruniformdata)
shapiro.test(iris$Sepal.Length)



library(nortest)
?ad.test

ad.test(rnorm(100,mean = 5,sd=3))
# Anderson-Darling normality test
# 
# data:  rnorm(100, mean = 5, sd = 3)
# A = 0.21042, p-value = 0.856

ad.test(runif(100,min = 2,max = 4))
# Anderson-Darling normality test
# 
# data:  runif(100, min = 2, max = 4)
# A = 1.5163, p-value = 0.0006199

ad.test(ourdata)
ad.test(ouruniformdata)



###Excercises
library(ggplot2)
head(diamonds)
attach(diamonds)
qqnorm(depth)
hist(depth)
length(depth)
depthsmall<-sample(depth,5000)
shapiro.test(depthsmall)
# Shapiro-Wilk normality test
# 
# data:  depthsmall
# W = 0.96172, p-value < 2.2e-16


cvm.test(depth)
pearson.test(depth)

hist(ourdata)
###t.test
?t.test
t.test(x=ourdata, mu=300,alternative = "less",conf.level = 0.95)


t.test(x=ourdata, mu=300,alternative = "greater",conf.level = 0.95)


t.test(x=ourdata, mu=300,alternative = "two.sided",conf.level = 0.95)


###two samples independent t test
head(mtcars)
attach(mtcars)


boxplot(data=mtcars,wt~am)


t.test(mtcars$wt ~ mtcars$am, alt="two.sided",conf=0.95,mu=0,paired=F,var.equal=F)
# Welch Two Sample t-test
# 
# data:  mtcars$wt by mtcars$am
# t = 5.4939, df = 29.234, p-value = 6.272e-06
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval:
#   0.8525632 1.8632262
# sample estimates:
#   mean in group 0 mean in group 1 
# 3.768895        2.411000 

####Exerciess
library(MASS)
?ships
head(ships)

attach(ships)
boxplot(incidents~period)
t.test(incidents~period)
# Welch Two Sample t-test
# 
# data:  incidents by period
# t = -0.82087, df = 37.991, p-value = 0.4168
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval:
#   -13.518049   5.718049
# sample estimates:


t.test(incidents[period==60],incidents[period==75])
#same output as above



###Anova
head(iris)
attach(iris)

is.factor(Species)
# [1] TRUE
levels(Species)

by(Sepal.Length,Species,mean)
# Species: setosa
# [1] 5.006
# ------------------------------------------------------ 
#   Species: versicolor
# [1] 5.936
# ------------------------------------------------------ 
#   Species: virginica
# [1] 6.588

oneway.test(Sepal.Length~ Species)

myanova<-aov(Sepal.Length~Species,data=iris)
summary(myanova)
# Df Sum Sq Mean Sq F value Pr(>F)    
# Species       2  63.21  31.606   119.3 <2e-16 ***
#   Residuals   147  38.96   0.265                   
# ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

attributes(myanova)

TukeyHSD(myanova)
plot(TukeyHSD(myanova))
coefficients(myanova)

###Compare the variances of different groupss
library(car) 
leveneTest(Sepal.Length,Species,data=iris,center="mean")


attach(mtcars)
table(am,vs)
barplot(table(am,vs),beside = T)


chisq.test(table(am,vs))
# Pearson's Chi-squared test with Yates' continuity correction
# 
# data:  table(am, vs)
# X-squared = 0.34754, df = 1, p-value = 0.5555

fisher.test(table(am,vs))



set.seed(234)

myobject<-data.frame(group=rep(c("a","b","c"),10),numerics=c(rnorm(5,5),6:15,rep(c(1,20,98),5)))
myobject
levels(myobject$group)
library(lattice)
bwplot(data=myobject,numerics~group,panel = panel.violin)
myanova<-aov(data=myobject,numerics~group)
summary(myanova)


TukeyHSD(myanova)
# $group
# diff        lwr      upr     p adj
# b-a  9.739319 -20.567850 40.04649 0.7081697
# c-a 49.211886  18.904717 79.51905 0.0011655
# c-b 39.472567   9.165398 69.77974 0.0088320


plot(TukeyHSD(myanova))
coefficients(myanova)
kruskal.test(data=myobject,numerics~group)
?pairwise.t.test
pairwise.t.test(x=myobject$numerics,g=myobject$group,p.adj="BH")
# a      b     
# b 0.4325 -     
#   c 0.0012 0.0049

head(bacteria)
attach(bacteria)

table(bacteria$y,trt)
# trt
# placebo drug drug+
#   n      12   18    13
# y      84   44    49


chisq.test(table(bacteria$y,trt))
# Pearson's Chi-squared test
# 
# data:  table(bacteria$y, trt)
# X-squared = 6.6585, df = 2, p-value = 0.03582