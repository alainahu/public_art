#### Preamble ####
# Purpose: Cleans the raw public art and ward data provided by Open Data Toronto
# Author: Alaina Hu
# Date: 20 January 2024
# Contact: alaina.hu@utoronto.ca 
# License: MIT
# Pre-requisites: Have the raw art data and raw ward data


#### Workspace setup ####
library(tidyverse)

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
# cleaned_data <-
#   raw_data |>
#   janitor::clean_names() |>
#   select(wing_width_mm, wing_length_mm, flying_time_sec_first_timer) |>
#   filter(wing_width_mm != "caw") |>
#   mutate(
#     flying_time_sec_first_timer = if_else(flying_time_sec_first_timer == "1,35",
#                                    "1.35",
#                                    flying_time_sec_first_timer)
#   ) |>
#   mutate(wing_width_mm = if_else(wing_width_mm == "490",
#                                  "49",
#                                  wing_width_mm)) |>
#   mutate(wing_width_mm = if_else(wing_width_mm == "6",
#                                  "60",
#                                  wing_width_mm)) |>
#   mutate(
#     wing_width_mm = as.numeric(wing_width_mm),
#     wing_length_mm = as.numeric(wing_length_mm),
#     flying_time_sec_first_timer = as.numeric(flying_time_sec_first_timer)
#   ) |>
#   rename(flying_time = flying_time_sec_first_timer,
#          width = wing_width_mm,
#          length = wing_length_mm
#          ) |> 
#   tidyr::drop_na()

#### Save data ####
write_csv(cleaned_data, "outputs/data/analysis_data.csv")
