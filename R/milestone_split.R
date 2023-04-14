#' Given a filename, this function splits the script into sequentially-numbered milestone files. The aim is to allow all the code for a session to be written in one script, and then split using this function into free-standing scripts, allowing trainees to see what the end-game is at each stage of the training
#'
#' @param session_n
#'
#' @return
#' @export
#'
#' @examples
milestone_split <- function(session_n) {
  input <- readr::read_lines(paths_from_session(session_n)[[1]])
  segs <- which(stringr::str_detect(input, milestone_delim))

  if(!file.exists(milestone_output_path)) {
    dir.create(milestone_output_path)
  }

  if (length(segs) > 1) {
    for (i in 1:length(segs)) {
      if (i != length(segs)) {
        output <- input[(segs[i] + 1):(segs[i + 1] - 1)]
        readr::write_lines(
          output,
          paste0(
            milestone_output_path,
            "\\",
            course_name_computer,
            "s",
            formatC(session_n, width = 2, flag = 0),
            "_ms_",
            formatC(i, width = 2, flag = 0),
            ".R"
          )
        )
      } else {
        output <- input[(segs[i] + 1):length(input)]
        readr::write_lines(
          output,
          paste0(
            milestone_output_path,
            "\\",
            course_name_computer,
            "s",
            formatC(session_n, width = 2, flag = 0),
            "_ms_",
            formatC(i, width = 2, flag = 0),
            ".R"
          )
        )
      }
    }
  }
}
