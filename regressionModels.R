head(mtcars)
head(cars)
attach(cars)


plot(x=speed,y=dist)
cor(speed,dist)

lm(speed~dist)

summary(lm(speed~dist))
model<-lm(dist~speed)


coefficients(model)
confint(model)
anova(model)
plot(model)


addon=data.frame(speed=45)
predict(model,addon)
#    1 
#159.3793 




######Multiple Regression


head(mtcars)
attach(mtcars)
mymodel<-lm(mtcars$mpg~drat+wt)
summary(mymodel)
cor(drat,wt)
confint(mymodel)
mymodel2<-lm(mtcars$mpg~drat+I(wt^2)+wt)
summary(mymodel2)
anova(mymodel2)
# Df Sum Sq Mean Sq F value    Pr(>F)    
# drat       1 522.48  522.48  71.900 3.212e-09 ***
#   I(wt^2)    1 247.23  247.23  34.022 2.873e-06 ***
#   wt         1 152.87  152.87  21.037 8.581e-05 ***





###########logistic regression


attach(mtcars)
mymodel3=glm(data=mtcars,am~wt+mtcars$mpg+drat,family = "binomial")
summary(mymodel3)


mymodel4=glm(data=mtcars,am~wt,family="binomial")
summary(mymodel4)


addon=data.frame(wt=4.5)
predict(mymodel4,addon,type="response")


summary(PlantGrowth)
# weight       group   
# Min.   :3.590   ctrl:10  
# 1st Qu.:4.550   trt1:10  
# Median :5.155   trt2:10  
# Mean   :5.073            
# 3rd Qu.:5.530            
# Max.   :6.310     

attach(PlantGrowth)
plot(group,weight)


mysubset=subset(PlantGrowth,group!="ctrl")
mymodel5=glm(data=mysubset,group~weight,family = "binomial")
summary(mymodel5)
addon=data.frame(weight=7.5)
predict(mymodel5,addon,type="response")
