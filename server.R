# Define server logic required to plot various variables against mpg
shinyServer <- function(input, output, session) {
  
  
  
## Filter the landfill facilities that are in the same county with users'
  landfill_county <- reactive({
    landfill_sf %>% 
      filter(county == input$county)
  })
  
 
## Filter RMP facilities that that are in the same county with users'
  rmp_county <- reactive({
    rmp_sf %>% 
      filter(county == input$county)
  })
  
## Filter the county boudaries
  county_user <- reactive({
    county_geo %>% 
      filter(county == input$county)
  })
  
  
  ## create the leaflet map of the selected park

  output$map <- renderLeaflet({
    leaflet() %>%
      addProviderTiles(providers$Thunderforest.Outdoors) %>% 
      addTiles(
        urlTemplate = "https://tile.thunderforest.com/outdoors/{z}/{x}/{y}.png?apikey=faa73f98b6a445298967f05e7a8908c4",
        attribution = "&copy; <a href=\"http://www.thunderforest.com/\">Thunderforest</a>, {attribution.OpenStreetMap}",
        options = tileOptions(variant='outdoors', apikey = 'faa73f98b6a445298967f05e7a8908c4')
      ) %>% 
      addPolygons(data = county_user(),
                  fill = FALSE, 
                  label = county_user()$county,
                  color = "#444444") 
  })
  
  
  # After built up the animals() dataset, 
  # update the picker in next widget and the map with animal clusters
  observeEvent(landfill_county(),{
    # build up choices based on previous selection
    
    
    leafletProxy("map") %>%
      clearMarkers() %>% 
      clearControls() %>%
      addCircleMarkers(data = landfill_county(),
                       color = "grey40",
                       opacity = 1,
                       fillOpacity = 0.7,
                       weight = 1,
                       radius = 10,
                       label = landfill_county()$facility_name) %>%
      addMarkers(data = rmp_county(),
                        label = ~facility_name)
    
    
  }) 
  

  
  
   
  
}