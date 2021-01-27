#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(RCurl)

# SG: Get the data. You shouldn't have to change this file path for it to work.
# JG: column names for better reading and na strings to ignore when printing questions
vocabulary_questions_df <- read.table("~/GitHub/QuizBuilderShinyApp/vocabulary_questions.txt",
                                      fill = TRUE, header = FALSE, quote = "", sep = "\t", 
                                      col.names=c("source","answer_choices", "correct_answer", "instruction", "question","a", "b","c","d", "e", "f", "g", "h", "i" ),
                                      na.strings = c("EMPTY", "source ??"))

math_questions_df <- read.table("~/Github/QuizBuilderShinyApp/math_questions.txt",
                      fill = TRUE, header = FALSE, quote = "", sep = "\t",
                      col.names=c("source","answer_choices", "correct_answer", "instruction", "question","a", "b","c","d", "e", "f", "g", "h", "i" ),
                      na.strings = c("EMPTY", "source ??"))

verbal_reasoning_questions_df <- read.table("~/Github/QuizBuilderShinyApp/verbal_reasoning_questions.txt",
                      fill = TRUE, header = FALSE, quote = "", sep = "\t",
                      col.names=c("source","answer_choices", "correct_answer", "instruction", "question","a", "b","c","d", "e", "f", "g", "h", "i" ),
                      na.strings = c("EMPTY", "source ??"))

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
                      1, min = 1, max = input$quiz.nrows),
         
         # loads correct quiz with correct number of questions      
         actionButton("start", "Start Quiz"),
         # either using conditionalPanel or insertUI, adds panel of the quiz
         
         # # prints a question
         # # SG: gotta figure out how to do a new line
         math_questions_df$instruction[3],
         math_questions_df$question[3],
         math_questions_df$a[3],
         math_questions_df$b[3],
         math_questions_df$c[3],
         math_questions_df$d[3],
         math_questions_df$e[3]
         
        
        ) # end main panel
    )
)# end of UI

# SG: we can define functions here (outside of both UI and server),
#     but call them in server.

# SG: the server is like the calculator part that tells the app how to respond
#     to user imput.
server <- function(input, output) {
    
    # SG: here is part 2 of the select input option, the server part.
    
    output$result <- renderText({
        paste("You chose", input$quiz)
    })
    
    loadQuiz <- observeEvent(input$start, {
        # load in specific quiz here thru insertUI
        
    })
    
    # SWITCH CASE FOR DROP MENU
    quizInput <- reactive({
        switch(input$quiz,
               "Math" = math_quiz,
               "Vocabulary" = vocab_quiz,
               "Verbal Reasoning" = verbal_quiz)
    })
    
    # SG: here we will bring in the user's answer choice response action.
    # SG: the user clicks a letter or we have a text box to type the answer.
    # SG: check the user input against the answer key.
    
    # SG: functions are common in R. 
    # SG: i.e. server is a whole function. 
    # SG: Other functions should be defined outside server, but called here.
    # SG: I have not seen classes or OOP used but apparently they can be.
    
    
} # end of server function

# Run the application 
shinyApp(ui = ui, server = server)
