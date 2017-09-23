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
