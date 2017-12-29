#udemycorpu
library("twitteR")
install.packages("twitteR")
########################################################

### Handling Strings in R


# What are Strings?
# It is a type of data - mainly text data
# quotations "" are used to specify data as a string (character)


mystring <- "this is a string!"
mystring


# Where are Strings mainly used?
# Scraped data: Twitter, Google, etc
# Text based data e.g. Sentiment Analysis
# Text Mining,....


# What are the main ways in R to handle Strings?
# R Base offers useful features to handle Strings e.g. gsub
# In order to be able to handle Strings a sublanguage (Regular Expressions) is used
# Add ons are available like "stringr" and "gsubfun"



# - Important note: According to your location and computer, characters 
# (e.g. from Twitter messages) may be encoded or used differently in your R session
# for example you might sometimes scrape texts is cyrillic or mandarin 
# hence usage of Regular Expressions may slightly differ



# changing the cases
tolower("Graphs and Histograms")

toupper("Graphs and Histograms")

# splitting the string in single character values
strsplit("Graphs and Histograms", NULL)

# splitting strings after each space
strsplit("Graphs and Histograms", " ")



## Substitution in Strings - gsub family


# lets get a character vector with 2 strings
teststring <- c("my teststring to explain how substitution with my R Base works", 
                "another teststring for My example of gsub and sub")


# output
teststring



# 1. structure of the sub/gsub family
gsub("my", "OUR", teststring)


# 2. difference sub vs gsub - sub exchanges only the first occurance per string
sub("my", "OUR", teststring)


# 3. working with cases - see the last string My
gsub("my", "OUR", teststring, ignore.case = T)


# 4. working with numbers - deleting numbers
numberstring <- c("3445 is GReater than 23 - @???!¡ì$",
                  "Tom coded 11 Java scrips and 23 Python scripts")


numberstring



# we need to check the regular expression syntax to see how digits are encoded
gsub("\\d", "", numberstring)


# now we go the other way round and replace anything not beeing a digit
gsub("\\D", "", numberstring)


# 5.avoid the spaces
gsub("\\s", "", numberstring)


# 6. advanced methods


# lets exchange specific letters with "Q"
gsub("[iot]", "Q", numberstring)


# removing punctuation
gsub("[[:punct:]]", "", numberstring)


# removing anything but graphical characters
gsub("[^[:graph:]]", "", numberstring)




# Package stringer offers several useful functions for string handling
install.packages("stringr")

library(stringr)


teststring <- c("my teststring to explain how substitution with my R Base works", 
                "another teststring for My example of gsub and sub")


numberstring <- c("3445 is GReater than 23 - @???!¡ì$",
                  "Tom coded 11 Java scrips and 23 Python scripts")


# adding strings together
result<-str_c(c(numberstring, teststring), sep="")

result[3]
# we can count the occurences of a specific symbol in an element
str_count(numberstring, "3")


# we can locate the first and last position of a symbol in a given string
str_locate_all(numberstring, "3")


# replacement similar to sub - first occurence
str_replace(numberstring, "\\d", "")


# and gsub - all occurences
str_replace_all(numberstring, "\\d", "")


# library(gsubfn) - can be used to incorporate functions to gsub




### Exercise

ourstring <- c("Tom found 74 apples", "Is this a question?", 
               "How many $ and ??? doEs it cost?")

ourstring


# 1. put the string to complete lowercase
# 2. remove the punctuation
# 3. remove the spaces
# 4. remove the ??? sign (if you have it on your keyboard)
# 5. use str_extract_all from stringer to see which element contains "is"

ourstring = tolower(ourstring); ourstring # 1



ourstring = gsub("[[:punct:]]", "", ourstring); ourstring # 2



ourstring = gsub("\\s", "", ourstring); ourstring # 3



ourstring = gsub("[???]", "", ourstring); ourstring # 4



str_extract_all(ourstring, "is") # 5




# download the txt files to your wd

# import positive and negative words
pos = readLines("Positive-Words.txt")
neg = readLines("Negative-Words.txt")

# Lets run a test to see how this works!

mytest= c("great you re here", "awesome experience", 
          "You had a bad night", "She loves ugly candy")

# the score.sentiment function is self written
testsentiment = score.sentiment(mytest, pos, neg)

class (testsentiment)

testsentiment$score
# output corresponds to the 4 test sentences - sentences can be manipulated

# Lets do the whole process: writting the function and scraping - approach after J. Breen

