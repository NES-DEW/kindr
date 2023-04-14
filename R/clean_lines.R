#' Cleans out empty lines at head and foot of files
#'
#' @param file
#'
#' @return
#' @export
#'
#' @examples
clean_lines <- function(file) {
  input <- readr::read_lines(file)

  if (length(input > 1)) {
    if (input[1] == "") {
      while (input[1] == "")
        input <- input[-1]
      readr::write_lines(input, file)
    }
    if (input[length(input)] == "") {
      while (input[length(input)] == "")
        input <- input[-length(input)]
      readr::write_lines(input, file)
    }
  }
}
