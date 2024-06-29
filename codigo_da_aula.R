library(stringr)

letras <- c('abc','abcde','xyz')

str_view(letras,'a')

acentos <- c(
  'eu nao curto nao.',
  'eu acho inconcebível não gostar de acentos!'
)

str_view(acentos,'n.o')
str_view(acentos,'n[aã]o')


frase <- c('gosto do numero 42 e 24',
           "eu tenho 29 anos")

str_match_all(frase,'\\d')
str_match_all(frase,"\\d+")
str_match_all(frase,'\\D+')


nome_usuario <- ''

if(str_length(nome_usuario) == 0 ){
  stop("insira seu nome por favor")
}

library(tidyverse)
library(tidytext)
library(rjson)
library(wordcloud2)
library(tm)


hpd <- fromJSON(file = "C:\\Users\\IM_py\\Documents\\GitHub\\Projects\\Coda_amazonia_NLP\\en_train_set.json")

hpd[1:2]
class(hpd)
hpd[[1]]$dialogue
hpd[[1]]$position

extracted_dialogue <- map(hpd,pluck,"dialogue")
extracted_dialogue[1:2]

session_names <- rep(names(extracted_dialogue),
                     times = sapply(extracted_dialogue, length))

tibble_hp <- tibble(dialogue = unlist(extracted_dialogue))


tb_final <- str_split_fixed(tibble_hp$dialogue,pattern = ":",n=2) |> 
  as_tibble() |> 
  mutate(session = session_names,
         personagem = str_trim(V1)) |> 
  select(session, personagem, dialogo = V2)

  
##  questao 1HPD: personagem mais mencionado nos dialogos
lista_per <- unique(tb_final$personagem)

conta_mencoes <- function(person){
  
  sum(
    str_detect(tb_final$dialogo,fixed(person))
    )
}

mentions_list <- sapply(lista_per,conta_mencoes)


mentions_df <- data.frame(personagem = unique(tb_final$personagem),
                          mentions = mentions_list)

mentions_df |> 
  arrange(desc(mentions))
