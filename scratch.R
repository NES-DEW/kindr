# library(tidyverse)
# data<-readr::read_csv("data/ml.csv") %>%
#   dplyr::select(Email, Organisation)
#
# orgz <- data %>%
#   count(Organisation, sort=T)

# boards <- tibble(name = c("NHS Ayrshire & Arran", "NHS Borders", "NHS Dumfries & Galloway", "NHS Fife", "NHS Forth Valley", "NHS Grampian", "NHS Greater Glasgow and Clyde", "NHS Highland", "NHS Lanarkshire", "NHS Lothian", "NHS Orkney", "NHS Shetland", "NHS Tayside", "NHS Western Isles"), type="Regional") %>%
#   bind_rows(tibble (name = c("Healthcare Improvement Scotland", "NHS 24", "NHS Education for Scotland", "NHS Golden Jubilee National Hospital", "NHS National Services Scotland","Public Health Scotland","Scottish Ambulance Service", "The State Hospital"), type="National"))
