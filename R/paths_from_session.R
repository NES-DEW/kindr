#'  Take a session # and return paths to relevant files
#'
#' @param session_n
#'
#' @return
#' @export
#'
#' @examples
paths_from_session <- function(session_n) {
  list(
    outline = file_finder(session_n, outline_input_path, "R"),
    text = file_finder(session_n, text_input_path, "md"),
    milestones = file_finder(paste0("s", formatC(session_n, width = 2,flag = 0)), "milestones", "R"),
    slides = paste0(slide_output_path, "\\KIND_", course_name_computer, "s", formatC(session_n, width = 2,flag = 0), ".qmd")
  )
}
