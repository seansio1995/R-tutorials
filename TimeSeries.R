data("AirPassengers")
class(AirPassengers)


start(AirPassengers)
end(AirPassengers)


frequency(AirPassengers)

summary(AirPassengers)

plot(AirPassengers)
abline(reg = lm(AirPassengers~time(AirPassengers)))


cycle(AirPassengers)


plot(aggregate(AirPassengers,FUN = mean))
boxplot(AirPassengers~cycle(AirPassengers))

install.packages("tseries")
library(tseries)
adf.test(diff(log(AirPassengers)),alternative="stationary",k=0)


# Augmented Dickey-Fuller Test
# 
# data:  diff(log(AirPassengers))
# Dickey-Fuller = -9.6003, Lag order = 0, p-value = 0.01
# alternative hypothesis: stationary

?deltat
