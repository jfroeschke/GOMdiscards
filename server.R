server <- function(input, output) { 
  
  selectSpeciesPlot <- reactive({
    speciesPlot <- filter(discards, Species==input$pickSpecies)
  })

  selectSectorPlot <- reactive({
    speciesPlot <- filter(selectSpeciesPlot(), Sector==input$pickSector)
  })
  
  selectGearPlot <- reactive({
    speciesPlot <- filter(selectSpeciesPlot(), Gear==input$pickGear)
  })
  

  selectYearPlot <- reactive({
    speciesPlot <- filter(selectGearPlot(), Year>=input$pickYear[1] & Year<= input$pickYear[2] )
  })
  
  # selectTypePlot <- reactive({
  # discards <- selectYearPlot[,input$pickDiscard]
  # })
  
  output$plot <- renderPlot({
   #plot( NumberDiscarded ~ Year, data= selectYearPlot())
    plot( selectYearPlot()[,input$pickDiscard] ~ Year, data= selectYearPlot())
    #plot(cars2)
  })
  
  output$text1  <- renderText({
      #print(nrow(selectYearPlot()))
    print(input$pickDiscard)
    })
  

  
  #########
  output$pickGear <- renderUI({
    pickerInput(
      inputId = "pickGear",
      label = "Select Gear",
      choices = unique(selectSectorPlot()$Gear) #choices
    )
  })
  
  ##########
  
  
  
  ########################## Summary plot of discards
  hcOut <- reactive({

    df <- selectYearPlot()
    df <- data.frame( Year = selectYearPlot()$Year, Discards= selectYearPlot()[,input$pickDiscard])
    colnames(df) <- c("Year", input$pickDiscard)
    #df <- data.frame(Year=1:10, y=11:20)
  discardsOutPlot <- highchart() %>%
    hc_xAxis(categories =df$Year) %>%
    hc_title(text=paste(1,2,input$pickDiscard, sep="+")) %>%
     hc_add_series(name = input$pickDiscard, data = df[,2], type="line", marker = list(enabled = FALSE), color="#fb9a99") #%>%
    # discardsOutPlot
  discardsOutPlot
})
    
  
  output$discardPlotHC <- renderHighchart({hcOut()})    
  
  
  # output$table1  <- renderTable({
  #   df2 <- head(selectYearPlot())
  #   df2 <- data.frame( Year = selectYearPlot()$Year, Discards= selectYearPlot()[,input$pickDiscard])
  #   colnames(df2) <- c("Year", input$pickDiscard)
  #   print(df2)
  # })
  
  output$table1  <- renderTable({
     df <-selectYearPlot()
    df <- data.frame( Year = selectYearPlot()$Year, Discards= selectYearPlot()[,input$pickDiscard])
    colnames(df) <- c("Year", input$pickDiscard)
   
    
    df2 <- data.frame(Species= input$pickSpecies, 
                      Sector = input$pickSector,
                      Subsector = input$pickGear,
                      Years=paste(input$pickYear[1],input$pickYear[2], sep="-" ), 
                      Averagediscards = mean(df[,2]),
                      Units= colnames(df)
                      )
    
    # df2 <- data.frame( Year = selectYearPlot()$Year, Discards= selectYearPlot()[,input$pickDiscard])
    # colnames(df2) <- c("Year", input$pickDiscard)
    print(df2)
  })

# titleReactive <- reactive({paste(input$pickSpecies, input$pickSector, 
#                                  input$pickGear, paste(input$pickYear[1],
#                                                        input$pickYear[2], sep="-" ), sep=" ")    
#                             })
}  
  


#speciesPlot <- filter(discards, Species==input$pickSpecies)