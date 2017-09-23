install.packages("wordcloud")
install.packages("wordcloud2")
library("wordcloud")
library("wordcloud2")
wordcloud2(demoFreq, size = 1, minSize = 0, gridSize =  0,  
           fontFamily = NULL, fontWeight = 'normal',  
           color = 'random-dark', backgroundColor = "white",  
           minRotation = -pi/4, maxRotation = pi/4, rotateRatio = 0.4,  
           shape = 'circle', ellipticity = 0.65, widgetsize = NULL) 
demoFreq


install.packages("tm")  # for text mining
install.packages("SnowballC") # for text stemming
install.packages("RColorBrewer") # color palettes
library("tm")
library("SnowballC")
library("RColorBrewer")

filePath <- "http://www.sthda.com/sthda/RDoc/example-files/martin-luther-king-i-have-a-dream-speech.txt"
text <- readLines(filePath)
text
docs<-Corpus(VectorSource(text))

inspect(docs)
toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
docs <- tm_map(docs, toSpace, "/")
docs <- tm_map(docs, toSpace, "@")
docs <- tm_map(docs, toSpace, "\\|")

inspect(docs)

# Convert the text to lower case
docs<-tm_map(docs,content_transformer(tolower))



# Remove numbers
docs<-tm_map(docs,removeNumbers)


# Remove english common stopwords
docs<-tm_map(docs,removeWords,stopwords("english"))



# Remove your own stop word
# specify your stopwords as a character vector

docs<-tm_map(docs,removeWords,c("let","at","my","and"))


# Remove punctuations
docs<-tm_map(docs,removePunctuation)


#Eliminate extra white spaces
docs<-tm_map(docs,stripWhitespace)



#stemming 
docs <- tm_map(docs, stemDocument)



dtm<-DocumentTermMatrix(docs)
dtm
m<-as.matrix(dtm)
m
rowSums(m)
v <- sort(colSums(m),decreasing=TRUE)
v
d <- data.frame(word = names(v),freq=v)
d
head(d,10)



#set seed randomly
set.seed(1234)
names(v)


library(wordcloud)
#plot word cloud
wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))



### Find the frequent terms that occur at least four times
findFreqTerms(dtm,lowfreq = 4)



##Find association with other words
findAssocs(dtm,terms="freedom",corlimit=0.4)


# $freedom
# ring mountain 
# 0.86     0.40 


barplot(d[1:10,]$freq, las = 2, names.arg = d[1:10,]$word,
        col ="lightblue", main ="Most frequent words",
        ylab = "Word frequencies")