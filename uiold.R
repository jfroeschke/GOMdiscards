library(shinydashboard)

ui <- function(request){
  
  dashboardPage(skin="red",
  
  dashboardHeader(title="GOM Discards"),
  
  dashboardSidebar(
    
    sidebarMenu(
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
      HTML("<h5 id='title' style='text-align:center;' >Gulf of Mexico <br> Fishery Management Council <br> 2203 North Lois Avenue, Suite 1100 <br>
     Tampa, Florida 33607 USA <br> P: 813-348-1630")
      
    )
    
  ),
  
  dashboardBody(
    #introjsUI(), ## uncomment to add intro help back in
    tabItems(
      
      tabItem(tabName = "menu1",
              ##Note these 3 lines load the modal box
              ## Uncomment to turn on when ready
             includeHTML('pageLoadHTML7.html'),
              includeScript('modalJS.js'),
              includeCSS('modalStyle.css'),
              fluidRow(
                
                column(width = 6,
                       
                       
                       tabBox(id = "tabP1", height=750,
                              side = "left",    
                              tabPanel("Alternative 1", p(Alt1Text)
                                       ),
                              
                        
                              tabPanel("Alternatives  2 - 3", p(Alt2Text),
                                       br(),
                                       p(Alt4Text),
                                       hr(),
                                       div(
                                       pickerInput(
                                         inputId = "Alt2Radio",
                                       #   selected="Total US recreational landings",
                                          label = "Alternative 2: Select years",
                                       #  
                                       #choices = c("Option 2a: 1986 - 2009",
                                       choices = c("Option 2a: 1986 - 2015",
                                       "Option 2b: 1996 - 2015",
                                       "Option 2c: 2006 - 2015", 
                               
                                       "Option 2d: 50% of average historical landings for the years 1986-2015 and 50% of average historical landings for the years 2006-2015"
                                       
                                        ),
                                         options = list(
                                           `actions-box` = TRUE,
                                           size = 10,
                                           `selected-text-format` = "count > 3"
                                         ),
                                         multiple = FALSE
                                       ),align="center"),
                         
                                       div( ## center align button
                                       checkboxGroupInput("ALT3x", "Alternative 3: Exclude selected years", 
                                                          c("Exlude 2006" = 2006,
                                                            "Exlude 2014" = 2014,
                                                            "Exlude 2015" = 2015),
                                                          #selected=2006, 
                                                          inline=TRUE),align="center"),
                                          
                                       hr(),
                                       div(
                                       radioButtons(inputId = "Alt2SectorAllocation",
                                                    inline=TRUE,
                                                     label = "Apply component allocation to state percentages", 
                                                    choices = c("No",
                                                                "Yes")),align="center"),
                                       box(tableOutput("summaryTable"), width=6),
                                       box(tableOutput("summaryTableForHire"), width=6)
                                                                        ),
                                  
                            
                           #end tabpanel 5
                              
                              tabPanel("Alternative 5", p(Alt6Text),
                                       hr(),
                                     
                                      div(HTML("<h4>Explore allocation scenarios using the options below.  It's as easy as 1, 2, 3.</h4>"), align="Center"),
                                       #bookmarkButton(label="Save settings"),
                                       fluidRow(
                                         introBox(
column(6, radioGroupButtons(inputId = "Id073", 
                             label = "1: Select recreational component:", choices = c("Total", 
                                                          "Private", "For-hire"), individual = TRUE, 
                             checkIcon = list(yes = tags$i(class = "fa fa-circle", 
                                                           style = "color: steelblue"), 
                                              no = tags$i(class = "fa fa-circle-o", 
                                                          style = "color: steelblue")))), 
data.step = 1,
data.intro = "Select which sector you are interested in"),
introBox(
column(6, pickerInput(inputId = "TimeSeriesSelect", 
                      label = "*2: Select time series for trips/landings",
                      choices = list("Select years" = c(#"1986 - 2009",
                                                        "1986 - 2015",
                                                        "2006 - 2015",
                                                        #"2006 - 2009",#"50% 1986 - 2015: 50% 2006 -2015",
                                                        #"50% of the average 1986-2009 and 50% of the average 2006-2009", 
                                                        "50% of the average 1986-2015 and 50% of the average 2006-2015" 
                                                                                                          )))),
data.step = 2,
data.intro = "Select a historical time series for trips/landings"),
column(12, div(HTML("<h4 id='A6title' style='text-align:center;' ><b>3a: Select a weighted value</b>"))
      )
  ),
##############Experimental with action buttons
fluidRow(
  #introBox(
  introBox(
  column(12,
         actionButton("goButton", "5d:  25% biomass, 75% trips"),
         actionButton("goButton2", "5e:  50% biomass, 50% trips"),
         actionButton("goButton3", "5f:  75% biomass, 25% trips")
        
  ),
  data.step = 3,
  data.intro = "3)	3a) Select a pre-defined weighting scheme (these are listed options in Alternative 5. OR 3b) Chose explore other weighting schemes (values in these three boxes must total 100)")
),

#hr(),
fluidRow(
    column(2),
    #introBox(
    column(8,
           div(HTML("<h4 id='A6Inst' style='text-align:center;' > <b> 3b: Or define your own weighting combinations</b></h4>"))),
    # data.step = 4,
    # data.intro = "Define weights for biomass, landings, or trips to calculate allocations.  Any Variable can be weighted from 0 to 100 percent but the sum all the variables cannot exceed 100 percent."),
    
    column(2)),
           
                                       
                                       fluidRow(
                                         column(2),
                                         column(2,  inline_numericInput(numericInput("a1", label = "Biomass", value = 25, min=0, max=100, step=1))),
                                         bsTooltip("a1", "Data source: Mandy Karnauskas, John F. Walter III, Matthew D. Campbell, Adam G. Pollack, J. Marcus Drymon & Sean Powers. 2017. Red Snapper Distribution on Natural Habitats and Artificial Structures in the Northern Gulf of Mexico.Marine and Coastal Fisheries Vol. 9 , Iss. 1,2017",  
                                                   "right", options = list(container = "body")),
                                         column(2, inline_numericInput(numericInput("b1", label = "Trips", value = 75, min=0, max=100, step=1))),
                                         column(2, inline_numericInput(numericInput("c1", label = "**Landings", value = 0, min=0, max=100, step=1))),
                          
                                         column(2, 
                                                inlineCSS("#check { border: 3px solid #00c0ef;;border-style: dashed;"),
                                                tableOutput("check")),
                                         column(2)
                                       
                                         ###
),
                                    
                                       fluidRow(
                                         introBox(
                                         column(12,align="center",tableOutput("dfToolTable")),
                                         inlineCSS("#x2 { border: 3px solid #f39c12;border-style: dashed;"),
                                        
                                        data.step = 4,
                                       data.intro = "Breakdown of biomass, trips and total 
                                       landings for each state based on selected component, 
                                       time series, and weighted values and the resulting total allocation"),
                                       introBox(
                                         column(12,align="center", tableOutput("x2")),
                                         bsAlert("alert"),
                                         data.step = 5,
                                         data.intro = "Percent allocations based on user defined settings"),
                                       introBox(
                                         column(12,align="center",br(),
                                                
                                                actionButton("report", "Add to report")),
                                                data.step = 5,
                                                data.intro = "Report"),
                                         bsTooltip("report", "Click this button to save the selection. You can save additional and compare using the tables on right. Once completed you can export a report of results using the save summary report button.",  
                                                   "right", options = list(container = "body")),
                                                
                                         #bookmarkButton(label="Save settings")),
                                         column(12, HTML("<br>*2010 data were excluded from all times series considered here.<br><br>**An option to consider landings as a weighting factor was added for covenience."))
                                       
                                       )
                                        ),
                              
                              width = NULL)
                       
                
                      ),
                
  ##############################################################################
                column(width = 6,
                       
                       tabBox(id = "tabP2", height=600,
                              side = "left",    
                              tabPanel("Alternative 1", p(""),
                                       fluidRow(column(12,
                                                      imageOutput("rsImage")
                                      #div(img(src="IMG_3627_RS.JPG"), style="text-align: center;width='5%';")
                                       #div(id='pic',img(src="IMG_3627_RS.JPG"))))),
                                       #div(HTML('<img src="www/IMG_3627_RS.JPG" alt="" width="50%" height="30%" />')
                                       ))),
                              tabPanel("Alternatives  2 - 3", p(""),
                                       highchartOutput("landingsChart"),
                                       highchartOutput("landingsChartForHire")),
                              # tabPanel("Alternative 3", p(" "),
                              #          highchartOutput("landingsChartAlt3"),
                              #          highchartOutput("landingsChartForHireAlt3")), ##UD
                              # tabPanel("Alternative 4", p(" "),
                              #          highchartOutput("landingsChartAlt4"),
                              #          highchartOutput("landingsChartAlt4ForHire")),
                              #          
                                      
                              tabPanel("Alternative 4", p(""),
                                       highchartOutput("topNlandingsOut"),
                                       highchartOutput("topNlandingsOutForHire")),
                              tabPanel("Alternative 5", 
# p("Interactive map of red snapper biomass in the Gulf of Mexico.
#                                                           Note, this may take a moment to load, please be patient."),
introBox(                                       
highchartOutput("allocationBarChart"),
data.step = 6,
data.intro = "Interactive chart summarizing allocations based on used defined choices.  The selected options are noted at the top of the chart."),
                                       hr(),
div(HTML("<h4>Selected options for comparison</h4>"),align="Center"),
introBox( 
                                       tableOutput("report"),
data.step = 7,
data.intro = "Step 9"),

                                       #leafletOutput('map',height=600),
introBox( 
                                           tableOutput("xtest2"),
data.step = 8,
data.intro = "Step 10"),

                                       div(radioButtons('format', 'Document format', c('PDF', 'HTML', 'Word'),
                                                        inline = TRUE),
                                           introBox(
                                           downloadButton('downloadReport', label="Save summary report"),
                                           data.step = 9,
                                           data.intro = "Save and export comparison table of selcted options"),
                                           align="Center"),
                                           
bsTooltip("downloadReport", "Click this button to save the select options as a summary report.",  
          "right", options = list(container = "body"))

                                       #hr(),
                                       #plotOutput("ggplotOut"),
                                      
#                                        p("Data source: Mandy Karnauskas, John F. Walter III, Matthew D. Campbell, Adam G. Pollack, J. Marcus Drymon & Sean Powers.
# 2017. Red Snapper Distribution on Natural Habitats and Artificial Structures in the Northern Gulf of Mexico.Marine and Coastal Fisheries Vol. 9 , Iss. 1,2017")
                                        ),
                              width = NULL
                       ) 
                       
                )
                
              )
              
      ),
      
      tabItem(tabName = "menu2",
              
              fluidRow(
                
                column(width = 4,
                       
                       valueBox(253, 
                                "Test", 
                             
                                width = NULL)
                       
                )
                
              )
              
      )
      
    )
    
  )
  
)
}