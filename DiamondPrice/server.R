#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

shinyServer(function(input, output) {
   
  output$plot <- renderPlot({

          p <- as.numeric(input$p)
          data <- reactive({
                  obs <- nrow(diamonds)
                  set.seed(1234)
                  rindex <- sample(1:obs, size = p * obs, replace = FALSE)
                  diamonds[rindex, ]
          }) 
          
          col <- ifelse(input$col == "None", "NULL", input$col)
          p <- ggplot(data(), aes_string(x = input$x, y = "price", color = col)) +
                  geom_point(alpha = as.numeric(input$alpha))
          if(input$frow != "None" | input$fcol != "None"){
                  if(input$frow != "None" & input$fcol != "None") form <- paste(input$frow, "~", input$fcol)
                  else if(input$frow != "None" & input$fcol == "None") form <- paste(input$frow, "~.")
                  else form <- paste(".~", input$fcol)
                  p <- p + facet_grid(as.formula(form), scales = "free")
          }
          if(input$ele == "Boxplot"){
                  p <- p + geom_boxplot()
          } else if(input$ele == "Line") {
                  p <- p + geom_smooth(method = "lm", color = "red")
          }
          p
  })
  
})
