ui <- 
  
  dashboardPage(
                dashboardHeader(title=" "),
                dashboardSidebar(disable=TRUE,
                  
                  sidebarMenu(disable = TRUE,
                    tags$head(includeCSS("Style.css")),
                    # tags$head(includeCSS("Style2.css")),
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
      tabPanel("Dashboard", 
               
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
                         )#, #picker input
                         #textOutput("text1")
                       
                         ),
                  column(width = 9,
               #plotOutput("plot"),
               highchartOutput("discardPlotHC"),
              
               box(width=12,solidHeader = TRUE, status = "primary",
              title="Summary of discards for most recent year selected",
              #tableOutput("table1"),
               #infoBox(10 * 2, "Discard mortality rate"),
              valueBoxOutput('valueBox1'),
              valueBoxOutput('valueBox2'),
              valueBoxOutput('valueBox3')
               )
               #plotOutput("plot2")
               ))),
               
#############################################################        
      tabPanel("About the data",fluidRow(
        column(width = 2

        ),
        column(width = 8, 
               box(width=12,
                 #### About the data
                 
                 HTML(
                 '<div id="about-the-data" class="section level4">
<h4>About the data</h4>
<p>The specific approach used to estimate the number of total discards differs from fleet to fleet; however, generally speaking the process involves using observed data to calculate a rate of discard (number of fish discarded per unit fishing effort) and then multiplying that rate by an estimate of total effort to obtain an estimate of total discards.</p>
<p>For a variety of reasons, weights of discarded fish are not often measured. Consequently, estimates of discard weight, like the ones provided here, must be derived using additional sources of information.</p>
<p>The weight of discarded red snapper (Discards (lbs.) on Table 2-3) were calculated by multiplying discards (numbers) by a year and fleet-specific estimate of average weight per discard obtained from the most recent stock assessment model. Dead discards, in both number and weight were obtained by multiplying discards (numbers) and discards (lbs.) by the fleet and year specific discard mortality rates shown in Table 1.</p>
</div>
<div id="assumptions" class="section level4">
<h4>Assumptions</h4>
<ul>
<li>Recreational estimates were provided in MRIP units with charter and APAIS calibrations. The FES calibration was not applied.</li>
<li>Discards in pounds were computed using the average weight, by fishing mode and year, computed within the stock assessment.</li>
<li>Dead discards in numbers and weight were estimated by applying the release mortality used for that assessment.</li>
</ul>
</div>')
                 
                 )
               ),
        column(width = 2)
        )),
#############################################################             
      
      
  
tabPanel("Gulf of Mexico discard data",fluidRow(
  column(width = 1),
  column(width=10,DTOutput('tbl')),
  column(width=1)
         )
      )
#))#,


        #) #tabPanel
      ) #tabsetPanel
    ) #ddashboardBody
)