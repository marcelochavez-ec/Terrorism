dashboardPage(
  skin = "purple",
  
  # Header ------------------------------------------------------------------
  
  dashboardHeader(
    title = "Terrorism"
  ),
  
  # Sidebar -----------------------------------------------------------------
  
  dashboardSidebar(
    
    # Change App style
    
    tags$head(
      
      # Sidebar style
      
      tags$style(HTML('section.sidebar .shiny-input-container {padding: 0px 15px 0px 15px;}')),
      
      tags$style(HTML('.content-wrapper, .right-side {background-color: #222D32;}')),
      
      # Infobox style
      
      tags$style(HTML('.small-box {min-height: 30px; border-radius: 5px; margin-bottom: 10px;}
                      .glyphicon {font-size: 50px;}
                      .icon-large {font-size: 50px !important;}
                      .small-box h3 {font-size: 24px;}
                      .small-box p {font-size: 14px; font-weight: 700;}
                      .small-box .inner {padding-top: 10px; padding-bottom: 5px;}')),
      
      # Leaflet Legend Circular style
      
      tags$style(type = "text/css", "html, body {width:100%;height:100%}",
                 ".leaflet .legend i{
                 border-radius: 50%;
                 width: 10px;
                 height: 10px;
                 margin-top: 4px;
                 }
                 "),
      
      # Table lines color
      
      tags$style(HTML("td  {border-top: 0px solid !important; 
                      font-weight: bold;}")),
      
      # Perpetrator Filter style
      
      tags$style(HTML("
                      .item[data-value=\"Al-Qaeda\"] {
                      background: rgba(0, 255, 255, 0.5) !important;
                      color: #2B2B2B !important;
                      }
                      .option[data-value=\"Al-Qaeda\"] {
                      background: rgba(0, 255, 255, 0.5) !important;
                      color: #2B2B2B !important;
                      }
                      .item[data-value=\"Al-Shabaab\"] {
                      background: rgba(0, 255, 0, 0.5) !important;
                      color: #2B2B2B !important;
                      }
                      .option[data-value=\"Al-Shabaab\"] {
                      background: rgba(0, 255, 0, 0.5) !important;
                      color: #2B2B2B !important;
                      }
                      .item[data-value=\"Boko Haram\"] {
                      background: rgba(255, 255, 0, 0.5) !important;
                      color: #2B2B2B !important;
                      }
                      .option[data-value=\"Boko Haram\"] {
                      background: rgba(255, 255, 0, 0.5) !important;
                      color: #2B2B2B !important;
                      }
                      .item[data-value=\"Islamic State\"] {
                      background: rgba(255, 128, 0, 0.5) !important;
                      color: #2B2B2B !important;
                      }
                      .option[data-value=\"Islamic State\"] {
                      background: rgba(255, 128, 0, 0.5) !important;
                      color: #2B2B2B !important;
                      }
                      .item[data-value=\"Lone Wolf\"] {
                      background: rgba(255, 0, 255, 0.5) !important;
                      color: #2B2B2B !important;
                      }
                      .option[data-value=\"Lone Wolf\"] {
                      background: rgba(255, 0, 255, 0.5) !important;
                      color: #2B2B2B !important;
                      }
                      .item[data-value=\"PKK\"] {
                      background: rgba(0, 0, 255, 0.5) !important;
                      color: #2B2B2B !important;
                      }
                      .option[data-value=\"PKK\"] {
                      background: rgba(0, 0, 255, 0.5) !important;
                      color: #2B2B2B !important;
                      }
                      .item[data-value=\"Taliban\"] {
                      background: rgba(255, 0, 0, 0.5) !important;
                      color: #2B2B2B !important;
                      }
                      .option[data-value=\"Taliban\"] {
                      background: rgba(255, 0, 0, 0.5) !important;
                      color: #2B2B2B !important;
                      }
                      .item[data-value=\"Unknown/Others\"] {
                      background: rgba(242,242,242, 0.5) !important;
                      color: #2B2B2B !important;
                      }
                      .option[data-value=\"Unknown/Others\"] {
                      background: rgba(242,242,242, 0.5) !important;
                      color: #2B2B2B !important;
                      }
                      "))
    ),
    
    # Menu
    sidebarMenu(id = "tabs",
      menuItem("Map", tabName = "menuMap", icon = icon("map-o")),
      menuItem("Globe", tabName = "menuGlobe", icon = icon("globe")),
      #menuItem("Data", tabName = "menuData", icon = icon("database")),
      menuItem("Information", tabName = "menuInfo", icon = icon("info-circle"))
    ),
    
    hr(style = "margin: 15px;"),
    
    # Date Filter
    dateRangeInput("filterDate", label = "Date",
                   start  = max(df$Date) - 30, end = max(df$Date),
                   min  = min(df$Date), max = max(df$Date)
    ),
    
    # Perpetrator Filter
     
    selectInput("filterPerpetrator", label = "Perpetrator Groups",
                multiple = TRUE, selectize = TRUE,
                choices = c("All Perpetrator Groups" = '', as.character(sort(unique(df$Perpetrator))))),
    
    # Size Filter (Dead vs Injured)
    
    selectInput("filterSize", label = "Fact",
                multiple = FALSE, selectize = TRUE, selected = "Dead",
                choices = c("Dead","Injured","Dead + Injured" = "DeadInjured")),
    
    
    hr(style = "margin: 15px;"),
    
    valueBoxOutput("InjuredBox", width = 12),
    valueBoxOutput("DeadBox", width = 12),
    valueBoxOutput("IncidentsBox", width = 12),
    
    hr(style = "margin: 15px;"),
    
    actionButton("myTakeTour", "Take Tour", icon = icon("question-circle"), style = action_btn_style)
    
  ),
  
  # Body --------------------------------------------------------------------
  
  dashboardBody(
    
    includeCSS("www/myStyles.css"),
    
    tabItems(
      tabItem(tabName = "menuMap",
        #fluidPage(
          box(width = 12, status = "warning", title = "Global Terrorist Attacks - Map",
              solidHeader = TRUE,
              leafletOutput("mymap", height = 500)
          ),
          box(width = 12, status = "warning",
              solidHeader = TRUE,
              timevisOutput("myTimeline")
          )
        #)        
      ),
      
      tabItem(tabName = "menuGlobe",
        #fluidPage(
          box(width = 12, status = "warning", title = "Global Terrorist Attacks - Globe",
              height = 1030,
              solidHeader = TRUE,
              style = "font-size: 120%;",
              style = "color: #444",

              globeOutput("myGlobe"),
              h4(paste0("Global terrorist attacks between ", min(df$Date)," and ", max(df$Date), " are represented as bars rising from a 3D globe. There are ", prettyNum(nrow(df), big.mark = ".", decimal.mark = ",") ," such incidents with in total ", prettyNum(sum(df$Dead), big.mark = ".", decimal.mark = ","), " fatalities and ", prettyNum(sum(df$Injured), big.mark = ".", decimal.mark = ","), " injured. The colour and length of the bars represent the number of fatalities/injured in the attack."), style = "text-align: justify")
              
          )
        #)        
      ),
      
      tabItem(tabName = "menuInfo",
        box(title = "About this application", 
            width = 12, status = "warning", solidHeader = TRUE, collapsible = TRUE, collapsed = FALSE,
            p("Since the rise and fall of the Islamic State of Iraq and the Levant (ISIS), almost no day passes without another terrorist attack in some part of the world. Though, in western media only a small number of attacks are mentioned. Reports are limited to attacks where countrymen have lost their lives or which were particularly devastating. In the Middle East and parts of Africa however, terror is part of everyday life.", style = "text-align:justify"),
            p("To highlight these cruel terrorist attacks I plotted all incidents from", min(df$Year), "until today on an interactive leaflet map based on crowdsourced wikipedia data. Each of the", prettyNum(nrow(df), big.mark = ".", decimal.mark = ",") ,"incidents is plotted as an individual circle. The size of the circle correlates to the number of victims and the colour represents the terror organization. I've focused on groups that are currently the most active. The remaining ones were grouped together as 'others'.", style = "text-align:justify"),
            p("Additional information for every incident can be invoked via a popup by clicking on one of the circles in the map or an item on the timeline. As with any crowdsourced data, it may contain spurious or objectionable data, which I do not take responsibility for. The same data is used to create a fancy webGL globe. This feature is still work in progress and will be changed in future versions.", style = "text-align:justify"),
            p("Only by looking at all the data at once, you will realize the full extent of global terrorism.", style = "text-align:justify")
        ),
        box(title = "Frequently asked questions", 
            width = 12, status = "warning", solidHeader = TRUE, collapsible = TRUE, collapsed = FALSE,
        source("faq.R", local = TRUE)[[1]]
        ),
        box(title = "Contact information", 
            width = 12, status = "warning", solidHeader = TRUE, collapsible = FALSE, collapsed = FALSE,
            HTML('
             <div style="clear: left;"><img src="https://dominikkoch.github.io/img/avatar.jpg"
             alt="Avatar" height="125" width="125" style="float: left; margin-right:5px" /></div>
             <p>Dominik Koch<br/>
             Statistician | Data Scientist <br/>
             <a href="https://github.com/DominikKoch" target="_blank">Github.io</a> |
             <a href="https://dominikkoch.github.io/" target="_blank">Blog</a> |
             <a href="https://linkedin.com/in/dominik-koch-341a39100" target="_blank">Linkedin</a> |
             <a href="https://www.xing.com/profile/Dominik_Koch20?sc_o=mxb_p" target="_blank">Xing</a> <br/>
             <a href="https://dominikkoch.github.io/myprojects/", target="_blank">Shiny Snippets Gallery</a>
             </p>'
            ),
            p("For questions or feedback about this application, please email data42science@gmail.com")
        )
        
      ) # End tabItem menuInfo
    ) # End tabItems
  ) # End dashboardBody 
) # End dashboardPage