library("stringr")

library("plyr")

# function score.sentiment - this is how the whole function is written
score.sentiment = function(sentences, pos.words, neg.words, .progress='none')
{
  # Parameters
  # sentences: vector of text to score
  # pos.words: vector of words of postive sentiment
  # neg.words: vector of words of negative sentiment
  # .progress: passed to laply() to control of progress bar
  
  # create simple array of scores with laply
  scores = laply(sentences,
                 function(sentence, pos.words, neg.words)
                 {
                   # remove punctuation - using global substitute
                   sentence = gsub("[[:punct:]]", "", sentence)
                   # remove control characters
                   sentence = gsub("[[:cntrl:]]", "", sentence)
                   # remove digits
                   sentence = gsub('\\d+', '', sentence)
                   
                   # define error handling function when trying tolower
                   tryTolower = function(x)
                   {
                     # create missing value
                     y = NA
                     # tryCatch error
                     try_error = tryCatch(tolower(x), error=function(e) e)
                     # if not an error
                     if (!inherits(try_error, "error"))
                       y = tolower(x)
                     # result
                     return(y)
                   }
                   # use tryTolower with sapply 
                   sentence = sapply(sentence, tryTolower)
                   
                   # split sentence into words with str_split (stringr package)
                   word.list = str_split(sentence, "\\s+")
                   words = unlist(word.list)
                   
                   # compare words to the dictionaries of positive & negative terms
                   pos.matches = match(words, pos.words)
                   neg.matches = match(words, neg.words)
                   
                   # get the position of the matched term or NA
                   # we just want a TRUE/FALSE
                   pos.matches = !is.na(pos.matches)
                   neg.matches = !is.na(neg.matches)
                   
                   # final score
                   score = sum(pos.matches) - sum(neg.matches)
                   return(score)
                 }, pos.words, neg.words, .progress=.progress )
  
  # data frame with scores for each sentence
  scores.df = data.frame(text=sentences, score=scores)
  return(scores.df)
}

# tweets for country
usatweets = searchTwitter("usa", n=900, lang="en")
usatweets
indiatweets = searchTwitter("india", n=900, lang="en")
russiatweets = searchTwitter("russia", n=900, lang="en")
chinatweets = searchTwitter("china", n=900, lang="en")

# get text
usa_txt = sapply(usatweets, function(x) x$getText())
india_txt = sapply(indiatweets, function(x) x$getText())
russia_txt = sapply(russiatweets, function(x) x$getText())
china_txt = sapply(chinatweets, function(x) x$getText())

# how many tweets of each country
nd = c(length(usa_txt), length(india_txt), length(russia_txt), length(china_txt))

# join texts
country = c(usa_txt, india_txt, russia_txt, china_txt) 

# apply function score.sentiment
scores = score.sentiment(country, pos, neg, .progress='text')

# add variables to data frame
scores$country = factor(rep(c("usa", "india", "russia", "china"), nd))
scores$very.pos = as.numeric(scores$score >= 2)
scores$very.neg = as.numeric(scores$score <= -2)

# how many very positives and very negatives
numpos = sum(scores$very.pos)
numneg = sum(scores$very.neg)

# global score
global_score = round( 100 * numpos / (numpos + numneg) )

head(scores)

boxplot(score~country, data=scores)

library("lattice")

histogram(data=scores, ~score|country, main="Sentiment Analysis of 4 Countries", xlab="", sub="Sentiment Score")

### Alternative Wordcloud - vector approach

tweettext = sapply(bitcoin, function(x) x$getText())

tweettext=lapply(tweettext, function(x) iconv(x, "latin1", "ASCII", sub=""))
tweettext=lapply(tweettext, function(x) gsub("htt.*",' ',x))
tweettext=lapply(tweettext, function(x) gsub("#",'',x))
tweettext=unlist(tweettext)
tweettext=tolower(tweettext)

library("wordcloud")

? wordcloud

wordcloud(tweettext, min.freq=4, scale=c(5,1), 
          random.color=F, max.word=45, random.order=F)

### removing words out of vectors

mytest = c("dfd", "sadf", "wer")

class(mytest)

myindex = which(mytest == "dfd")

mytest[-myindex]

tweettext2 = which(tweettext == "amp")




# import positive and negative words
pos = readLines("positive_words.txt")
neg = readLines("negative_words.txt")

library("stringr")

library("plyr")

