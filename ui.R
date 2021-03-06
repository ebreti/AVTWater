library(shiny)
library(markdown)

shinyUI(pageWithSidebar(
    headerPanel("Water Consumption by Households in AVT"),
    sidebarPanel(
        selectInput("foco", "Choose water meter:",
                    choices=c("avt", "house#01", "house#02", "house#03", "house#04", 
                              "house#05", "house#06", "house#07", "house#08", "house#09", 
                              "house#10", "house#11", "house#12", "house#13", "house#14", 
                              "house#15", "house#16", "house#17", "house#18", "house#19", 
                              "house#20", "house#21", "common"),
                    selected="avt"),
        submitButton("Show Graph"),
        br(),
        br(),
        includeMarkdown("lightDoc.md")
    ),
    mainPanel(
        plotOutput("graph1")
    )
))
