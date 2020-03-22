library(tm)#for corpus and term document matrix creation/processing 
library(SnowballC) #for stemming of words in corpus
library(wordcloud) #for creation of a wordcloud
library(cluster) #for kmeans cluster creation
library(rpart) #for using decision trees
library(caret) #for faster Classification and Regression modelling techniques

twitterdata.sub <- read.csv("C:/Users/Earvin/Desktop/Capstone/clean_sentiment_nuclear_power.csv")
twitterdata.sub <- na.omit(twitterdata.sub)

##regular expression
## remove letters, digits, and punctuation haracters starting with @ remove usernames and replace with "USER"
twitterdata.sub <- gsub("@\\w*"," USER",   twitter.sub$Text)


##Remove website links and replace with "URL"
twitterdata.sub  <- gsub("http[[:alnum:][:punct:]]*"," WEBADDRESS",   tolower(twitter.sub$Text ))
twitterdata.sub  <- gsub("www[[:alnum:][:punct:]]*"," WEBADDRESS",   tolower(twitter.sub$Text ))

#remove html entitties like &quot; starting with 
#note perfect but we will remove remaining punctation at later step
twitterdata.sub<-gsub("\\&\\w*;","", twitter.sub$Text)


#remove any letters repeated more than twice (eg. hellooooooo -> helloo)
twitterdata.sub  <- gsub('([[:alpha:]])\\1+', '\\1\\1', twitter.sub$Text)

#additional cleaning removing leaving only letters numbers or spaces
twitterdata.sub <- gsub("[^a-zA-Z0-9 ]","",twitter.sub$Text)

#review tweets now
#head(twitterdata.sub,30)

Twitter_Corpus <- Corpus(VectorSource(twitterdata.sub))
Twitter_Corpus <- tm_map(Twitter_Corpus, stemDocument)
Twitter_Corpus <- tm_map(Twitter_Corpus, removePunctuation)
Twitter_Corpus <- tm_map(Twitter_Corpus, removeNumbers)
Twitter_Corpus <- tm_map(Twitter_Corpus, removeWords, stopwords("english"))
Twitter_Corpus <- tm_map(Twitter_Corpus, stripWhitespace)  

tdm <- TermDocumentMatrix(Twitter_Corpus)

tdm <- removeSparseTerms(tdm, 0.98)

m = as.matrix(tdm)
v <- sort(rowSums(m), decreasing = TRUE)
d <- data.frame(word = names(v), freq = v)

set.seed(2)
wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))
