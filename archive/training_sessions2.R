#' #' Find current training for a particular platform
#' #'
#' #' @param tr_type Training type
#' #' @param start_date A ymd-formatted date
#' #' @param end_date A ymd-formatted date
#' #'
#' #' @return Tibble with Session (with link), Date, Level
#' #' @export
#' #'
#' #' @examples
#' #' training_sessions("R")
#' #' training_sessions("Excel", "01-07-2024")
#' training_sessions <- function(tr_type = "all", start_date = "today", end_date = lubridate::dmy("01-12-2025")){
#'   raw <- readxl::read_excel("C:\\Users\\brendancl\\NHS Scotland\\NES DEW Programme - KIND\\KIND training\\KIND training schedule.xlsx", sheet = "KIND one-off training schedule")
#'
#'   if (tr_type != "all") {
#'     raw <- raw |>
#'       dplyr::filter(`Platform / area` == tr_type)
#'   }
#'
#'   if (start_date == "today") {
#'     raw <- raw |>
#'       dplyr::filter(start > lubridate::today() + lubridate::days(1)) |>
#'       dplyr::filter(start < end_date)
#'   } else {
#'     raw <- raw |>
#'       dplyr::filter(start > lubridate::ymd(start_date)) |>
#'       dplyr::filter(start < lubridate::ymd(end_date))
#'   }
#'
#'   raw |>
#'     dplyr::rowwise() |>
#'     dplyr::mutate(linky = paste0("[", `session title`, "](", url, ")")) |>
#'     dplyr::mutate(Level = factor(Level, levels = c("pre-beginner", "beginner", "intermediate", "advanced", "managerial"))) |>
#'     dplyr::mutate(desc2 = dplyr::case_when(
#'       stringr::str_detect(`further desc`, "pre-beginner") ~ "🥬: a **pre-beginner-level** session aimed at those with no prior experience",
#'       stringr::str_detect(`further desc`, "beginner") ~ "[🌶]{style='color:red;'}: a **beginner-level** session aimed at those new to the topic",
#'       stringr::str_detect(`further desc`, "inter") ~ "[🌶🌶]{style='color:red;'}: an **intermediate-level** session aimed at those with prior experience of the topic",
#'       stringr::str_detect(`further desc`, "advanced") ~ "[🌶🌶🌶]{style='color:red;'}: an **advanced-level** session aimed at those with plenty of experience of the topic",
#'       stringr::str_detect(`further desc`, "manag") ~ "💼: a **non-technical** session aimed at service leads that gives an overview of the topic")) |>
#'
#'     dplyr::mutate(friendly_date = paste0(
#'       format(start, "%H:%M"),
#'       "-",
#'       nice_date(end))) |>
#'
#'     dplyr::select(Session = linky, Date = friendly_date, Level2 = Level, Level = desc2, start) |>
#'     dplyr::arrange(Level2, start) |>
#'     dplyr::select(!c(Level2, start)) |>
#'     dplyr::ungroup()
#'
#' }
