attach(mtcars)
library(lattice)
with(mtcars,xyplot(wt~mtcars$mpg,group=mtcars$cyl,auto.key = 20,pch=20,cex=3))


library(class)


train=cbind(mtcars$mpg,wt)
test=c(26,2.2)

knn(train,test,cl=mtcars$cyl,k=2,prob = T)


####Random Forest
library(randomForest)
library(ggplot2)
set.seed(123)



head(diamonds)
baggin=randomForest(formula=color~., data=diamonds[1:500,],mtr=9)
plot(baggin)



baggin2=randomForest(formula=color~., data=diamonds[1:500,],mtr=3)
plot(baggin)


importance(baggin)
varImpPlot(baggin)



test=diamonds[501:800,]
predict.baggin=predict(newdata=test,baggin,type="class")

predict.baggin2=predict(newdat=test,baggin2,type="class")



sum(diag(table(predict.baggin,test$color)))/300
#0.34
sum(diag(table(predict.baggin2,test$color)))/300
#0.36