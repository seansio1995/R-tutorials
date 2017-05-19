install.packages("quantmod")
library(quantmod)
getSymbols("SPY",src="google")
tail(SPY)
head(SPY)
# SPY.Open SPY.High SPY.Low SPY.Close SPY.Volume
# 2007-01-03   142.25   142.86  140.57    141.37   89183100
# 2007-01-04   141.23   142.05  140.61    141.67   66119200
# 2007-01-05   141.33   141.40  140.38    140.54   68523700
# 2007-01-08   140.82   141.41  140.25    141.19   66209700
# 2007-01-09   141.31   141.60  140.40    141.07   69505500
# 2007-01-10   140.58   141.57  140.30    141.54   67530600


class(SPY)
?xts
?zoo

summary(SPY)

basket.symbols<-c("YELP","AMZN","AAPL")
getSymbols(basket.symbols,src="google")

head(YELP)
head(AMZN)
head(AAPL)


tail(YELP)
tail(AMZN)
tail(AAPL)


basket<-data.frame(as.xts(merge(YELP,AMZN,AAPL)))
head(basket,2)

head(basket,5)

plot(AAPL)
lineChart(AAPL,line.type = "h",theme="white",TA=NULL)

barChart(AAPL,bar.type = "hlc",TA=NULL)


candleChart(AAPL,multi.col = T,TA=NULL,subset = "2017-04")

candleChart(AAPL,theme=chartTheme("white",up.col="yellow",dn.col="darkred"),TA=NULL,subset="2017-04")


getSymbols("QQQ",src="google")
plot(QQQ)

candleChart(QQQ,multi.col = T,TA=NULL,subset = "2017-04")
head(QQQ)
plot(QQQ$QQQ.Close)

period<-100
price.vector<-QQQ$QQQ.Close
moving.average.vector<-c(rep(NA,period))
moving_average_vector <-
  c(rep(as.numeric(QQQ$QQQ.Close[period]), period))
for(ind in seq(1:(length(price.vector)-period)))
{
  moving.average.vector<-c(moving.average.vector,mean(price.vector[ind:ind+period]))
}
dev.off()
par(mfrow=c(2,1))
plot(QQQ$QQQ.Close)
plot(moving.average.vector, type='l', col='red', lwd=3, main
     = paste('SMA', period))
length(price.vector)
length(moving.average.vector)

QQQ$QQQ.Close.SMA<-moving.average.vector
dev.off()
plot(QQQ$QQQ.Close)
lines(QQQ$QQQ.Close.SMA,type="l",col="red",lwd=3)

getSymbols("QQQ",src="google")
chartSeries(QQQ,theme="white",TA="addSMA(100)")

dev.off()
getSymbols("AAPL",src="google")
chartSeries(AAPL,theme="white",TA="addSMA(100)",subset="2009::2013")

candleChart(AAPL,multi.col = T,TA=NULL,subset = "2016-07::2016-08")
