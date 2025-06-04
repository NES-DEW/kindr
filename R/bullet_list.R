#' Convert a vector into a bulletted quarto list with less agony
#'
#' @param ... vector
#'
#' @return lump of quarto
#' @export
#'
#' @examples bullet_list(1:4)
bullet_list <- function(...) {
  cat(paste0("- ", c(...), collapse = "\n"))
  cat("\n")
}

