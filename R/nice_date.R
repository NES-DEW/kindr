#' Make a friendly date from date/datetime
#'
#' @param date A date/datetime
#'
#' @return a nice (and standard for KIND) date string in the format "Tue 9th September 2025"
#' @export
#'
#' @examples nice_date(lubridate::today())

nice_date <- function(date){

  if(lubridate::is.Date(date)) {
    paste(lubridate::wday(date, label = T),
          scales::ordinal(lubridate::day(date)),
          lubridate::month(date, label = T, abbr = F),
          lubridate::year(date))
  } else if(lubridate::is.POSIXct(date)) {
    paste(format(date, "%H:%M"),
          lubridate::wday(date, label = T),
          scales::ordinal(lubridate::day(date)),
          lubridate::month(date, label = T, abbr = F),
          lubridate::year(date))
  } else {
    "Dunno what to do with that"
  }


}
