delayedAssign("hb_2019", local({
  try(
    sf::read_sf(
      system.file("extdata/hb_2019.gpkg", package = "KINDR")
    ),
    silent = TRUE
  )
}))
