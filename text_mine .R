#Read file

twitterdata.sub <- read.csv("C:/Users/Earvin/Desktop/Capstone/clean_sentiment_nuclear_power.csv", header = T)
str(twitterdata.sub)

#build corpus
library(tm)
corpus <- iconv(twitterdata.sub$tweet_text, to = "utf-8", sub = "")
corpus <- Corpus(VectorSource(corpus))
inspect(corpus[1:5])

#Clean text
corpus<-tm_map(corpus,tolower)
corpus<-tm_map(corpus,removePunctuation)
corpus<-tm_map(corpus,removeNumbers)
corpus<-tm_map(corpus,removeWords, stopwords('english'))
inspect(corpus[1:5])

removeURL <- function(x) gsub('http[[:alnum:]]*', '', x)
cleanset <- tm_map(corpus, content_transformer(removeURL))
inspect(cleanset[1:5])

cleanset <- tm_map(cleanset, removeWords, c('link','nuclear'))

cleanset <- tm_map(cleanset, stripWhitespace)


#term document matrix

tdm <- TermDocumentMatrix(cleanset)
tdm <- as.matrix(tdm)
tdm[1:10, 1:20]

# Bar Plot

w <- rowSums(tdm)
w <- subset(w, w>= 10)
w
barplot(w, las = 2, col = rainbow(50))

#Wordcloud
library(wordcloud)
w<- sort(rowSums(tdm), decreasing = TRUE)
set.seed(222)
wordcloud(words = names(w), 
          freq = w, 
          max.words = 1000, 
          random.order = F, 
          min.freq = 5)

library(wordcloud2)
w <- data.frame(names(w), w)
colnames(w) <- c('word', 'freq')
wordcloud2(w, size = 0.8, shape = 'star')





