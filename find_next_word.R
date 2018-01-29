
find_next_word <- function(current_sentence) { 
  current_sentence = gsub("\\s\\s", " ", current_sentence)
  current_sentence = trimws(current_sentence)
  if (nchar(current_sentence) == 0) {
    return('')
  }
  
  # find the best next word
  # trailing space at end to avoid picking last word
  # current_sentence <- paste0(trimws(current_sentence)," ")
  # matches = all_ngrams %>% 
  #   filter(str_detect(sentence, paste0("^", current_sentence))) 
  
  matches = all_ngrams %>% 
    filter(predictor == current_sentence)
  if (nrow(matches) == 0) {
    return("")
  }
  
  # find highest probability word - ties will give both
  # matches = matches %>% 
  #   arrange(order, desc(n))
  # matches = matches %>% 
  #   filter(order == min(order),
  #          n == max(n))
  
  matches = matches$sentence
  
  # didn't find a match so return nothing
  if (is.null(matches)) {
    return('')
  }
  
  # use highest number and a random of highest for multiples
  if (length(matches) > 1) {
    best_matched_sentence <- sample(matches, size = 1)
  } else {
    best_matched_sentence = matches
  }
  # best_matched_sentence = sub(current_sentence, "", best_matched_sentence)
  best_matched_sentence = trimws(best_matched_sentence)
  # split the best matching sentence by the search word
  # best_match <- strsplit(x = best_matched_sentence, split = current_sentence)[[1]]
  # # split second part by spaces and pick first word
  # best_match <-  strsplit(x = best_match[[2]], split = " ")[[1]]
  # return first word
  return(best_matched_sentence)
  # return (best_match[[1]]) 
}
