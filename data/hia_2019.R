delayedAssign("hia_2019", local({
  try(
    sf::read_sf(
      system.file("extdata/hia_2019.gpkg", package = "KINDR")
    ),
    silent = TRUE
  )
}))
