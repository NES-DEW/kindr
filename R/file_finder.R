#' Find file based on session number, path, and pattern
#'
#' @param session_n
#' @param path
#' @param pattern
#'
#' @return
#' @export
#'
#' @examples
file_finder <- function(session_n, path, pattern){
  fn <- list.files(path, pattern=paste0("*.", pattern), full.names=T)
  fn[grepl(session_n, fn)]
}
