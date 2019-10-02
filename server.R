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
  # output$pickSector <- renderUI({
  # pickerInput(
  #   inputId = "pickSector",
  #   label = "Select sector",
  #   if(input$pickSpecies=="RedSnapper"){
  #   choices = c("Recreational" = "Recreational",
  #               "Commercial" = "Commercial"
  #   )} else
  #      if(input$pickSpecies=="Gag"){
  #        choices = c("Recreational" = "Recreational")} else
  #          if(input$pickSpecies=="GreaterAmberjack"){
  #            choices = c("Recreational" = "Recreational")}
  #     )
  #   })#picker input
  
  #########
  output$pickSector <- renderUI({
  radioButtons(
    inputId = "pickSector",
    label = "Select sector",
    if(input$pickSpecies=="RedSnapper"){
    choices = c("Recreational" = "Recreational",
                "Commercial" = "Commercial"
    )} else
       if(input$pickSpecies=="Gag"){
         choices = c("Recreational" = "Recreational")} else
           if(input$pickSpecies=="GreaterAmberjack"){
             choices = c("Recreational" = "Recreational")}
      )
    })#picker input
  
  
  
  # output$pickDiscard <- renderUI({
  # pickerInput(
  #   inputId = "pickDiscard",
  #   label = "Select discard type",
  #   choices = ifelse(input$pickSpecies=="RedSnapper",
  #    c("Numbers Discarded" = "NumberDiscarded",
  #               "Pounds of Discards" = "LbsDiscarded",
  #               "Pounds of Dead Discards" = "LbsDeadDiscarded"),
  #    c("Pounds of Dead Discards" = "LbsDeadDiscarded")
  #   
  #   ) #choices
  # )#, #picker input 
  # })#picker input
  
  
  output$pickDiscard <- renderUI({
    pickerInput(
      inputId = "pickDiscard",
      label = "Select discard type",
      if(input$pickSpecies=="RedSnapper"){
      choices = 
                       c("Numbers Discarded" = "NumberDiscarded",
                         "Pounds of Discards" = "LbsDiscarded",
                         "Pounds of Dead Discards" = "LbsDeadDiscarded")} else
      if(input$pickSpecies=="Gag"){ 
        choices = c("Pounds of Dead Discards" = "LbsDeadDiscarded")} else
          if(input$pickSpecies=="GreaterAmberjack"){
            choices = c("Pounds of Dead Discards" = "LbsDeadDiscarded")}
       #choices
    )#, #picker input 
  })#picker input
  
  ########################## Summary plot of discards
  hcOut <- reactive({

    df <- selectYearPlot()
    df <- data.frame( Year = selectYearPlot()$Year, Discards= selectYearPlot()[,input$pickDiscard])
    colnames(df) <- c("Year", input$pickDiscard)
    X <- nrow(df)
    df2 <- df[X,2]
    df3 <- c(rep(NA, (X-1)), df2)
    df$Final <- df3
    
    #df <- data.frame(Year=1:10, y=11:20)
  discardsOutPlot <- highchart() %>%
    hc_xAxis(categories =df$Year) %>%
    hc_title(text=paste(input$pickSpecies, input$pickYear[1], "-", 
                        input$pickYear[2], sep=" ")) %>%
    hc_subtitle(text=paste(input$pickDiscard, ": ", 
                        input$pickGear, sep="")) %>%
     hc_add_series(name = input$pickDiscard, data = df[,2], type="line", marker = list(enabled = FALSE), color="#008ccc") %>%
  hc_add_series(name = input$pickDiscard, data = df[,3], type="scatter", marker=list(enabled = TRUE), color="#39cccc") %>%
    hc_tooltip(crosshairs = TRUE, borderWidth = 5, sort = TRUE, table = TRUE) %>% 
    hc_exporting(enabled = TRUE)
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
    

    print(df2)
  })

  
  


### use this concept to get discard mortality, use a similar one for avg weight
  output$valueBox1 <- renderValueBox({
    df <- selectYearPlot()
  
    #df <- data.frame( Year = selectYearPlot()$Year, Discards= selectYearPlot()[,input$pickDiscard])
    
    NROW <- nrow(df)
    RT <- df$DiscardMortality[NROW]
    color <- "light-blue"
    
    valueBox(value = ifelse(input$pickGear == "Total commercial" | input$pickGear == "Total recreational",NA, prettyNum(RT,big.mark=",", preserve.width="none")), subtitle = 'Release mortality rate', color = color)
  })
  
  
  output$valueBox2 <- renderValueBox({
    df <- selectYearPlot()
    df <- data.frame( Year = selectYearPlot()$Year, Discards= selectYearPlot()[,input$pickDiscard])
    NROW <- nrow(df)
    RT <- df[NROW,2]
    #RT <- round(RT/1000000,2)
    RT <- round(RT,2)
    color <- "teal"

    valueBox( value = ifelse(input$pickGear == "Total commercial" | input$pickGear == "Total recreational",NA, prettyNum(RT,big.mark=",", preserve.width="none")), subtitle = input$pickDiscard, color = color)
  })
  
  output$valueBox3 <- renderValueBox({

    color <- "light-blue"
    valueBox(value = ifelse(input$pickGear == "Total commercial" | input$pickGear == "Total recreational", NA, 1),
    subtitle = "Percent of removals", color = color)

    
  })
  
  
#### DT table
  output$tbl = renderDT(DT)
  
  
}  
  


