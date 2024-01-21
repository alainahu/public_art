#### Preamble ####
# Purpose: Cleans the raw public art and ward data provided by Open Data Toronto
# Author: Alaina Hu
# Date: 20 January 2024
# Contact: alaina.hu@utoronto.ca 
# License: MIT
# Pre-requisites: Have the raw art data and raw ward data


#### Workspace setup ####
library(tidyverse)
library(knitr)

#### Clean data ####
raw_data_1 <- read_csv("inputs/data/unedited_data.csv")

cleaned_art_data <-
  raw_data_1 |>
  select(
    `_id`,
    WARD,
    WARD_FULLNAME
  )

raw_data_2 <- read_csv("inputs/data/unedited_warddata.csv")
cleaned_ward_data <-
  raw_data_2[c(18, 1285, 1383), ] 
cleaned_ward_data <- as.data.frame(t(cleaned_ward_data)) |>
  slice(-1) |>
  slice(-1) |>
  rename(population = V1, minority_population = V2, 
         income = V3)
cleaned_ward_data$WARD = 1:25
cleaned_ward_data = cleaned_ward_data[c("WARD", setdiff(names(cleaned_ward_data),
                                                        "WARD"))]
count_by_ward <- cleaned_art_data |> group_by(WARD) |> count(WARD)
analysis_data <- left_join(cleaned_ward_data, count_by_ward)  
analysis_data$n <- replace(analysis_data$n, is.na(analysis_data$n), 0)


analysis_data$WARD <- as.character(analysis_data$WARD) 
analysis_data$population <- as.numeric(analysis_data$population)
analysis_data$minority_population <- as.numeric(analysis_data$minority_population)
analysis_data$income <- as.numeric(analysis_data$income)


#### Save data ####
write_csv(analysis_data, "outputs/data/analysis_data.csv")
