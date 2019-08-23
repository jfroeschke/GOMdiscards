server <- function(input, output) { 
  
  output$plot <- renderPlot({
    cars2 <- cars + rnorm(nrow(cars))
    plot(cars2)
  })
  output$plot2 <- renderPlot({
    cars2 <- cars + rnorm(nrow(cars))
    plot(cars2, main='plot2')
  })
    
  }
