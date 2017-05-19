decompose(AirPassengers,"additive")
plot(decompose(AirPassengers,"additive"))
x=decompose(AirPassengers,"additive")

mymodel=x$trend+x$seasonal
plot(mymodel)


plot(nottem)
plot(decompose(nottem))


plot.ts(cumsum(rnorm(500)))
library(forecast)
seasonplot(nottem)

seasonplot(AirPassengers,xlab = "",col=c("red","blue"),year.labels = T,
           labelgap = 0.35,type="l",bty="l",cex=0.75)

x=1:7
library("TTR")
x
SMA(x,n=3)

lynxsmooth=SMA(lynx,n=4)
plot(lynx)
plot(lynxsmooth)

class(lynxsmooth)
0.64*0.25
0.75*0.9+0.16
(98+93+91)/3
0.75*0.94+0.16

3+2

2+4
