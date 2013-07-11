library(shiny)
shinyUI(pageWithSidebar(
  headerPanel(""),
  sidebarPanel(
    selectInput("type", "自殺死亡数(number) / 自殺死亡率(rate)", choices = c("number", "rate")),
    sliderInput("year", "スライダーを移動させて年を変更: ", min = 1950, max = 2010, value = 1998)
  ),
  mainPanel(
    tableOutput("data"), 
    plotOutput("distPlot")
  )
))
