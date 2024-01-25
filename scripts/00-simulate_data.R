#### Preamble ####
# Purpose: Simulates the data for the Toronto Public Art statistics
# Author: Alaina Hu 
# Date: 19 January 2024 
# Contact: alaina.hu@utoronto.ca 
# License: MIT
# Pre-requisites: Find Public Art Data from Open Data Toronto
# Any other information needed? NA


#### Workspace setup ####
install.packages("tidyverse")
library(tidyverse)


#### Simulate data ####
# There are currently over 400 public art installations, so we are simulating 401 pieces.
# The City of Toronto has 25 wards.

ward_names <- c("Etobicoke North", "Etobicoke Centre", "Etobicoke-Lakeshore", 
                "Parkdale-High Park","York South-Weston", "York Centre", 
                "Humber River-Black Creek", "Eglinton-Lawrence",
                "Davenport", "Spadina-Fort York", "University-Rosedale",
                "Toronto-St. Paul's", "Toronto Centre", "Toronto-Danforth",
                "Don Valley West", "Don Valley East", "Don Valley North",
                "Willowdale", "Beaches-East York", "Scarborough Southwest",
                "Scarborough Centre", "Scarborough-Agincourt",
                "Scarborough North", "Scarborough-Guildwood",
                "Scarborough-Rouge Park")
#Setting seed to get the same simulated results
set.seed(106)
simulated_art_data <- tibble(artwork_id = 1:401,
                              ward_number = sample(1:25, size = 401, replace = TRUE),
                             ward_name = sample(ward_names, size = 401, replace = TRUE))
                              
#### Tests ####
#Making sure that the ward names are one of the 25 Toronto Ward names
simulated_art_data$ward_name |>
  unique() %in% ward_names
#Checking that all 25 wards are simulated
simulated_art_data$ward_number |>
  unique() |>
  length() == 25
#Testing the simulated art work ID
simulated_art_data$artwork_id |>
  min() == 1 
simulated_art_data$artwork_id |>
  max() >= 400 #Checking that there are over 400 installations


