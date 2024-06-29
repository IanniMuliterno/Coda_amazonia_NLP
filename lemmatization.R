library(readr)
library(tm)

exemplo<-"se eu comesse açai com peixe, eu estaria comendo açai, mas comeria achando que é outra coisa, pois o açai que to acostumado não é comestível com peixe."
exemplo

chartr("áéíóúâêô", "aeiouaeo", exemplo)

exemplo2<-chartr("áéíóúÁÉÍÓÚýÝàèìòùÀÈÌÒÙâêîôûÂÊÎÔÛãõÃÕñÑäëïöüÄËÏÖÜÿçÇ",
                 "aeiouaeiouyyaeiouaeiouaeiouaeiouaoaonnaeiouaeiouycc",exemplo)
exemplo2


exemplo_corpus <- VCorpus(VectorSource(exemplo))

exemplo_corpus <- tm_map(exemplo_corpus, content_transformer(tolower))
exemplo_corpus <- tm_map(exemplo_corpus, removePunctuation)
exemplo_corpus <- tm_map(exemplo_corpus, removeNumbers)
exemplo_corpus <- tm_map(exemplo_corpus, removeWords, stopwords("portuguese"))
exemplo_corpus <- tm_map(exemplo_corpus, stripWhitespace)
exemplo_corpus <- TermDocumentMatrix(exemplo_corpus)

exemplo_corpus_matrix <- as.matrix(exemplo_corpus)
palavras<-row.names(exemplo_corpus_matrix)


lemma_dic <- read.delim(file = "https://raw.githubusercontent.com/michmech/lemmatization-lists/master/lemmatization-pt.txt", header = FALSE, stringsAsFactors = FALSE)
names(lemma_dic) <- c("stem", "term")


for (j in 1:length(palavras)){
  comparacao <- palavras[j] == lemma_dic$term
  if (sum(comparacao) == 1){
    palavras[j] <- as.character(lemma_dic$stem[comparacao])
  } else {
    palavras[j] <- palavras[j]
  }
}
palavras
