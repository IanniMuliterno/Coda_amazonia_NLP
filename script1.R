# referência para outros exercicios de regex
library(spacyr)
library(tidyverse)

spacy_install()
spacy_initialize(model = "pt_core_news_sm")


txt <- c(d1 = "spaCy is great at fast natural language processing.",
         d2 = "Mr. Smith spent two years in North Carolina.")

# process documents and obtain a data.table
parsedtxt <- spacy_parse(txt)
parsedtxt

library(tidytext)
library(textdata)
library(transformer)
get_sentiments('afinn')

model <- transformer::load_model("t5-base")

# Tradução de inglês para francês
texts <- c("Hello, how are you?", "I am learning about transformers in R.")
translations <- transformers::translate(model, texts, target_lang = "fr")

# Visualizar resultados
translations


### ** Examples

x <- matrix(rnorm(50 * 512), 50, 512)
d_model <- 512
num_heads <- 8
dff <- 2048

output <- transformer(x, d_model, num_heads, dff)





#####################################################################################




# User search queries
queries <- c("comprar livros", "compra de livros", "comprando livros")

# Function to stem text
stem_text <- function(text) {
  words <- unlist(strsplit(text, " "))
  stemmed_words <- wordStem(words, language = "portuguese")
  return(paste(stemmed_words, collapse = " "))
}

# Apply stemming to product descriptions and queries
products$stemmed_description <- sapply(products$description, stem_text)
stemmed_queries <- sapply(queries, stem_text)

# Example: Matching stemmed queries with stemmed descriptions
for (query in stemmed_queries) {
  cat("Search results for query:", query, "\n")
  matching_products <- products[grepl(query, products$stemmed_description), ]
  print(matching_products)
  cat("\n")
}


# Load necessary libraries
install.packages("tm")
install.packages("tokenizers")
install.packages("dplyr")

library(tm)
library(tokenizers)
library(dplyr)

# Sample text
sample_text <- c("O código Amazônia está incrível!",
                 "Análise de sentimentos é uma parte importante da NLP.",
                 "Vamos remover as stopwords deste texto em português.")

# Create a corpus
corpus <- VCorpus(VectorSource(sample_text))

# Define a function to remove stop words from each sentence
remove_stopwords_from_sentences <- function(text) {
  # Split text into sentences
  sentences <- unlist(tokenize_sentences(text))
  
  # Remove stop words from each sentence
  sentences_clean <- lapply(sentences, function(sentence) {
    words <- unlist(strsplit(sentence, " "))
    words_clean <- removeWords(words, stopwords("pt"))
    return(paste(words_clean, collapse = " "))
  })
  
  # Recombine sentences
  return(paste(sentences_clean, collapse = ". "))
}

# Apply the function to each document in the corpus
corpus_clean <- tm_map(corpus, content_transformer(remove_stopwords_from_sentences))

# Inspect the cleaned corpus
inspect(corpus_clean)


################
# trial de lemmatization com PT

library(tm)

sample_text <- c("O coda Amazônia está incrível!",
                 "Análise de sentimentos é uma parte importante da NLP.",
                 "Vamos remover as stopwords deste texto em português.")
# Create a corpus
corpus <- VCorpus(VectorSource(sample_text))

# Define a function to remove stop words from each sentence
remove_stopwords_from_sentences <- function(text) {

  
  # Remove stop words from each sentence
  sentences_clean <- lapply(text$content, function(sentence) {
    words <- unlist(strsplit(sentence, " "))
    words_clean <- removeWords(words, stopwords("en"))
    return(paste(words_clean, collapse = " "))
  })
  
  # Recombine sentences
  return(paste(sentences_clean, collapse = ". "))
}

# Apply the function to each document in the corpus
corpus_clean <- tm_map(corpus, content_transformer(remove_stopwords_from_sentences))

# Inspect the cleaned corpus
inspect(corpus_clean)
