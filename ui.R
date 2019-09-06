ui <- 
  
  dashboardPage(
                dashboardHeader(title="GOM Discards"),
                dashboardSidebar(disable=TRUE,
                  
                  sidebarMenu(disable = TRUE,
                    tags$head(includeCSS("Style.css")),
                    tags$head(includeCSS("Style2.css")),
                    menuItem(" ", tabName = "menu1"),
                    
                    #menuItem("Menu 2", tabName = "menu2", icon = icon("gears")),
                    br(),
                    br(),
                    div(img(src="logo.png"), style="text-align: center;"),
                    div(tags$a(href="mailto: portal@gulfcouncil.org", h4("portal@gulfcouncil.org")), align="center"),
                    div(br()),
                    br(),
                    br(),
                    HTML("<h5 id='title' style='text-align:center;' >Gulf of Mexico <br> Fishery Management Council <br> 4107 W. Spruce Street, Suite 200 <br>
                         Tampa, Florida 33607 USA <br> P: 813-348-1630")
                    
                    )
                  
                ),
  dashboardBody(
  

    tabsetPanel(
      tabPanel("Plot", 
               
               fluidRow(
                  column(width = 3,
                         pickerInput(
                           inputId = "pickSpecies",
                           label = "Select species",
                           choices = c("Red snapper" = "RedSnapper",
                                       "Greater amberjack" = "GreaterAmberjack",
                                       "Gag" = "Gag"
                                       ) #choices
                                  ), #picker input
                         pickerInput(
                           inputId = "pickSector",
                           label = "Select sector",
                           choices = c("Recreational" = "Recreational",
                                       "Commercial" = "Commercial"
                                    ) #choices
                                ), #picker input
                         
                         #### this will need be fixed.  Should be moved to server and populated based on unique from Sector reactive
                         uiOutput("pickGear"),
                         
                         
                         sliderInput("pickYear", "Select Years:", 
                                     sep="",min = 1981, max = 2016,
                                     value = c(2000,2016)),
                         pickerInput(
                           inputId = "pickDiscard",
                           label = "Select discard type",
                           choices = c("Numbers Discarded" = "NumberDiscarded",
                                       "Pounds of Discards" = "LbsDiscarded",
                                       "Pounds of Dead Discards" = "LbsDeadDiscarded"
                           ) #choices
                         ), #picker input
                         textOutput("text1")
                       
                         ),
                  column(width = 9,
               #plotOutput("plot"),
               highchartOutput("discardPlotHC"),
              
               box(width=12,solidHeader = TRUE, status = "primary",
              title="Summary of discards",
              tableOutput("table1"),
               infoBox(10 * 2, "Discard mortality rate", icon = icon("credit-card")),
               valueBox(10 * 2, "Average size of discards", icon = icon("credit-card")),
               valueBox(10 * 2, "Percent annual change", icon = icon("credit-card"))
               )
               #plotOutput("plot2")
               )))#,
               
#############################################################        
      # tabPanel("Summary",fluidRow(
      #   column(width = 3,
      #          pickerInput(
      #            inputId = "pickSpecies",
      #            label = "Select species2",
      #            
      #            choices = c("Red snapper",
      #                        "Greater amberjack",
      #                        
      #                        "Gag"))
      #          
      #   ),
      #   column(width = 9, "summary"))),
#############################################################             
      
      
  
# tabPanel("Summary3",fluidRow(
#   column(width = 3,
#          pickerInput(
#            inputId = "pickSpecies",
#            label = "Select species3",
#            
#            choices = c("RedSnapper",
#                        "Greater amberjack",
#                        
#                        "Gag"))
#          
#   ),
#   column(width = 9, "summary")))#,


        #) #tabPanel
      ) #tabsetPanel
    ) #ddashboardBody
)