################################################################################
# Creators:
# Date: Spring 2021
# Most up-to-date version located at
################################################################################

library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(shinyWidgets)
library(tidyverse)
library(RCurl)

# Get the data -----------------------------------------------------------------
# Retrieves the txt file data from the local file.
vocabulary_questions_df <- read.table("~/GitHub/QuizBuilderShinyApp/vocabulary_questions.txt",
                                      fill = TRUE, header = FALSE, quote = "", sep = "\t", 
                                      col.names=c("source","answer_choices", 
                                                  "correct_answer", "instruction",
                                                  "question",
                                                  "a", "b","c","d", "e", "f",
                                                  "g", "h", "i" ),
                                      na.strings = c("EMPTY", "source ??"))

math_questions_df <- read.table("~/Github/QuizBuilderShinyApp/math_questions.txt",
                      fill = TRUE, header = FALSE, quote = "", sep = "\t")

verbal_reasoning_questions_df <- read.table("~/Github/QuizBuilderShinyApp/verbal_reasoning_questions.txt",
                      fill = TRUE, header = FALSE, quote = "", sep = "\t")

spanish_nature_questions_df <- read.table("~/Github/QuizBuilderShinyApp/spanish_nature.txt",
                                            fill = TRUE, header = FALSE, quote = "", sep = "\t")

# Define functions -------------------------------------------------------------


# UI ---------------------------------------------------------------------------
# Define UI for application
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
                    c("Math", "Vocabulary", "Verbal Reasoning", "Spanish Nature")
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

# Sever ------------------------------------------------------------------------
server <- function(input, output, session) {

    
    output$result <- renderText({
        paste("You chose", input$quiz)
    })
    
    
    # drop down option for the quiz type
    quizInput <- reactive({
        switch(input$quiz,
               "Math" = math_quiz,
               "Vocabulary" = vocab_quiz,
               "Verbal Reasoning" = verbal_quiz,
               "Spanish Nature" = spanish_nature)
    })
    
    output$text <- renderText({ input$entered_answer })
    output$verb <- renderText({ input$entered_answer })
    
} # end of server function

# Run the application 
shinyApp(ui = ui, server = server)
