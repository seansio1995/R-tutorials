#install.packages("tree")


library(tree)

bankData<-read.csv("bank.csv",T,";")
head(bankData)

set.seed(5)
trainSet=sample(1:nrow(bankData),3000)


model<-tree(y~.,bankData,subset=trainSet)
summary(model)
plot(model)
text(model,pretty=5)

prediction=predict(model,bankData[-trainSet,],type="class")

ncol(bankData)
with(bankData[-trainSet,],table(prediction,y))
mean(bankData[-trainSet,17]==prediction)
# [1] 0.8908613