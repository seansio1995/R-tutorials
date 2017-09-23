library("ggplot2")
library("showtext")
library("Cairo")
library("dplyr")
library(tidyverse)
#font_add("myfzhzh","方正正粗黑简体.TTF")
mydata<-data.frame(
  Class=c("现金和活期存款","定期存款","货币基金","共同基金","养老基金"),
  Y1974=c(8,35,0.1,3,47),
  Y2016=c(2.5,22,2.7,31,53)
)
mydata

mydata$Class<-factor(mydata$Class,levels=c("现金和活期存款","定期存款","货币基金","共同基金","养老基金"),ordered=T)
class(mydata$Class)

bar1<-data.frame(
  Class=c("现金和活期存款","定期存款","货币基金","共同基金","养老基金"),
  xmin=rep(0,5),
  xmax=rep(5,5),
  ymin=c(0,cumsum(mydata$Y1974)[1:4]),
  ymax=cumsum(mydata$Y1974),
  Year="Y1974"
)
bar2<-data.frame(
  Class=c("现金和活期存款","定期存款","货币基金","共同基金","养老基金"),
  xmin=rep(25,5),
  xmax=rep(30,5),
  ymin=c(0,cumsum(mydata$Y2016)[1:4]),
  ymax=cumsum(mydata$Y2016),
  Year="Y2016"
)
bar1
bar2


mydata1<-rbind(bar1,bar2)
mydata1$Class<-factor(mydata1$Class,levels=c("现金和活期存款","定期存款","货币基金","共同基金","养老基金"),ordered=T)
mydata1


mydata1$label_x=rep(c(2.5,27.5),each=5)
mydata1$label_y=mydata1$ymin+(mydata1$ymax-mydata1$ymin)/2
mydata1$value<-c(mydata$Y1974,mydata$Y2016)

midrect<-data.frame(Class=mydata$Class)
midrect$id<-1:nrow(midrect)
midrect$ystart<-c(0,cumsum(mydata$Y2016[1:(nrow(mydata)-1)]))
midrect$yend<-cumsum(mydata$Y2016)
midrect$start<-bar1$ymin
midrect$end<-bar1$ymax


midrect_data<-data.frame(t(midrect[,c("start","end","yend","ystart")]),stringsAsFactors=FALSE)
names(midrect_data)<-midrect$Class
midrect_data$order<-1:4


midrect_data_final<-gather(midrect_data,Class,lat,-order)
midrect_data_final$long<-rep(c(5,5,25,25),5)
midrect_data_final$Class<-factor(midrect_data_final$Class,levels=c("现金和活期存款","定期存款","货币基金","共同基金","养老基金"),ordered=T)


color<-c("#0579AD","#0899DA","#519F46","#A2D293","#C7C8CC")
#CairoPNG("",width=1200,height=900)
showtext.begin()
ggplot()+
  geom_rect(data=mydata1,aes(xmin=xmin,xmax=xmax,ymin=ymin,ymax=ymax,fill=Class),colour="white")+
  geom_text(data=mydata1,aes(x=label_x,y=label_y,label=paste(value,"%")),size=5,colour="white")+
  geom_text(data=NULL,aes(x=c(2.5,27.5),y=c(98,115),label=c(1974,2016)),size=10)+
  geom_polygon(data=midrect_data_final,aes(x=long,y=lat,fill=Class),colour="white")+
  ylim(0,115)+
  guides(fill=guide_legend(title=NULL)) +
  scale_fill_manual(values=color)+
  labs(title="US Asset Allocation from 1974 to 2016",
       caption="Data published by Authoritative Financial Instituions"
  )+
  theme_void(base_size=18) %+replace%
  theme(
    legend.position=c(.25,.95),
    legend.direction ="horizontal",
    plot.title=element_text(size=35,hjust=0),
    plot.caption=element_text(size=20,hjust=0),
    plot.margin=margin(10,0,10,0,unit="pt"),
    legend.text=element_text(size=20)
  )
showtext.end()
# dev.off()