#' Infers organisation name from free text
#'
#' @param df Tibble containing free text
#' @param from Column containing free text
#' @param to Column to create containing organisation name
#'
#' @return A tibble
#' @export
#'
#' @examples data %>% org_from_free()
org_from_free <- function(df, from="Organisation", to="org_from_free"){
  data(boards, envir = environment())

  df %>%
    dplyr::mutate(
      !!to := dplyr::case_when(
        .data[[from]] %in% boards$name ~ .data[[from]],
        is.na(.data[[from]]) ~ "Unknown",
        str_detect(.data[[from]], "(?i)phs|public health scotland") ~ "Public Health Scotland",
        str_detect(.data[[from]], "(?i)NES|NHS education") ~ "NHS Education for Scotland",
        str_detect(.data[[from]], "(?i)ggc|NHS Greater Glasgow & Clyde|GG&C") ~ "NHS Greater Glasgow and Clyde",
        str_detect(.data[[from]], "(?i)NHS Ayrshire|NHS A&A") ~ "NHS Ayrshire & Arran",
        str_detect(.data[[from]], "(?i)NHS Dumfries and Galloway|NHS D&G|Dumfries and Galloway NHS|NHS DG") ~ "NHS Dumfries & Galloway",
        str_detect(.data[[from]], "(?i)Golden Jubilee") ~ "NHS Golden Jubilee National Hospital",
        str_detect(.data[[from]], "(?i)HIS|healthcare improvement scotland") ~ "Healthcare Improvement Scotland",
        str_detect(.data[[from]], "(?i)NSS") ~ "NHS National Services Scotland",
        str_detect(.data[[from]], "(?i)SAS") ~ "Scottish Ambulance Service",
        str_detect(.data[[from]], "(?i)NHS Borders") ~ "NHS Borders",
        str_detect(.data[[from]], "(?i)NHS24") ~ "NHS 24",
        str_detect(.data[[from]], "(?i)NHS lothian") ~ "NHS Lothian",
        str_detect(.data[[from]], "(?i)NHS lanarkshire") ~ "NHS Lanarkshire",
        str_detect(.data[[from]], "(?i)NHS grampian") ~ "NHS Grampian",
        str_detect(.data[[from]], "(?i)NHS tayside") ~ "NHS Tayside",
        str_detect(.data[[from]], "(?i)NHS highland") ~ "NHS Highland",
        str_detect(.data[[from]], "(?i)NHS") ~ "NHS (not specified)",
        TRUE ~ .data[[from]]
      )
    )
}

