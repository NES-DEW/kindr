#' Find current training for a particular platform
#'
#' @param tr_type Training type
#' @param start_date A ymd-formatted date. We add 1 day to the date, so that you don't have to.
#' @param end_date A ymd-formatted date
#' @param session_level Training level required
#' @param hide_area Hide the area column?
#' @param n Number of sessions required
#' @param output_type Output type required: pick from kableExtra, tibble, DT
#'
#' @return Tibble with Session (with link), Date, Level
#' @export
#'
#' @examples
#' training_sessions("R")
#' training_sessions("Excel", "2024-07-01")
#'

training_sessions <- function(tr_type = "all",
                              start_date = "today",
                              end_date = "2026-12-31",
                              session_level = "all",
                              hide_area = FALSE,
                              n = 0,
                              output_type = "kableExtra") {

  material_check <- function(url){
    if(!is.na(url)) paste0("<a href='", url, "'>Session materials</a>")
    else ""

    }

  sesh <- readr::read_csv(
    "https://raw.githubusercontent.com/NES-DEW/KIND-training/main/data/KIND_training_sessions.csv"
  )



  schedule <- readr::read_csv(
    "https://raw.githubusercontent.com/NES-DEW/KIND-training/main/data/training_schedule.csv"
  )
  if (tr_type != "all") {
    poss_sesh <- sesh |>
      dplyr::filter(`Platform / area` %in% tr_type) |>
      dplyr::pull(Title)

    schedule <- schedule |>
      dplyr::filter(`session title` %in% poss_sesh)
  }

  if (start_date == "today") {
    schedule <- schedule |>
      dplyr::filter(start > lubridate::today() + lubridate::days(1)) |>
      dplyr::filter(start < end_date)
  } else {

    start_date <- lubridate::ymd(start_date) + lubridate::days(1)

    schedule <- schedule |>
      dplyr::filter(start > start_date) |>
      dplyr::filter(start < lubridate::ymd(end_date))
  }

  if(n){
    schedule <- schedule |>
      dplyr::arrange(start) |>
      dplyr::slice(1:n)
  }

  output <- schedule |>
    dplyr::left_join(sesh, by = dplyr::join_by(`session title` == Title)) |>
    dplyr::rowwise() |>
    dplyr::mutate(linky = paste0("<a href='", url, "'>", `session title`, "</a>")) |>
    dplyr::mutate(Level = factor(
      Level,
      levels = c(
        "pre-beginner",
        "beginner",
        "intermediate",
        "advanced",
        "managerial"
      )
    )) |>
    dplyr::mutate(desc2 = KINDR::chilli_adder(Level)) |>
    dplyr::mutate(end = start + lubridate::minutes(`Duration (minutes)`)) |>
    dplyr::mutate(friendly_date = paste0(format(start, "%H:%M"), "-", nice_date(end))) |>
    dplyr::mutate(URL = material_check(URL))|>
    dplyr::select(
      `Booking Link` = linky,
      Materials = URL,
      Date = friendly_date,
      Level2 = Level,
      Area = `Platform / area`,
      Level = desc2,
      start
    ) |>
    dplyr::arrange(start, Level2) |>
    dplyr::select(!c(Level2, start)) |>
    dplyr::ungroup()

  if (session_level != "all") {
    output <- output |>
      dplyr::filter(stringr::str_detect(Level, session_level))
  }

  if (hide_area) {
    output <- output |>
      dplyr::select(-Area)
  }

  if(output_type == "kableExtra"){

    output |>
      kableExtra::kbl(escape = FALSE)

  } else if(output_type == "tibble") {
    schedule |>
      dplyr::left_join(sesh, by = dplyr::join_by(`session title` == Title)) |>
      dplyr::mutate(Level2 = KINDR::chilli_adder(Level)) |>
      dplyr::mutate(end = start + lubridate::minutes(`Duration (minutes)`)) |>
      dplyr::mutate(friendly_date = paste0(format(start, "%H:%M"), "-", nice_date(end))) |>
      dplyr::select(title = `session title`, start, end, duration = `Duration (minutes)`, friendly_date, area = `Platform / area`, Level, Level2, Description, Prerequsites, url, URL)
  } else if(output_type == "DT") {

    output |>
      DT::datatable(escape = FALSE, filter = "top")

  } else {
    output
  }


}
