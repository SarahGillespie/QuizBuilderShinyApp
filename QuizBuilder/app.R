#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(shinyWidgets)
library(tidyverse)
library(RCurl)

# SG: Get the data. You shouldn't have to change this file path for it to work.
# JG: column names for better reading and na strings to ignore when printing questions
vocabulary_questions_df <- read.table("~/GitHub/QuizBuilderShinyApp/vocabulary_questions.txt",
                                      fill = TRUE, header = FALSE, quote = "", sep = "\t", 
                                      col.names=c("source","answer_choices", "correct_answer", "instruction", "question","a", "b","c","d", "e", "f", "g", "h", "i" ),
                                      na.strings = c("EMPTY", "source ??"))

math_questions_df <- read.table("~/Github/QuizBuilderShinyApp/math_questions.txt",
                      fill = TRUE, header = FALSE, quote = "", sep = "\t")

verbal_reasoning_questions_df <- read.table("~/Github/QuizBuilderShinyApp/verbal_reasoning_questions.txt",
                      fill = TRUE, header = FALSE, quote = "", sep = "\t")

# Define UI for application
# the aesthetic aspects of the page: the boxes, what draws the text, 
# displays the images
ui <- fluidPage(

    # Application title
    titlePanel("GRE Practice Quizzes"),

    # sidebar
    sidebarLayout(
        sidebarPanel(
            # HTML formatting
            tags$div(class="header", checked=NA, 
                     tags$h2("Instructions"),
                     tags$p("Select the quiz you want to take from the menu below, then select the number of questions to answer.
                            This is a multiple choice quiz to practice the GRE General Test. Type the letter of your answer choice (or multiple if applicable),
                            No tests in this program are timed. You will receive immediate feedback if your choice is correct or not.
                            You may want scratch paper and a pencil for the math quiz."),
                     tags$h4("Credits"),
                     tags$p("Practice GRE Math, Vocabulary, and Verbal Reasoning Quizzes."),
                     tags$p("Authors: Julia Griner and Sarah Gillespie"),
                     tags$p("Disclaimer: Questions are taken from various online sources, as credited on the README. This program is purely for educational purposes.")
            ) # end div
        ), # end sidebar panel

     mainPanel(
         
         # SG: TASK: randomize the question order
         # SG: TASK: add the score counter.
         selectInput("quiz", "Select a quiz",
                    c("Math", "Vocabulary", "Verbal Reasoning")
         ),
         textOutput("result"),
         
         # choose number of questions to answer
         numericInput("num_questions",
                      "Number of questions",
                      1, min = 1, max = 100), # fix to be max items in the csv file
         
         textInput("entered_answer", "Enter the answer to display below:"),
         textOutput("text")
         
        ) # end main panel
     
     
    )
)# end of UI

# SG: we can define functions here (outside of both UI and server),
#     but call them in server.

# SG: the server is like the calculator part that tells the app how to respond
#     to user input.
server <- function(input, output, session) {

    
    output$result <- renderText({
        paste("You chose", input$quiz)
    })
    
    
    # SWITCH CASE FOR DROP MENU
    quizInput <- reactive({
        switch(input$quiz,
               "Math" = math_quiz,
               "Vocabulary" = vocab_quiz,
               "Verbal Reasoning" = verbal_quiz)
    })
    
    output$text <- renderText({ input$entered_answer })
    output$verb <- renderText({ input$entered_answer })
    
} # end of server function

# Run the application 
shinyApp(ui = ui, server = server)
