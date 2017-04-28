x=runif(20,min=0,max=10)
y=runif(20,min=0,max=10)

plot(x,y)

class<-rep("A",20)

class[x>5]<-"B"
class


plot(x,y,col=ifelse(class=="A","red","blue"),pch=16)
library(e1071)

data<-data.frame(x,y,class)
head(data)

model<-svm(class~x+y,data=data,kernel="linear",cost=0.1)
model
plot(model,data)

predict(model,data.frame(x=1,y=1))
# 1 
# A 
# Levels: A B


#########Radial Kernels
x=runif(40,min=0,max=10)
y=runif(40,min=0,max=10)

class=rep("A",40)

class[x>=2.5 & x<=4.5]="B"
class

data=data.frame(x,y,class)
head(data)

plot(x,y,col=ifelse(class=="A","red","blue"),pch=16)


model<-svm(class~.,data=data,kernel="radial",cost=0.1,gamma=1)
plot(model,data=data)

model<-svm(class~.,data=data,kernel="radial",cost=1,gamma=1)
plot(model,data = data)


tunemodel<-tune(svm,class~.,data=data,kernel="radial",ranges=list(cost=c(0.01,0.1,1,10),gamma=c(0.01,0.1,1,10)))


bestModel<-tunemodel$best.model
bestModel


# Call:
#   best.tune(method = svm, train.x = class ~ ., data = data, 
#             ranges = list(cost = c(0.01, 0.1, 1, 10), gamma = c(0.01, 
#                                                                 0.1, 1, 10)), kernel = "radial")
# 
# 
# Parameters:
#   SVM-Type:  C-classification 
# SVM-Kernel:  radial 
# cost:  10 
# gamma:  1 
# 
# Number of Support Vectors:  11

plot(bestModel,data=data)


#class[x>=2.5 & x<=4.5]="B"

predict(bestModel,data.frame(x=2,y=1))


predict(bestModel,data.frame(x=3,y=3))


