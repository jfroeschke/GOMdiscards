ui <- 
 
  
  dashboardPage(
    
                dashboardHeader(title="Discard Dashboard"),
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
                         introBox(
                         pickerInput(
                           inputId = "pickSpecies",
                           label = "Select species",
                           choices = c("Red snapper" = "RedSnapper",
                                       "Greater amberjack" = "GreaterAmberjack",
                                       "Gag" = "Gag"
                                       ) #choices
                                  ),  #picker input
                         data.step = 1,
                         data.intro = "Use this menu to select a species of interest.  This list currently includes data for 3 species of interest 
                         in the Gulf of Mexico, but may be expanded in the future.  Fisheries data are collected in collobaration with state and federal
                         agencies.  NOAA Fisheries compiles and synthesizes these data and is the source of data in this dashboard."
                         ), 
                         
                         introjsUI(),
                        
                        
                         
                         #### this will need be fixed.  Should be moved to server and populated based on unique from Sector reactive
                         introBox(
                         uiOutput("pickSector"),
                         data.step = 2,
                         data.intro = "Select a fishing sector if interest.  Recreational and commercial fisheries have different characteristics 
                         in terms of the number of species caught, depth captured, and percentage of fish that are released versus retained.  The released fish 
                         data are provided by sector to account for these differences."
                          ), 
                         
                         introBox(
                         uiOutput("pickGear"),
                         data.step = 3,
                         data.intro = "Select a fishing gear or region of interest. Different gears target captured fishes differently either because of the length of time the gear is deploy the depths typically fished, or the size of species targeted.  For red snaper the data are separated into two regions in the Gulf of Mexico.  Red snapper are managed as two stocks including a western stock (West of the Mississippi River) and an eastern stock (East of the  Mississippi River).  Based on the characteristics of the stock and the fishing practices in the respective region, the eastern and western stocks are considered separately for red snapper.  The remaining species included in this dashboard are managed as a single stock within the Gulf of Mexico." 
                        
                         
                         ),
                         
                         introBox(
                           uiOutput("pickYear"),
                         # sliderInput("pickYear", "Select Years:",
                         #             sep="",min = 1981, max = 2016,
                         #             value = c(2000,2016)),
                         data.step = 4,
                         data.intro = "This slider allows you to select a reference period of interest.  By default the tool defaults to the full time series of data available.  The length of data varies among species, gears etc."
                         ),
                         introBox(
                         uiOutput("pickDiscard"),
                         data.step = 5,
                         data.intro = "The released fish data are provided in three forms in this dashboard.  The first selection provides an estimate of the total number of released fish for the selected query.  This value inlcudes fish that are released and survive as well as the number individuals that do not survive after release.  Annual catch limits of fish stocks are monitored in the weight of retained fish.  The released fish data are also provided in weight and include both fish that survived after release and those that did not.  Finally, an estimate of dead discards is available.  This is calculated as the product of the weight of released fish and the release mortality rate.  For any particular species or component of the fishery, the release mortality rate may change through time because of regulatory changes, improvements in scientic information, or changes in the way the fishery is prosecuted."
                         ),
                         # pickerInput(
                         #   inputId = "pickDiscard",
                         #   label = "Select discard type",
                         #   choices = c("Numbers Discarded" = "NumberDiscarded",
                         #               "Pounds of Discards" = "LbsDiscarded",
                         #               "Pounds of Dead Discards" = "LbsDeadDiscarded"
                         #   ) #choices
                         # )#, #picker input
                         #textOutput("text1")
                         actionButton("btn",HTML('<h4>How do I use this app?</h4>'), width=200,
                                      style="background-color: #0066ff;border-color: #0066ff; color: #fff;margin: 6px 0px 6px 0px;" )
                       
                         ),
                  column(width = 9,
               #plotOutput("plot"),
               introBox(
               highchartOutput("discardPlotHC"),
               data.step = 6,
               data.intro = "This separately for red snapper.  The remaining species included in this dashboard are managed as a single stock within the Gulf of Mexico."
               ),
              
               box(width=12,solidHeader = TRUE, status = "primary",
              title="Summary of discards for most recent year selected",
              #tableOutput("table1"),
               #infoBox(10 * 2, "Discard mortality rate"),
              introBox(
              valueBoxOutput('valueBox1'),
              data.step = 7,
              data.intro = "This box reports the release mortality rate in the last year of data for the selected query."
              ),
              introBox(
              valueBoxOutput('valueBox2'),
              data.step = 8,
              data.intro = "This box reports the number (or weight) of released fish in the last year of data for the selected query."
              )#,
               
  
              #infoBoxOutput('valueBox3')
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


        ) #tabPanel
      ) #tabsetPanel
    ) #ddashboardBody
#)