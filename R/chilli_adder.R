#' chilli_adder
#'
#' @param str - an input string describing the training level
#' @param html - HTML-friendly output required
#'
#' @returns - standardised training-level string with icon
#' @export
#'
#' @examples
#' chilli_adder("beginner")
#' chilli_adder("intermediate", html = FALSE)
chilli_adder <- function(str, html = T){

  str <- as.character(str)

  if(html){
    dplyr::case_when(
      stringr::str_detect(str, "pre-beginner") ~ "\U0001f4bc: <b>pre-beginner-level</b>",
      stringr::str_detect(str, "beginner") ~ paste0(
        "<style='color:red'>",
        "\U0001f336",
        "</style> :<b>beginner-level</b>"
      ),
      stringr::str_detect(str, "inter") ~ paste0(
        "<style='color:red'>",
        "\U0001f336\U0001f336",
        "</style>: <b>intermediate-level</b>"
      ),
      stringr::str_detect(str, "advanced") ~ paste0(
        "<style='color:red'>",
        "\U0001f336\U0001f336\U0001f336",
        "</style>: <b>advanced-level</b>"
      ),
      stringr::str_detect(str, "manag") ~ "\U0001f96c: <b>non-technical</b>")
  } else {
    dplyr::case_when(
      stringr::str_detect(str, "pre-beginner") ~ "\U0001f4bc: pre-beginner",
      stringr::str_detect(str, "beginner") ~ "\U0001f336: beginner-level",
      stringr::str_detect(str, "inter") ~ "\U0001f336\U0001f336: intermediate-level",
      stringr::str_detect(str, "advanced") ~ "\U0001f336\U0001f336\U0001f336: advanced-level",
      stringr::str_detect(str, "manag") ~ "\U0001f96c: non-technical")
  }

      }




