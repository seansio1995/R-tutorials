summary(mtcars)
summary(log(mtcars))

mean(mtcars$mpg)


cor(mtcars)
####
# vs          am       gear        carb
# mpg   0.6640389  0.59983243  0.4802848 -0.55092507
# cyl  -0.8108118 -0.52260705 -0.4926866  0.52698829
# disp -0.7104159 -0.59122704 -0.5555692  0.39497686
# hp   -0.7230967 -0.24320426 -0.1257043  0.74981247
# drat  0.4402785  0.71271113  0.6996101 -0.09078980
# wt   -0.5549157 -0.69249526 -0.5832870  0.42760594
# qsec  0.7445354 -0.22986086 -0.2126822 -0.65624923
####

##For multiple line comment out: Command+Shift+C

cor(log(mtcars))
pairs(iris)
library(lattice)
splom(iris)


###For data types
head(iris)


mysubset=subset(iris,Species="setosa")
mysubset


head(mysubset)
head(mysubset[-2])
