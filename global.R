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

# read data-------------
landfill_raw <- read_csv("Landfills.csv")

landfill_clean <- landfill_raw %>% 
  clean_names() %>% 
  dplyr::select(-ghgrp_id,-landfill_id, -state, -landfill_alias,-gas_collection_system_comments)

rmp <- read_csv("CA RMP Facilities.csv")

rmp_clean <- rmp %>% 
  clean_names() %>% 
  dplyr::select(-state)
