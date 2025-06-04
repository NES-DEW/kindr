#https://statistics.gov.scot/data/data-zone-lookup

#' scotcodes
#'
#' Geography codes are important but awkward. This function takes any of a range of possible geography codes, and returns whatever corresponding geography codes you need. The data contains both _Code and _Name variants of the following geography codes:
#' \itemize{
#'  \item DZ2011 - datazones
#'  \item IZ2011 - intermediate zones
#'  \item MMWard - wards
#'  \item LA - local authorities
#'  \item SPC
#'  \item UKPC
#'  \item UKPC - parliamentary consistuencies
#'  \item HB - health boards
#'  \item HIA - health integration areas
#'  \item SPD
#'  }
#'
#' @param from_var - an unquoted column name of the variable that you want to convert from
#' @param from_val - a quoted string containing the value to look up in that column
#' @param to_var - a quoted string containing full of partial
#'
#' @return tibble containing matching column(s)
#' @export
#'
#' @examples
#' scotcodes(HB_Name, "Highland", "DZ")
#' scotcodes(HB_Name, c("Highland", "Grampian"), "DZ2011_Name")
#' scotcodes(HB_Code, "S08000020", "Name") # returns all available data for Grampian
#'
scotcodes <- function(from_var, from_val, to_var) {

data("dz_lookup")

dz_lookup %>%
  dplyr::filter({{from_var}} %in% {{from_val}}) %>%
  dplyr::select(dplyr::contains(to_var))

}
