trainingInput<-as.data.frame(runif(50,0,1000))
trainingOutput<-sqrt(trainingInput)

trainData<-cbind(trainingInput,trainingOutput)
colnames(trainData)<-c("input","output")
install.packages("neuralnet")
library(neuralnet)


nn<-neuralnet(formula=output~input,data=trainData,hidden = 10,threshold = 0.01)
head(trainData)
plot(nn)


creditdata<-read.csv("credit_data.csv",T)
head(creditdata)

trainData=creditdata[1:1500,]
testData=creditdata[1501:2000,]


nn=neuralnet(default10yr~LTI+age,trainData,hidden=4,threshold = 0.1,linear.output = F,lifesign = "minimal")

system.time()
Sys.Date()
