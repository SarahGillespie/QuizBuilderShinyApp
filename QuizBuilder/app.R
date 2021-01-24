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
        ), # end sidebar panel

        # Show a plot of the generated histogram distribution
        mainPanel(
           plotOutput("distPlot"), # SG: delete later
           
           # SG: prints a dropdown menu for a pre-loaded cars dataset.
           # SG: TASK: swap the preloaded variables/states to be the quiz options for our app
           # SG: docs all about the dropdown menu: https://shiny.rstudio.com/reference/shiny/latest/selectInput.html
           # SG: this is only part 1 of the dropdown menu, UI part.
           #     the part that then responds to the user selection is in the server.

           selectInput("state", "Choose a state:",
                       list(`East Coast` = list("NY", "NJ", "CT"),
                            `West Coast` = list("WA", "OR", "CA"),
                            `Midwest` = list("MN", "WI", "IA"))
           ),
           textOutput("result"),
           
           # SG: our text should be displayed below the histogram.
           mainPanel(
              
               # SG: TASK: need a button to pick which quiz you want to do
               # SG: TASK: need a button to decide how many questions you want to do
               # SG: TASK: randomize the question order
               # SG: TASK: add the score counter.
               
               # prints a question
               math_questions_df$V1[3],# SG: calls the cell that is in the 3rd row of the first column in the math df
               # SG: gotta figure out how to do a new line
               math_questions_df$V2[3],
               math_questions_df$V3[3],
               math_questions_df$V4[3],
               math_questions_df$V5[3],
               math_questions_df$V6[3]
               
               )
           
           
        ) # end main panel
    )
)# end of UI

# SG: we can define functions here (outside of both UI and server),
#     but call them in server.

# SG: the server is like the calculator part that tells the app how to respond
#     to user imput.
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white')
    })
    
    # SG: here is part 2 of the select input option, the server part. 
    # SG: TASK: make the app print words stating the specific test that was chosen.
    
    output$result <- renderText({
        paste("You chose", input$state)
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
