library(readr)
library(dplyr)
library(tidyr)
all_ngrams <- readRDS("best_ngram.rds")

source("find_next_word.R")

find_next_word("i")
