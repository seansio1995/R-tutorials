library(MASS)

?lda


model<-lda(data=mtcars,cyl~wt+mpg)
model

plot(model)

wt<-c(2.2,4,1.1,5)
mpg<-c(26,20,27,15)
class<-c(4,6,4,8)
test<-data.frame(wt,mpg,class)
prediction<-predict(object=model,newdata=test[,c(1,2)])$class
table(prediction,test[,3])

table(test[,3],prediction)

#########Logistic Regression
class(mtcars$am)



###tree
library(tree)
mytree<-tree(data=mtcars,am~wt+mpg)
plot(mytree)
text(mytree)

summary(mytree)
# Regression tree:
#   tree(formula = am ~ wt + mpg, data = mtcars)
# Number of terminal nodes:  4 
# Residual mean deviance:  0.08078 = 2.262 / 28 
# Distribution of residuals:
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# -0.7143  0.0000  0.0000  0.0000  0.0000  0.8333


mytree2<-tree(data=mtcars,as.factor(am)~wt+mpg)
plot(mytree2)
text(mytree2)


######Additionally Clustering (unsupervised)

plot(rivers)
kclust<-kmeans(rivers,centers = 3,nstart=30)

plot(rivers,col=kclust$cluster)



###measure distance
a=mtcars[1,]
a
b=mtcars[11,]
rbind(a,b)
dist(rbind(a,b))
#   Mazda RX4
# Merc 280C  15.67247


dm<-dist(as.matrix(mtcars[1:16,]))
hcluster=hclust(dm)

plot(hcluster)
