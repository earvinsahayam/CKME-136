library(RWeka)

mydata =read.csv("clean_sentiment_nuclear_power.csv", header = TRUE)
write.arff(x =mydata, file = "clean_sentiment_nuclear_power.arff")
