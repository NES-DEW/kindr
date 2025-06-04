#' Provided a session number, generates a quarto header and then one chunk for each milestone sharing the same session number
#'
#' @param session_n
#'
#' @return quarto headers and chunks
#' @export
#'
#' @examples
#' build_quarto(1)
build_quarto <- function(session_n) {

  milestone_input_fns <- paths_from_session(session_n)[[3]]
  slide_output_fn <- paths_from_session(session_n)[[4]]

  if(!file.exists(slide_output_fn)) file.create(slide_output_fn)

  quarto_summary <- tibble::tibble(
    file = milestone_input_fns,
    session = paste0("session ", formatC(
      session_n, width = 2, flag = 0
    )),
    milestone =  purrr::map_chr(
      milestone_input_fns,
      ~ stringr::str_extract(basename(.x), "[0-9]+(?=.R$)")
    ),
    milestone_chunk = purrr::map(milestone_input_fns, make_chunk)
  )

  title <- paste0('title: "', course_name_human, '"')
  subtitle <- paste0('subtitle: "session ', session_n, '"')
  auth <- paste0('author: "', author, '"')

  header <-
    c(
      "---",
      title,
      subtitle,
      auth,
      "format: ",
      "    revealjs:",
      "        incremental: true",
      paste0('        logo: "', logo, '"'),
      paste0('        css: "', css_path, '"'),
      "        embed-resources: true",
      '        bibliography: "..//src//references.bib"',
      'scrollable: true',
      'smaller: true',
      'execute: ',
      '    echo: true',
      '    eval: false',
      '---'
    )

  readr::write_lines(header, slide_output_fn)

  #now make the chunks
  chunks <- quarto_summary %>%
    dplyr::filter(session == paste0("session ", formatC(session_n, width = 2,flag = 0))) %>%
    dplyr::pull(file)

  if(length(chunks) > 0) {
    for (j in 1:length(chunks)) {
      readr::write_lines(make_chunk(chunks[j]),
                  slide_output_fn,
                  append = T)

    }
  }
}