score.sentiment = function(sentences, pos.words, neg.words, .progress='none')
  
{
  
  scores = laply(sentences,
                 function(sentence, pos.words, neg.words)
                 {
                   # remove punctuation - using global substitute
                   sentence = gsub("[[:punct:]]", "", sentence)
                   # remove control characters
                   sentence = gsub("[[:cntrl:]]", "", sentence)
                   # remove digits
                   sentence = gsub('\\d+', '', sentence)
                   
                   # define error handling function when trying tolower
                   tryTolower = function(x)
                   {
                     # create missing value
                     y = NA
                     # tryCatch error
                     try_error = tryCatch(tolower(x), error=function(e) e)
                     # if not an error
                     if (!inherits(try_error, "error"))
                       y = tolower(x)
                     # result
                     return(y)
                   }
                   # use tryTolower with sapply 
                   sentence = sapply(sentence, tryTolower)
                   
                   # split sentence into words with str_split (stringr package)
                   word.list = str_split(sentence, "\\s+")
                   words = unlist(word.list)
                   
                   # compare words to the dictionaries of positive & negative terms
                   pos.matches = match(words, pos.words)
                   neg.matches = match(words, neg.words)
                   
                   # get the position of the matched term or NA
                   # we just want a TRUE/FALSE
                   pos.matches = !is.na(pos.matches)
                   neg.matches = !is.na(neg.matches)
                   
                   # final score
                   score = sum(pos.matches) - sum(neg.matches)
                   return(score)
                 }, pos.words, neg.words, .progress=.progress )
  
  # data frame with scores for each sentence
  scores.df = data.frame(text=sentences, score=scores)
  return(scores.df)
}

# tweets for companies - may not get the full 900
bayertweets = searchTwitter("#bayer", n=900, lang="en", cainfo="cacert.pem")
pfizertweets = searchTwitter("#pfizer", n=900, lang="en", cainfo="cacert.pem")
rochetweets = searchTwitter("#roche", n=900, lang="en", cainfo="cacert.pem")
novartistweets = searchTwitter("#novartis", n=900, lang="en", cainfo="cacert.pem")

# get text
bayer_txt = sapply(bayertweets, function(x) x$getText())
pfizer_txt = sapply(pfizertweets, function(x) x$getText())
roche_txt = sapply(rochetweets, function(x) x$getText())
novartis_txt = sapply(novartistweets, function(x) x$getText())

# how many tweets 
nd = c(length(bayer_txt), length(pfizer_txt), length(roche_txt), length(novartis_txt))

# join texts
company = c(bayer_txt, pfizer_txt, roche_txt, novartis_txt) 

# apply function score.sentiment
scores = score.sentiment(company, pos, neg, .progress='text')

# add variables to data frame
scores$company = factor(rep(c("bayer", "pfizer", "roche", "novartis"), nd))
scores$very.pos = as.numeric(scores$score >= 2)
scores$very.neg = as.numeric(scores$score <= -2)

# how many very positives and very negatives
numpos = sum(scores$very.pos)
numneg = sum(scores$very.neg)

# global score
global_score = round( 100 * numpos / (numpos + numneg) )

head(scores)
par(bty="l")
boxplot(score~company, data=scores, col=c("red", "grey"))

library("lattice")

histogram(data=scores, ~score|company, main="Sentiment Analysis of 4 Companies", col=c("red", "grey"),
          xlab="", sub="Sentiment Score")




###twitter connection

library("httr")
key="Kcaho6EqbO5iXm8Du8QwK9ukl"

secret="mCkCFfedn19gkHN1h0r5X3Qfwm89WuC3s4uQJwjR2X68Ei5S9f"

access_token<-"2281960826-dKey8Nb3M2sQwwsOAWfr6fnEB06CmD6TzyiOOkf"

  
access_secret<-"C6i0GdVsGkgYYPtcwChefaWB3LL4mpGHGeE5xZQrg5L3i"

download.file(url="http://curl.haxx.se/ca/cacert.pem", 
              destfile="C:/Users/seansio1995/Documents/cacert.pem",
              method="auto")
setup_twitter_oauth(key,secret,access_token,access_secret)

# authenticate <-  OAuthFactory$new(consumerKey=key,
#                                   consumerSecret=secret,
#                                   requestURL='https://api.twitter.com/oauth/request_token',
#                                   accessURL='https://api.twitter.com/oauth/access_token',
#                                   authURL='https://api.twitter.com/oauth/authorize')