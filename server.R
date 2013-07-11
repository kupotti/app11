library(shiny)
shinyServer(function(input, output) {
  fig1 <- read.table("table1.txt", head = F, sep = " ")
  idy <- 1
  colnames(fig1) <- c("year", "numt", "numm", "numf", "ratet", "ratem", "ratef", "aadrm", "aadrf") 
  selectedyear <- reactive(function(){
    idt <- ifelse(input$type=="number", 2, 5)
    idm <- ifelse(input$type=="number", 3, 6)
    idf <- ifelse(input$type=="number", 4, 7)
    ids <- which(fig1$year==input$year)
    dataset <- data.frame(合計 = fig1[ids,idt], male = fig1[ids,idm], female = fig1[ids,idf])
    rownames(dataset) <- fig1[ids, 1]
    dataset
  })
  output$distPlot <- reactivePlot(function() {
    idt <- ifelse(input$type=="number", 2, 5)
    idm <- ifelse(input$type=="number", 3, 6)
    idf <- ifelse(input$type=="number", 4, 7)
    ymax <- ifelse(input$type=="number", 35000, 45)
    if(input$type=="number"){
      auxline <- seq(5000, 35000, 5000)
      ylab <- "the number of suicide (persons)"
      main <- "Fig. 1-a. The number of suicide"
    } else{
      auxline <- seq(5, 45, 5)
      ylab <- "the suicide rate (persons per 10000)"
      main <- "Fig. 1-a. The suicide rate"
    }
    plot(fig1[, c(idy, idt)], type = "l", main = main, ylim = c(0, ymax), ylab = ylab, xlab = "Year", family="IPAGothic")
    par(new = T)
    plot(fig1[, c(idy, idm)], type = "l", col = "blue", ylim = c(0, ymax), ylab = ylab, xlab = "Year", family="IPAGothic")
    par(new = T)
    plot(fig1[, c(idy, idf)], type = "l", col = "red", ylim = c(0, ymax), ylab = ylab, xlab = "Year", family="IPAGothic")
    abline(h = auxline, lty = 2, col = "gray")
    abline(v = input$year)
    legend(1950, auxline[length(auxline)], c("総数", "男性", "女性"), lty = 1, col = c("black","blue","red"))
  })
  output$data <- reactiveTable(function(){
    selectedyear()
  })
})
