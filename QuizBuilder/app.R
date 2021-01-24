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

vocabulary_questions_df <- read.table("~/GitHub/QuizBuilderShinyApp/vocabulary_questions.txt",
                                      fill = TRUE, header = FALSE, quote = "", sep = "\t")

math_questions_df <- read.table("~/Github/QuizBuilderShinyApp/math_questions.txt",
                      fill = TRUE, header = FALSE, quote = "", sep = "\t")

verbal_reasoning_questions_df <- read.table("~/Github/QuizBuilderShinyApp/verbal_reasoning_questions.txt",
                      fill = TRUE, header = FALSE, quote = "", sep = "\t")

# Define UI for application that draws a histogram
# the aesthetic aspects of the page: the boxes, what draws the text, 
# displays the images
ui <- fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot"),
           
           # SG: our text should be displayed below the histogram.
           mainPanel(
              
               # SG: TASK: need a button to pick which quiz you want to do
               # SG: TASK: need a button to decide how many questions you want to do
               # SG: TASK: randomize the question order
               # SG: TASK: add the score counter.
               
               math_questions_df$V1[3],# SG: calls the cell that is in the 3rd row of the first column in the math df
               # SG: gotta figure out how to do a new line
               math_questions_df$V2[3],
               math_questions_df$V3[3],
               math_questions_df$V4[3],
               math_questions_df$V5[3],
               math_questions_df$V6[3]
               
               ) 
           
           
        )
    )
)# end of UI

# SG: define functions here, but call them in server.

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white')
    })
    
    # SG: here we will bring in each question and its answer choices.
    # SG: the user clicks a letter or we have a text box to type the answer.
    # SG: check the user input against the answer key.
    
    # SG: functions are common in R. 
    # SG: i.e. server is a whole function. 
    # SG: Other functions should be defined outside server, but called here.
    # SG: I have not seen classes or OOP used but apparently they can be.
    
    
} # end of server function

# Run the application 
shinyApp(ui = ui, server = server)
