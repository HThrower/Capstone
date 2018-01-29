library(shiny)
library(dplyr)
library(stringr)

# load ngram data set
# all_ngrams <- readRDS("total_ngram.rds")
all_ngrams <- readRDS("best_ngram.rds")

source("find_next_word.R")

# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output) {
  
  # You can access the value of the widget with input$text, e.g.
  output$value <- renderPrint({ 
    txt = tolower(input$text)
    find_next_word(txt)
    })

})
