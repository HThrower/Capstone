library(shiny)
library(dplyr)
library(stringr)

# load ngram data set
all_ngrams <- readRDS("total_ngram.rds")


find_next_word <- function(current_sentence) { 
  if (nchar(trimws(current_sentence)) == 0) {
    return('')
  }
  
  # find the best next word
  # trailing space at end to avoid picking last word
  matches <- c()
  current_sentence <- paste0(trimws(current_sentence)," ")
  matches = all_ngrams %>% 
    filter(str_detect(sentence, paste0("^", current_sentence))) 
  if (nrow(matches) == 0) {
    return("")
  }
  
  matches = matches %>% 
    arrange(order, desc(n))
  
  # find highest probability word - ties will give both
  matches = matches %>% 
    filter(order == min(order),
           n == max(n))
  
  matches = matches$sentence
  
  # didn't find a match so return nothing
  if (is.null(matches)) {
    return ('')
  }
  
  # use highest number and a random of highest for multiples
  best_matched_sentence <- sample(matches, size = 1)
  best_matched_sentence = sub(current_sentence, "", best_matched_sentence)
  best_matched_sentence = trimws(best_matched_sentence)
  # split the best matching sentence by the search word
  # best_match <- strsplit(x = best_matched_sentence, split = current_sentence)[[1]]
  # # split second part by spaces and pick first word
  # best_match <-  strsplit(x = best_match[[2]], split = " ")[[1]]
  # return first word
  return(best_matched_sentence)
  # return (best_match[[1]]) 
}

# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output) {
  
  # Return the requested dataset
  datasetInput <- reactive({
    find_next_word(tolower(input$current_sentence))
  })
  
  # You can access the value of the widget with input$text, e.g.
  output$value <- renderPrint({ 
    txt = tolower(input$text)
    paste(txt, find_next_word(txt))
    })
  

})
