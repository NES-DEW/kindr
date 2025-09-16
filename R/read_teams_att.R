#' Easily read Microsoft Teams attendance files
#'
#' `read_teams_att()` reads Microsoft Teams attendance files, guesses the encoding, and produces a tidy tibble of attendees. Teams attendance files are painful to read in R. First, they use UTF16LE encoding, which causes problems with standard methods. Next, the structure of the .csv file itself is repetitious, requiring some careful tidying. Finally, they are tab-demarcated, but saved as .csv, causing difficulties for other methods that infer separators.
#'
#' @param fn A filename of a Teams attendance .csv, or path of a folder containing several .csvs
#' @param organiser_name The name of the organiser, which can optionally be removed from the data
#'
#' @return A tibble
#' @export
#'
#' @examples df <- read_teams_att("data/jan_2023_meeting.csv")
read_teams_att <- function(fn, organiser_name="Brendan Clarke") {

    encoding <- readr::guess_encoding(fn) |>
      dplyr::slice_max(confidence) |>
      dplyr::pull(encoding)

    raw <- paste(stringi::stri_read_lines(fn, encoding = encoding), sep="")

    start <- grep("2. Participants", raw)

    if(c("3. In-Meeting Activities") %in% raw) {
      end <- grep("3. In-Meeting Activities", raw) - 3
    } else {
      end <- length(raw)
    }

    date_cols <- c("First join", "Last leave")
    # comment
    readr::read_tsv(I(raw), skip=start, n_max = end-start) |>
      dplyr::filter(!stringr::str_detect(Name, organiser_name)) |>
      dplyr::filter(!is.na(Email)) |>
      dplyr::mutate(ID = basename(fn)) |>
      dplyr::rename_with(stringr::str_replace, pattern = "(?i)First Join", replacement = "First join") |>
      dplyr::rename_with(stringr::str_replace, pattern = "(?i)last leave", replacement = "Last leave") |>
      dplyr::mutate(dplyr::across(.cols = any_of(date_cols), .fns = ~lubridate::parse_date_time(., c("dmy HMS", "mdy HMS")))) |>
      dplyr::select(!tidyselect::any_of("In-Meeting Duration")) |>
      dplyr::mutate(`In-meeting duration` = `Last leave` - `First join`)


}

