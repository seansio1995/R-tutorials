attach(iris)
plot(Sepal.Length,Sepal.Width)
cor(Sepal.Length,Sepal.Width,method="pearson")
#[1] -0.1175698


cor(Sepal.Length,Sepal.Width,method="spearman")
# [1] -0.1667777

cor(Sepal.Length,Sepal.Width,method="kendall")
# [1] -0.07699679

cov(Sepal.Length,Sepal.Width)


cor.test(Sepal.Length,Sepal.Width,method="pearson")

x=c(rnorm(10),150)
x
m=mean(x)
m
s=sd(x)
t=3


s1=m-s*t
s2=m+s*t
y=ifelse(x>=s1 & x<=s2,0,1)
y
#[1] 0 0 0 0 0 0 0 0 0 0 1

boxplot(x)
boxplot.stats(x)
# $stats
# [1] -0.6412692  0.5125142  0.9723226  1.3904814  1.8142965
# 
# $n
# [1] 11
# 
# $conf
# [1] 0.5540696 1.3905756
# 
# $out
# [1] 150


library(outliers)


dixon.test(x)
# Dixon test for outliers
# 
# data:  x
# Q = 0.98702, p-value < 2.2e-16
# alternative hypothesis: highest value 150 is an outlier


?grubbs.test
grubbs.test(x,type = 11,two.sided = T)
