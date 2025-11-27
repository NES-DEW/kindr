
#' Apply an offset to fix the timings of subtitles in Teams recordings
#' #'
#' @param input .vtt transcript from Teams
#' @param offset an offset in seconds. Using 9 here makes subtitles appear 9 seconds earlier.
#'
#' @returns .vtt transcript
#' @export
#'
#' @examples
#'
#'source_path = "C:\\Users\\BrendanCl\\2. Open Source in NHS Lothian.vtt"
#'
#' readr::read_lines(source_path) |>
#'  stringr::str_replace_all("\\d\\d:\\d\\d:\\d\\d.\\d\\d\\d", \(x) teams_transcript_offset(input = x, offset = 2)) |>
#'  readr::write_lines(paste0(tools::file_path_sans_ext(source_path), "_fixed.vtt"))

teams_transcript_offset <- function(input, offset = 9){
  (lubridate::ymd_hms(paste0("2025-11-24T", input)) - lubridate::seconds(offset)) |> # make a temporarary datetime and do the offset
    as.character() |> # then date to text
    stringr::str_extract("\\d\\d:\\d\\d:\\d\\d.\\d\\d\\d") # then string extract by patter
}

