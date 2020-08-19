shinyUI(
  # ----------Fluid page-----------------  
  fluidPage(
    
    # ---------Overall Title---------------
    titlePanel("PFAS Around Us"),
    # ---------END title-------------- ---- 
    
    # --------Navigate bar-----------------
    navbarPage(
      
      theme = shinytheme("journal"),
      "PFAS Level in California",
      
      # -----Tab 1---------------------
      tabPanel(
        "Possible Intervention",
        
      
        numericInput("num", label = h3("zip code"), value = 1),
        
        hr(),
        fluidRow(column(3, verbatimTextOutput("value")))  
    
      ),
      # ------END Tab 1----------------
      
      
    )
    
    # ---------END Navbar-------------------
    
    
    
    
  )
  # -------END Fluid page-----------------
  
)
# =========END APP======================