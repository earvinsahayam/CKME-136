#Sentiment Analysis
library(syuzhet)
library(lubridate)
library(ggplot2)
library(scales)
library(reshape2)
library(dplyr)

#Read file

twitterdata.sub <- read.csv("C:/Users/Earvin/Desktop/Capstone/clean_sentiment_nuclear_power.csv", header = T)
tweet <- iconv(twitterdata.sub$tweet_text, to = "utf-8", sub = "")

#Obtain Sentiment
s <- get_nrc_sentiment(tweet)
head(s)
tweet[4]

#Barplot 
barplot(colSums(s), las = 2, col = rainbow(10), ylab = 'Count', main = 'Sentiment Scores')
