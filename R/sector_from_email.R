#' Infer sector from supplied email address
#'
#' @param df A tibble containing email addresses
#' @param from A column name containing email addresses
#' @param to A column name as the destination for sector descriptions
#'
#' @return A tibble
#' @export
#'
#' @examples data %>% sector_from_email()
#'
sector_from_email <- function(df, from="Email", to="sector_from_email") {
  df %>%
    dplyr::mutate(
      !!to := dplyr::case_when(
        stringr::str_detect(.data[[from]], "(?i)nhs.scot|phs.scot|scot.nhs.uk") ~ "NHS",
        stringr::str_detect(.data[[from]], "(?i)gov.uk|gov.scot|digitaloffice.scot") ~ "Government",
        stringr::str_detect(.data[[from]], "(?i)arkha.org|sfha.co|blackwoodgroup.org|loreburn.org.uk|linstone.co.uk|hanover.scot|glenoaks.org.uk") ~ "Housing",
        stringr::str_detect(.data[[from]], "(?i)cvo|enable|capability|crossreach|scottishcare|reallifeoptions|alliance-scotland|dvva|sssc|chas.org|ccpscotland|vocal.org|macmillan.org|scld.co.uk|c-change.org.uk|viewpoint.org.uk") ~ "Care",
        stringr::str_detect(.data[[from]], "(?i)ac.uk|dhi-scotland") ~ "Academic",
        is.na(.data[[from]]) ~ "Missing",
        TRUE ~ "Other"
      )
    )
}
