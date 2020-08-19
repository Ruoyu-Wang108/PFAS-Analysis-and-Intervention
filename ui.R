shinyUI(
  # ----------Dashborad page-----------------  
  dashboardPage(
    
    # ---------Overall Title---------------
    dashboardHeader(title = "Basic dashboard"),
    # ---------END title-------------- ---- 
    
    dashboardSidebar(
      selectInput("county", label = h4("Please select your county"), 
                  choices = c(unique(county_geo$county)), 
                  selected = 1),
      
      actionButton(inputId = "search", label = "Search")
      
    ),
    
    dashboardBody(
      fluidRow(
        
        column(6, 
               # interactive park map
               leafletOutput("map", width = "100%", height = 500)
        )
        
      )
    
    )

    
    
    
  )
  # -------END Dashborad page-----------------
  
)
# =========END APP======================