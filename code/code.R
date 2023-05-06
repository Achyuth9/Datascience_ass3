# Load required libraries
library(tm)
library(wordcloud)
library(RColorBrewer)

# Read the data from the file
data <- read.csv("~/Downloads/Corona_NLP_test.csv")

# Convert the text corpus into tokens
corpus <- Corpus(VectorSource(data$OriginalTweet))
corpus <- tm_map(corpus, tolower)
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeWords, stopwords("english"))
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, stemDocument)

# Create a document-term matrix
dtm <- DocumentTermMatrix(corpus)

# Count word frequencies
word_freq <- colSums(as.matrix(dtm))

# Sort the word frequencies in descending order
sorted_word_freq <- sort(word_freq, decreasing = TRUE)

# Generate word cloud
wordcloud(names(sorted_word_freq), sorted_word_freq, colors = brewer.pal(8, "Dark2"))

