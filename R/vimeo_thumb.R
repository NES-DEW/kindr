
#' Make a thumbnail from title and speaker information for Vimeo
#'
#' @param topic The session topic
#' @param speaker Speaker name (and affiliation)
#' @param logo A direct URL for any custom logo, e.g. for theme weeks
#' @param save whether to save a png in working directory
#'
#' @returns magick image (and possibly png in working directory)
#' @export
#'
#' @examples
#'
#' vimeo_thumb("Open Source in NHS Lothian", "Zena Trendell (NHS Lothian)  \nJules Augley (NHS Lothian)", "https://raw.githubusercontent.com/NES-DEW/dew-img/refs/heads/main/kind/kind_banner_700_osw.png")
#' vimeo_thumb("Open Source in NHS Lothian", "Zena Trendell (NHS Lothian)  \nJules Augley (NHS Lothian)", "https://raw.githubusercontent.com/NES-DEW/dew-img/refs/heads/main/kind/kind_banner_700_osw.png", save = T)

vimeo_thumb <- function(topic, speaker, logo = "https://raw.githubusercontent.com/NES-DEW/dew-img/refs/heads/main/kind/kind_banner_700.png", save = F){

  if(nchar(topic) > 55| nchar(speaker) > 60) stop("Topic or speaker names are wayyyy too long")

  topic <- paste0(strwrap(topic, width = 30), collapse = "  \n")

  speaker_offset <- "+25+125"

  if(grepl("\n", topic)){
    speaker_offset <- "+25+175"
  }

  output <- magick::image_read(logo) |>
    magick::image_extent(geometry = "1000x555", color = "white", gravity = "southeast") |>
    magick::image_annotate(
      text = topic,
      font = "Calibri-Bold",
      size = 70,
      weight = 700,
      color = "#2C3792",
      location = "+25+25") |>
    magick::image_annotate(
      text = speaker,
      font = "Calibri-Bold",
      weight = 400,
      size = 70,
      color = "#AB2493",
      location = speaker_offset)

  if(save){
    output |>
      magick::image_write(paste0(fs::path_sanitize(topic), "_", fs::path_sanitize(speaker), ".png"))
  }

  output

}



