getwd()
setwd("/Users/tfsp-h/Documents/MachineLearningAZ/dataset/")


#Polynomial Regression

dataset=read.csv("Position_Salaries.csv")
View(dataset)
dataset=dataset[2:3]
installed.packages("caTools")

lin.reg<-lm(Salary~.,data=dataset)

dataset$Level2=dataset$Level^2
dataset$Level3=dataset$Level^3
poly.reg<-lm(Salary~.,data=dataset)
summary(poly.reg)


library(ggplot2)
ggplot()+geom_point(aes(x=dataset$Level,y=dataset$Salary),color="red")+
  geom_line(aes(x=dataset$Level,y=predict(lin.reg,newdata = dataset)),color="blue")

ggplot()+geom_point(aes(x=dataset$Level,y=dataset$Salary),color="red")+
  geom_line(aes(x=dataset$Level,y=predict(poly.reg,newdata = dataset)),color="blue")



y.predict=predict(lin.reg,data.frame(Level=6.5))
y.predict
# 1 
# 330378.8 

y.predict2=predict(poly.reg,data.frame(Level=6.5,Level2=6.5^2,Level3=6.5^3))
y.predict2
# 1 
# 133259.5 