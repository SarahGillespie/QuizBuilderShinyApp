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
           plotOutput("distPlot")
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
