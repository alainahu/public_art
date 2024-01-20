#### Preamble ####
# Purpose: Downloads and saves the data from Open Data Toronto
# Author: Alaina Hu
# Date: 19 January 2024 
# Contact: alaina.hu@utoronto.ca 
# License: MIT
# Pre-requisites: Access Open Data Toronto and know where to find Public Art Data



#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)
library(readxl)
# [...UPDATE THIS...]

#### Download data ####
#Main public art data set
raw_art_data <- 
  read_csv(
    file = 
      "https://ckan0.cf.opendata.inter.prod-toronto.ca/dataset/bfdc6aa8-7ea6-4225-a3f7-e13d1d2b4018/resource/2cb2c65a-1565-4382-8fe3-3a235aec7655/download/Public%20Art%20-%204326.csv"
    ,
    show_col_types = FALSE
  )

#Ward data for the 25 wards
#Reading an excel file since Open Data only provides .xlsx and not .csv
url <- "https://ckan0.cf.opendata.inter.prod-toronto.ca/dataset/6678e1a6-d25f-4dff-b2b7-aa8f042bc2eb/resource/16a31e1d-b4d9-4cf0-b5b3-2e3937cb4121/download/2023-WardProfiles-2011-2021-CensusData.xlsx"
local_file <- tempfile(fileext = ".xlsx")
download.file(url, local_file, mode = "wb")
raw_ward_data <- read_excel(local_file)

#### Save data ####

write_csv(raw_art_data, "inputs/data/unedited_data.csv") 

write_excel_csv(raw_ward_data,"inputs/data/unedited_warddata.csv" )
         
