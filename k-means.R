library(stats)


x=runif(100,0,10)
y=runif(100,0,10)

plot(x,y)

data=data.frame(x,y)

model=kmeans(data,4,nstart = 15)

model

plot(data,col=model$cluster,pch=16)


model=kmeans(data,6,nstart=15)
model

#the better the model, if the between_SS/total_SS is greater


plot(data,col=model$cluster,pch=16)


clust=hclust(dist(x),method="complete")

clust

plot(clust)
