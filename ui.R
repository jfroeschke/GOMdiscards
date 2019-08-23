ui <- 
  
  dashboardPage(
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
    # tabItems(
    #   tabItem(tabName = "menu1",
    #            fluidRow(
    #              column(width = 12,
    #                     tabBox(id = "tabP1", height=750, side="left",
    #  tabPanel("Red snapper", "blah"),
    #            tabPanel("Greater amberjack", "blah2"),
    #                             tabPanel("Gag", "blah3")
    #                         )
    #                    )
    #               )
    #            )
    #        ) 
    ## https://shiny.rstudio.com/reference/shiny/latest/tabPanel.html
    tabsetPanel(
      tabPanel("Plot", 
               fluidRow(
                  column(width = 12,
               plotOutput("plot"),
               plotOutput("plot2")))),
               
               
      tabPanel("Summary", verbatimTextOutput("summary")),
      tabPanel("Table", tableOutput("table"))
    )
    
    
      )
)