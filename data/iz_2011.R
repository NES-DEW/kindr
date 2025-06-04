delayedAssign("iz_2011", local({
  try(
    sf::read_sf(
      system.file("extdata/iz_2011.gpkg", package = "KINDR")
    ),
    silent = TRUE
  )
}))
