library(readr)
library(dplyr)
library(tidyr)
all_ngrams = read_csv("Capstone_ngrams.csv")
colnames(all_ngrams)[1] = "sentence"

all_ngrams = all_ngrams %>% 
  count(sentence)

orig = all_ngrams


ss = strsplit(all_ngrams$sentence, split = " ")
order_ngram = sapply(ss, length)

predictor = mapply(function(x, n) {
  paste(x[seq(1, n - 1)], collapse = " ")
}, ss, order_ngram)
all_ngrams$predictor = predictor
all_ngrams$order = order_ngram

# reorder the data
all_ngrams = all_ngrams %>% 
  arrange(predictor, order, desc(n))

saveRDS(all_ngrams, "total_ngram.rds")

# take only the top
best_ngrams = all_ngrams %>% 
  group_by(predictor) %>% 
  filter(n == max(n)) %>%
  ungroup

saveRDS(best_ngrams, "best_ngram.rds")
