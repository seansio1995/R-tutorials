data<-c(1,2,3,3,2,1,1,3,2)
labeldata=factor(data,labels = c("a","b","c"))
labeldata
# [1] a b c c b a a c b
# Levels: a b c

x<-array(1:4,dim=c(2,2))
x
x[1,2]
y=matrix(1:8,ncol = 2,nrow=4)
y
typeof(x)


.packages(all.available = T)
