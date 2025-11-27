
#' Make a thumbnail from title and speaker information for Vimeo
#'
#' @param topic The session topic
#' @param speaker Speaker name (and affiliation)
#' @param logo A direct URL for any custom logo, e.g. for theme weeks
#'
#' @returns saves png thumbnail in working directory
#' @export
#'
#' @examples
#'
#' vimeo_thumb("Open Source in NHS Lothian", "Zena Trendell (NHS Lothian)  \nJules Augley (NHS Lothian)", "https://raw.githubusercontent.com/NES-DEW/dew-img/refs/heads/main/kind/kind_banner_700_osw.png")

vimeo_thumb <- function(topic, speaker, logo = "https://raw.githubusercontent.com/NES-DEW/dew-img/refs/heads/main/kind/kind_banner_700.png"){
  magick::image_read(logo) |>
    magick::image_extent(geometry = "1000x555", color = "white", gravity = "southeast") |>
    magick::image_annotate(
      text = topic,
      font = "Calibri-Bold",
      size = 70,
      color = "#2C3792",
      location = "+25+25") |>
    magick::image_annotate(
      text = speaker,
      font = "Calibri-Bold",
      size = 70,
      color = "#AB2493",
      location = "+25+125") |>
    magick::image_write(paste0(fs::path_sanitize(topic), "_", fs::path_sanitize(speaker), ".png"))


}



