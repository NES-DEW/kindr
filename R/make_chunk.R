#' Provided a milestone number, generates a quarto chunk for that milestone
#'
#' @param milestone_number
#'
#' @return
#' @export
#'
#' @examples
make_chunk <- function(milestone_number) {
  c(
    paste0(
      milestone_delim_quarto,
      stringr::str_extract(basename(milestone_number), "[0-9]+(?=.R$)")
    ),
    "```{r}",
    "#| echo: true",
    "#| eval: false",
    paste0("#| file: ../", milestone_number),
    "```"
  )
}
