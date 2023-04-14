#' Generate an organisation from supplied email addresses
#'
#' @param df A tibble containing email addresses
#' @param from Column containing email addresses
#' @param to Column to create containing infered organisations
#' @param lump_misc Option to gather non-standard addresses into an 'Other' category, or to retain their stem (e.g. nhs.scot).
#'
#' @return A tibble
#' @export
#'
#' @examples data %>%
#' org_from_email()
org_from_email <- function(df, from="Email", to="org_from_email", lump_misc=TRUE){

    df %>%
      dplyr::mutate(
        !!to := dplyr::case_when(
          is.na(.data[[from]]) ~ "Unknown",
          str_detect(.data[[from]], "(?i)gmail|yahoo|hotmail|sky.com|protonmail.com|live.co.uk") ~ "Public email",
          str_detect(.data[[from]], "(?i)phs") ~ "Public Health Scotland",
          str_detect(.data[[from]], "(?i)ggc") ~ "NHS Greater Glasgow and Clyde",
          str_detect(.data[[from]], "(?i)aapct.scot") ~ "NHS Ayrshire & Arran",
          str_detect(.data[[from]], "(?i)gjnh.scot") ~ "NHS Golden Jubilee National Hospital",
          str_detect(.data[[from]], "(?i)scottishcare.org") ~ "Scottish Care",
          str_detect(.data[[from]], "(?i)borders.scot") ~ "NHS Borders",
          str_detect(.data[[from]], "(?i)NHS24") ~ "NHS 24",
          str_detect(.data[[from]], "(?i)nhslothian.scot") ~ "NHS Lothian",
          str_detect(.data[[from]], "(?i)lanarkshire.scot") ~ "NHS Lanarkshire",
          str_detect(.data[[from]], "(?i)enablegroup.org.uk") ~ "Enable Group",
          str_detect(.data[[from]], "(?i)capability.scot") ~ "Capability Scotland",
          str_detect(.data[[from]], "(?i)forthvalley.nhs") ~ "NHS Forth Valley",
          str_detect(.data[[from]], "(?i)gov.scot|digitaloffice.scot") ~ "Scottish Government",
          str_detect(.data[[from]], "(?i)NHS") ~ "NHS (not specified)",
          is.na(.data[[from]]) ~ "Missing",
          if(lump_misc==FALSE) { TRUE ~ stringr::str_extract(.data[[from]], "(?<=@)(.+)$")
            } else {TRUE ~ "Other" }
        )
      )
  }


