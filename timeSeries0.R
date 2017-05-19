x=as.POSIXct("2015-12-25 11:35:34")
y=as.POSIXct("2015-12-25 11:35:34")

x
y
unclass(x)
unclass(y)


x=as.Date("2015-12-25")
class(x)
unclass(x)

install.packages("lubridate")
library(lubridate)

mytimepoint<-ymd_hm("1993-12-09 12:12",tz="Europe/Prague")
mytimepoint

mytimepoint2<-ymd_hm("1995-02-14 12:12",tz="Europe/Prague")

minute(mytimepoint)
month(mytimepoint)
day(mytimepoint)
year(mytimepoint)

olson_time_zones()
myinterval=interval(mytimepoint,mytimepoint2)
class(myinterval)
myinterval

minutes(7)
minutes(2.5)


dminutes(2.5)

leap_year(1999:2004)
#[1] FALSE  TRUE FALSE FALSE FALSE  TRUE

ymd(20061010)+dyears(2)
#[1] "2008-10-09"



x=ymd_hm(tz="CET","2016-12-09 12:13")
y=ymd_hm(tz="CET","2017-05-07 17:04")
minute(x)=14
x
with_tz(x,tz="Europe/London")
x

y-x

x<-rnorm(1000)
install.packages("tseries")
library(tseries)
adf.test(x)
# Augmented Dickey-Fuller Test
# 
# # data:  x
# Dickey-Fuller = -9.6946, Lag order = 9, p-value = 0.01
# alternative hypothesis: stationary

?adf.test
plot(nottem)
?decompose
plot(decompose(nottem))
adf.test(nottem)
# Augmented Dickey-Fuller Test
# 
# data:  nottem
# Dickey-Fuller = -12.998, Lag order = 6, p-value = 0.01
# alternative hypothesis: stationary


y=diffinv(x)
?diffinv
s<-1:10
d<-diff(s)
d
diffinv(s)
plot(y)


?lynx
length(lynx)
plot(lynx )


head(lynx)
#[1]  269  321  585  871 1475 2821
head(lynx[-1])
# [1]  321  585  871 1475 2821 3928

head(lynx[-114])
# [1]  269  321  585  871 1475 2821

library(lmtest)
dwtest(lynx[-114]~lynx[-1])
# Durbin-Watson test
# 
# data:  lynx[-114] ~ lynx[-1]
# DW = 1.1296, p-value = 1.148e-06
# alternative hypothesis: true autocorrelation is greater than 0


length(nottem)
dwtest(nottem[-240]~nottem[-1])
# Durbin-Watson test
# 
# data:  nottem[-240] ~ nottem[-1]
# DW = 1.0093, p-value = 5.097e-15
# alternative hypothesis: true autocorrelation is greater than 0


x=rnorm(700)
dwtest(x[-700]~x[-1])
# Durbin-Watson test
# 
# data:  x[-700] ~ x[-1]
# DW = 1.9991, p-value = 0.4958
# alternative hypothesis: true autocorrelation is greater than 0

mydata=runif(n=50,min=10,max=45)
mytimeseries=ts(data=mydata,start=1959,frequency = 4)

class(mytimeseries)
plot(mytimeseries)
head(EuStockMarkets)
class(EuStockMarkets)
# [1] "mts"    "ts"     "matrix"




x=cumsum(rnorm(n=450))
y=ts(x,start=c(1949,11),frequency = 12)
plot(y)
library(lattice)
xyplot.ts(y)

mynottem=decompose(nottem,"additive")
nottemadjusted=nottem-mynottem$seasonal
plot(nottemadjusted)

install.packages("forecast")
library(forecast)



