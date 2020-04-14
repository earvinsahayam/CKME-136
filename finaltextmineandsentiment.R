#Read file
Sys.setlocale('LC_ALL','C')
twitter <- read.csv("C:/Users/Earvin/Desktop/Capstone/clean_sentiment_nuclear_power.csv")
str(twitter)
twittercorpus <- iconv(twitter$tweet_text, to = "utf-8", sub = "")
twittercorpus <- Corpus(VectorSource(twitter$tweet_text))
summary(twittercorpus)
str(twittercorpus)
inspect(twittercorpus[1])

twittercorpus<-tm_map(twittercorpus,content_transformer(tolower))
summary(twittercorpus)
twittercorpus<-tm_map(twittercorpus,removePunctuation)
twittercorpus<-tm_map(twittercorpus,removeNumbers)
twittercorpus<-tm_map(twittercorpus,removeWords, stopwords('english'))
twittercorpus <- tm_map(twittercorpus, content_transformer(function(x) gsub('http[[:alnum:]]*', '', x)))
twittercorpus <- tm_map(twittercorpus, removeWords, c('link','nuclear', 'mention', 'rt'))
twittercorpus  <- tm_map(twittercorpus , stripWhitespace)
twittercorpus <- Corpus(VectorSource(twittercorpus))
inspect(twittercorpus)

twittertdm <- DocumentTermMatrix(twittercorpus)
twittertdm
inspect(twittertdm[1:1, 1:20])
twittertdm <- removeSparseTerms(twittertdm,0.99)
twittertdm

findFreqTerms(twittertdm, 10)

twittermatrix <- as.matrix(twittertdm)
twittermatrix

require("tm.lexicon.GeneralInquirer")

neg_words <- read.table("C:/Users/Earvin/Desktop/Capstone/negative-words.txt", fill = T, header = F, stringsAsFactors = F)[, 1]
pos_words <- read.table("C:/Users/Earvin/Desktop/Capstone/positive-words.txt", fill = T, header = F, stringsAsFactors = F)[, 1]

twitter$neg <- sapply(twittercorpus, tm_term_score,  neg_words)
summary(neg_words)
