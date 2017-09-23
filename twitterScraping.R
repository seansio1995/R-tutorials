install.packages("twitteR")
install.packages("ROAuth")
library(twitteR)
library(ROAuth)
consumer.key<-"Kcaho6EqbO5iXm8Du8QwK9ukl"
consumer.secret<-"mCkCFfedn19gkHN1h0r5X3Qfwm89WuC3s4uQJwjR2X68Ei5S9f"

access.key<-"2281960826-dKey8Nb3M2sQwwsOAWfr6fnEB06CmD6TzyiOOkf"
access.secret<-"C6i0GdVsGkgYYPtcwChefaWB3LL4mpGHGeE5xZQrg5L3i"
getwd()
setwd("/Users/tfsp-h/Documents/R/R-tutorials/")
authenticate <- OAuthFactory$new(consumerKey=key,
                                 consumerSecret=secret,
                                 requestURL='https://api.twitter.com/oauth/request_token',
                                 accessURL='https://api.twitter.com/oauth/access_token',
                                 authURL='https://api.twitter.com/oauth/authorize')

registerTwitterOAuth(authenticate)
?setup_twitter_oauth
# setup_twitter_oauth(authenticate)
setup_twitter_oauth(consumer.key,consumer.secret,access.key,access.secret)

userTimeline("Udemy")
udemyTweets<-searchTwitter("#Udemy",n=1000)
head(udemyTweets,5)

class(udemyTweets)
length(udemyTweets)
head(udemyTweets)

install.packages("tm")
library("tm")

udemyList<-sapply(udemyTweets,function(x) x$getText())
length(udemyList)
head(udemyList)

udemycorpus <- Corpus(VectorSource(udemyList))

udemycorpus<-tm_map(udemycorpus,content_transformer(tolower))
udemycorpus <- tm_map(udemycorpus, removePunctuation)
