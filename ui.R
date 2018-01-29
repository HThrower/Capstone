library(shiny)
shinyUI(fluidPage(
  textInput("text", label = h2("Capstone Next Word Predictor"), value = ""),
  submitButton(text = "Predict next word..."),
  hr(),
  fluidRow((verbatimTextOutput("value",placeholder = TRUE)))
 
 ))

