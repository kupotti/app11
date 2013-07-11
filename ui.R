library(shiny)
shinyUI(pageWithSidebar(
  headerPanel(""),
  sidebarPanel(
    selectInput("type", "number of suicide/ suicide rate", choices = c("number", "rate")),
    sliderInput("year", "change year to move slider: ", min = 1950, max = 2010, value = 1998)
  ),
  mainPanel(
    tableOutput("data"), 
    plotOutput("distPlot")
  )
))
