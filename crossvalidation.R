mydiamonds<-diamonds[1:500,]
attach(mydiamonds)


train<-sample(x=500,size=200)
train

model<-lm(data=mydiamonds,subset=train,x~y+z)
summary(model)

mean((x-predict(model,mydiamonds))[-train]^2)
#[1] 0.002579925


###Excercise
?faithful
plot(faithful$waiting,faithful$eruptions)
model<-glm(data=faithful[1:136,],waiting~eruptions)


mean((faithful$waiting[137:272]-predict(model,faithful[137:272,]))^2)
#[1] 35.94045


###5-fold cv
library(boot)
model2<-glm(data=faithful,waiting~eruptions)


cv.result<-cv.glm(data = faithful,model2,K=5)
cv.result$delta
#[1] 35.15946 35.11035

attach(mtcars)
train<-cbind(mpg,wt)
test<-c(26,2.2)

library(class)
knn(train,test,cl=cyl,prob=T)
# [1] 4
# attr(,"prob")
# [1] 1
# Levels: 4 6 8


with(mtcars,xyplot(wt~mpg,auto.key = T,group=cyl,pch=20,cex=3))


