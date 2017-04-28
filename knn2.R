
head(iris)
summary(iris[,c("Petal.Length","Petal.Width")])

normalize<-function(x)
{
  return (x-min(x))/(max(x)-min(x))
}

head(iris)
iris[1:4]
normalizeIris<-as.data.frame(lapply(iris[1:4],normalize))
head(normalizeIris)
nrow(normalizeIris)


train<-normalizeIris[1:120,]
test<-normalizeIris[121:150,]
train.labels<-iris[1:120,5]
test.labels<-iris[121:150,5]

library(class)
prediction=knn(train=train,test=test,cl=train.labels,k=10)
sum(diag(table(prediction,test.labels)))/30

prediction2=knn(train=train,test=test,cl=train.labels,k=100)
sum(diag(table(prediction2,test.labels)))/30
