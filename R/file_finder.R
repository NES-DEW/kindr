#' Find file based on session number, path, and pattern
#'
#' @param session_n numeric session number
#' @param path root file path
#' @param pattern 3-digit file extension
#'
#' @return file path
#' @export
#'
#' @examples
#' file_finder(1, "/example", ".Rmd")
file_finder <- function(session_n, path, pattern){
  fn <- list.files(path, pattern=paste0("*.", pattern), full.names=T)
  fn[grepl(session_n, fn)]
}
