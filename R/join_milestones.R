#' Joins the milestones to their appropriate chunk in the quarto
#'
#' @param session_n
#'
#' @return
#' @export
#'
#' @examples
join_milestones <- function(session_n) {
  quarto_input <- c(readr::read_lines(paths_from_session(session_n)[[4]]), "")
  text_input <- readr::read_lines(paths_from_session(session_n)[[2]])

  text_sections <-
    c(0,  which(stringr::str_detect(text_input, milestone_delim_text)), length(text_input))
  quarto_sections <-
    c(0, which(stringr::str_detect(quarto_input, milestone_delim_quarto)), length(quarto_input))

  if (length(text_sections) > length(quarto_sections)) {
    # cut text_sections down to size
    warning <-
      paste0(
        "  \n <!-- CAUTION: ",
        length(text_sections) - length(quarto_sections),
        " milestone(s) omitted -->"
      )

    text_sections <- text_sections[1:length(quarto_sections)]

  } else {
    warning <- paste0("  \n <!-- all milestones included -->")
  }

  purrr::map(1:(length(text_sections) - 1), ~ list(quarto_input[(quarto_sections[.x]):(quarto_sections[.x + 1] - 1)],
                                            text_input[(text_sections[.x] + 1):(text_sections[.x + 1] -
                                                                                  1)])) %>%
    unlist() %>%
    c(., warning) %>%
    readr::write_lines(., paths_from_session(session_n)[[4]])

}
