#' scotmap
#' easily generate sf data for Scotland, based on health boards, health integration areas, intermediate zones, or data zones
#' @param type The type of sf data needed
#' @param subgroup How to filter the sf data
#'
#' @return sf object
#' @export
#'
#' @examples
#' scotmap() # gives national data at the DZ2011 level
#' scotmap("IZ", "name", "hill") # interzones with "hill" in the name
scotmap <- function(type = "DZ", filter = NA, value = "All"){

# return a simplified shapefile tibble for plotting with geom_sf() of scottish interest
# select by DZ, IZ, HSCP, HB, LAD
# hb from 2019 https://www.data.gov.uk/dataset/27d0fe5f-79bb-4116-aec9-a8e565ff756a/nhs-health-boards-scotland
# iz from 2011 https://spatialdata.gov.scot/geonetwork/srv/eng/catalog.search#/metadata/389787c0-697d-4824-9ca9-9ce8cb79d6f5
# dz from 2011 https://spatialdata.gov.scot/geonetwork/srv/api/records/7d3e8709-98fa-4d71-867c-d5c8293823f2
# hia from 2019 https://spatialdata.gov.scot/geonetwork/srv/eng/catalog.search#/metadata/ac5e870f-8fc2-4c21-8b9c-3bd2311a583f
# huge thanks to Mike Mahoney for https://www.mm218.dev/posts/2022-12-01-sf-in-packages/ = getting out of sf/tibble trap


  if(type == "DZ" & is.na(filter)) {
    data(dz_2011)
    dz_2011
  } else if (type == "DZ" & filter == "code") {
    data(dz_2011)

    dz_2011 |>
      dplyr::filter(DataZone %in% value)

  } else if (type == "DZ" & filter == "name") {
    data(dz_2011)
    values <- paste0("(?i)", paste(value,collapse = '|'))
    dz_2011 |>
      dplyr::filter(stringr::str_detect(Name, values))

    } else if (type == "HB" & is.na(filter)) {
    data(hb_2019)
    hb_2019
  }

  else if (type == "HB" & filter == "code") {
    data(hb_2019)

    hb_2019 |>
      dplyr::filter(HBCode %in% value)

  } else if (type == "HB" & filter == "name") {
    data(hb_2019)
    values <- paste0("(?i)", paste(value,collapse = '|'))
    hb_2019 |>
      dplyr::filter(stringr::str_detect(HBName, values))

  }
# ?stringr::str_detect
  else if (type == "HIA" & is.na(filter)) {
    data(hia_2019)
    hia_2019
  } else if (type == "HIA" & filter == "code") {
    data(hia_2019)

    hia_2019 |>
      dplyr::filter(HIACode %in% value)

  } else if (type == "HIA" & filter == "name") {
    data(hia_2019)
    values <- paste0("(?i)", paste(value,collapse = '|'))
    hia_2019 |>
      dplyr::filter(stringr::str_detect(HIAName, values))

  } else if (type == "IZ" & is.na(filter)) {
    data(iz_2011)
    iz_2011
  } else if (type == "IZ" & filter == "code") {
    data(iz_2011)

    iz_2011 |>
      dplyr::filter(InterZone %in% value)

  } else if (type == "IZ" & filter == "name") {
    data(iz_2011)
    values <- paste0("(?i)", paste(value,collapse = '|'))
    iz_2011 |>
      dplyr::filter(stringr::str_detect(Name, values))

  }
}

# data(dz_2011)
# dz_2011 |> dplyr::filter(DataZone == "S01006506")
# # filter.sf
# load(file="inst/extdata/iz_2011.rda")
# sf::st_write(iz_2011, "inst/extdata/iz_2011.gpkg")
