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
