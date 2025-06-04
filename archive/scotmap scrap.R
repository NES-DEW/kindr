

scotmap("iz") |>
  ggplot2::ggplot() +
  ggplot2::geom_sf() +
  #ggplot2::geom_sf_text(ggplot2::aes(label=HBName)) +
  ggplot2::theme_void()

scotmap("HIA") |>
  ggplot2::ggplot() +
  ggplot2::geom_sf() +
  #ggplot2::geom_sf_text(ggplot2::aes(label=HBName)) +
  ggplot2::theme_void()

scotmap("HB")

# left_join(region_lookup_dz, by=c("DataZone"="id_json"), keep=F)

# dz_2011@polygons <- dz_2011_sim@polygons

dz_2011_sf %>%
  ggplot() +
  geom_sf() +
  theme_void()

iz_2011 <-
  geojsonio::geojson_read("data/IZ/SG_IntermediateZone_Bdry_2011.shp",
                          what = "sp")

# these are just the polygons
iz_2011_sim_20 <- rgeos::gSimplify(iz_2011, tol=20, topologyPreserve=TRUE)

# then we simplify it
iz_2011@polygons <- iz_2011_sim_20@polygons

# and sf it
iz_2011 <- iz_2011 |> sf::st_as_sf()
iz_2011
iz_2011 |>
  # dplyr::filter(HBName=="Shetland") |>
  ggplot2::ggplot() +
  ggplot2::geom_sf() +
  #ggplot2::geom_sf_text(ggplot2::aes(label=HIAName)) +
  ggplot2::theme_void()
use_data(iz_2011)



scotmap("HB") |>
  ggplot2::ggplot() +
  ggplot2::geom_sf() +
  ggplot2::geom_sf_text(ggplot2::aes(label=HBName)) +
  ggplot2::theme_void()

scotmap("HB", "code", "S08000022")
scotmap("HB", "code", "S08000022") |>
  ggplot2::ggplot() +
  ggplot2::geom_sf() +
  ggplot2::geom_sf_text(ggplot2::aes(label=HBCode)) +
  ggplot2::theme_void()

scotmap("HB", "code", c("S08000020", "S08000022"))
scotmap("HB", "code", c("S08000020", "S08000022")) |>
  ggplot2::ggplot() +
  ggplot2::geom_sf() +
  ggplot2::geom_sf_text(ggplot2::aes(label=HBCode)) +
  ggplot2::theme_void()

scotmap("HB", "name", "high")
scotmap("HB", "name", "high") |>
  ggplot2::ggplot() +
  ggplot2::geom_sf() +
  ggplot2::geom_sf_text(ggplot2::aes(label=HBName)) +
  ggplot2::theme_void()

scotmap("HB", "name", c("high", "gramp"))
scotmap("HB", "name", c("high", "gramp")) |>
  ggplot2::ggplot() +
  ggplot2::geom_sf() +
  ggplot2::geom_sf_text(ggplot2::aes(label=HBName)) +
  ggplot2::theme_void()


scotmap("DZ", codes) |>
  # dplyr::filter(HBName=="Shetland") |>
  ggplot2::ggplot() +
  ggplot2::geom_sf() +
  ggplot2::geom_sf_text(ggplot2::aes(label=DataZone)) +
  ggplot2::theme_void()



