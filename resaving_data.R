library(readr)
library(dplyr)
library(tidyr)
all_ngrams = read_csv("Capstone_ngrams.csv")
colnames(all_ngrams)[1] = "sentence"

all_ngrams = all_ngrams %>% 
  count(sentence)

ss = strsplit(all_ngrams$sentence, split = " ")
ss = sapply(ss, length)
all_ngrams$order = ss

saveRDS(all_ngrams, "total_ngram.rds")
