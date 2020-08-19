library(shiny)
library(leaflet)
library(ggplot2)
# library(plotly)#ggplotly
library(tidyverse)
library(kableExtra)
library(shinythemes)
library(here)
library(janitor)
library(raster)
library(sf)
library(tmap)
library(skimr)
library(leaflet)
library(shinyWidgets)
library(shinydashboard)

# read data-------------
landfill_raw <- read_csv(here("data", "Landfills.csv"))

landfill_clean <- landfill_raw %>% 
  clean_names() %>% 
  dplyr::select(-ghgrp_id,-landfill_id, -state, -landfill_alias,-gas_collection_system_comments) %>% 
  drop_na(latitude, longitude) 

landfill_clean$county = paste(landfill_clean$county, "County", sep = " ")

# convert the landfill location into sf data (shapefile)
landfill_sf <- st_as_sf(landfill_clean, 
                        coords = c("longitude","latitude"), 
                        crs = 4326) %>% 
  dplyr::select(facility_name, county)
  

# read in RMP facilities data
rmp <- read_csv(here("data", "CA RMP Facilities.csv"))

rmp_clean <- rmp %>% 
  clean_names() %>% 
  dplyr::select(-state)

# convert RMP location into sf data
rmp_sf <- st_as_sf(rmp_clean, 
                   coords = c("longitude","latitude"), 
                   crs = 4326) %>% 
  dplyr::select(facility_name, county)


# CA counties boundaries data -----
county <- read_sf(dsn = here("data", "CA_Counties"), 
                         layer = "CA_Counties_TIGER2016") %>% 
  clean_names()

# create a pure version of county name and geometry (the boundary shapefile)
county_geo <- county %>% 
  dplyr::select(namelsad) %>% 
  dplyr::rename(county = namelsad) %>% 
  arrange(county) %>% 
  st_transform(crs = 4326)

# plot(county_geo)
