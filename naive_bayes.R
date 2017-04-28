getwd()
#[1] "/Users/tfsp-h"
setwd("/Users/tfsp-h/Documents/R/R-tutorials/data/")
iris<-read.csv("iris_data.csv")
head(iris)

library(e1071)


iris<-iris[sample.int(nrow(iris)),]
head(iris)

train<-iris[1:100,]
test<-iris[101:150,]


model<-naiveBayes(Class~.,data=train)
prediction<-predict(model,test)
table(prediction,test[,5])
sum(diag(table(prediction,test[,5])))/sum(table(prediction,test[,5]))
