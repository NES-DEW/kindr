library(pacman)
p_load(tidyverse, stringi, lubridate)
outer_path <- list.files("C:\\Users\\brendancl\\NHS Scotland\\NES DEW Programme - KIND\\KIND training\\attendance\\", full.names=T)

outer_path <- outer_path[-grep("joined", outer_path)]

read_courses <- function(path) {
#take a path and list the files
# path <- "C:\\Users\\brendancl\\NHS Scotland\\NES DEW Programme - KIND\\KIND training\\attendance\\2023-03-intro"

files <- list.files(path, full.names=T)

read_attendees <- function(fn) {

  # guess encoding
  encoding <- guess_encoding(fn) %>%
    slice_max(confidence) %>%
    pull(encoding)

  raw <- paste(stringi::stri_read_lines(fn, encoding = encoding), sep="")

  start <- grep("2. Participants", raw)

  if(c("3. In-Meeting Activities") %in% raw) {
    end <- grep("3. In-Meeting Activities", raw) - 3
  } else {
    end <- length(raw)
  }

  data <- read_tsv(I(raw), skip=start, n_max = end-start) %>%
        filter(!str_detect(Name, "Name")) %>%
        filter(!str_detect(Name, "Meeting")) %>%
        filter(!str_detect(Name, "Brendan")) %>%
        filter(!is.na(Email)) %>%
        mutate(ID = basename(fn)) %>%
    mutate(across(everything(), as.character))
  }

participants <- map_dfr(files, read_attendees) %>%
  mutate(session = basename(path))

write_csv(participants, paste(dirname(path), "/joined/", basename(path), ".csv", sep=""))
}

walk(outer_path, read_courses)

fz <- list.files("C:\\Users\\brendancl\\NHS Scotland\\NES DEW Programme - KIND\\KIND training\\attendance\\joined", full.names=T)

joined_training_times <- map_dfr(fz, read_csv) %>%
  mutate(time = dmy_hms(`Last leave`) - dmy_hms(`First join`)) %>%
  mutate(type = case_when(str_detect(session, "inter") ~ "intermediate",
                          str_detect(session, "intro") ~ "introductory",
                          TRUE ~ "error"))



#idea for summary function
# tidy <- joined_training_times
# nn <- tidy %>%
#   filter(type == "introductory") %>%
#   count(Name, sort=T) %>%
#   pull(n)
#
# mean(nn) * length(nn)
#
#
# out <- tidy %>%
#   mutate(time = dmy_hms(`Last leave`) - dmy_hms(`First join`)) %>%
#   mutate(type = case_when(str_detect(session, "inter") ~ "intermediate",
#                           str_detect(session, "intro") ~ "introductory",
#                           TRUE ~ "error")) %>%
#   group_by(type) %>%
#   summarise(total_mins = sum(time, na.rm=T)) %>%
#   mutate(hours = round(as.numeric(total_mins / 3600)))
# bleep <- out %>%pull(total_mins / )
# round(as.numeric(bleep[1]) / 3600)

