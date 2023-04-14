#' Given a training session number, builds and opens a .qmd from a text section file and a milestones file
#'
#' @param session_n
#' @param render
#'
#' @return qmd and html version of training file
#' @export
#'
#' @examples
make_qmd <- function(session_n, render = FALSE) {

  milestone_split(session_n)

  purrr::walk(paths_from_session(session_n)[[3]], clean_lines)

  build_quarto(session_n)

  join_milestones(session_n)

  if (render == TRUE) {
    quarto::quarto_render(paths_from_session(session_n)[[4]])
    rstudioapi::viewer(paste0(
      tools::file_path_sans_ext(paths_from_session(session_n)[[4]]),
      ".html"
    ))
  }
}
