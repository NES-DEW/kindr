#' Create standardised KIND slides
#'
#' Creates standard training slides as a RevealJS Quarto presentation. Intended for VScode, rather than Rstudio. To be run inside intended containing folder.
#'
#' @return A project folder containing boilerplate training materials
#' @examples
#' presentation_proj("Neural Nets made ridiculously simple")

presentation_proj <- function(title){

dir.create("archive")
    dir.create("data")
    dir.create("src")
    dir.create("src/images")
    dir.create("src/R")

git_ignores <-
c(
    '.Rhistory',
    '.Rapp.history',
    '.RData',
    '.Ruserdata',
    '.Rproj.user/',
    '.Renviron'
)

writeLines(paste(git_ignores, sep = '\n'), '.gitignore')

file.create("references.bib")

qmd_contents <- c(
'---',
paste0(
    'title: "',
    title,
    '"'
),
'author: "Brendan Clarke, NHS Education for Scotland, [brendan.clarke2@nhs.scot](mailto:brendan.clarke2@nhs.scot)"',
paste0('date: "', Sys.Date(), '"'),
'date-format: DD/MM/YYYY',
'bibliography: references.bib',
'format:',
'    revealjs:',
'        theme: [default, custom.scss]',
'        width: 1600',
'        margin: 0.1',
'        logo: src/images/KLN_banner_v05_125_d.png',
'        css: src//images//logo_d.css',
'        incremental: true',
'        embed-resources: true',
'editor_options: ',
'    chunk_output_type: console',
'---',
'',
'```{r}',
'#| echo: false',
'#| warning: false',
'',
'knitr::opts_chunk$set(echo = F, warning = F, message = F, results = "asis", fig.width = 15, fig.height = 6, fig.align = "center")',
'',
'library(pacman)',
'p_load(tidyverse, KINDR)',
'',
'colz <- c("#f29559", "#f2d492","#202c39", "#f4f3ee" )',
'theme_set(theme_classic())',
'theme_update(panel.background = element_rect(fill = "#202c39"), plot.background = element_rect(fill = "#202c39"), axis.line = element_line(size = 0.5, linetype = "solid", colour = "#f4f3ee"), axis.text = element_text(colour = "#f4f3ee"), text = element_text(colour = "#f4f3ee"), legend.background = element_rect(fill = "#4D5661"), strip.text = element_text(colour = "#f4f3ee"), strip.background = element_rect(fill = "#4D5661", color = "#202c39"), panel.grid.major = element_blank(), panel.grid.minor = element_blank())',
'```',
'',
'',
'## Welcome',
'',
'+ this session is for 🌶 / 🥬 / 💼',
'+ we\'ll get going properly at xx.05',
'+ you\'ll need XXXX of some sort to follow along',
'+ if you can\'t access the chat, you might need to join our Teams channel: [tinyurl.com/kindnetwork](https://teams.microsoft.com/l/team/19%3AQZ7-PbFVcziG2piHLt1_ifey3I2cwFL0yBuTSS8vVao1%40thread.tacv2/conversations?groupId=106d08f3-9026-40e2-b3c7-87cd87304d58&tenantId=10efe0bd-a030-4bca-809c-b5e6745e499a)',
'+ you can find session materials at [tinyurl.com/kindtrp](https://nes-dew.github.io/KIND-training/)',
'',
'## The KIND network',
'',
'-   a social learning space for staff working with **k**nowledge, **i**nformation, and **d**ata across health, social care, and housing in Scotland',
'-   we offer social support, free training, mentoring, community events, ...',
'-   [Teams channel](https://teams.microsoft.com/l/team/19%3AQZ7-PbFVcziG2piHLt1_ifey3I2cwFL0yBuTSS8vVao1%40thread.tacv2/conversations?groupId=106d08f3-9026-40e2-b3c7-87cd87304d58&tenantId=10efe0bd-a030-4bca-809c-b5e6745e499a) / [mailing list](https://forms.office.com/pages/responsepage.aspx?id=veDvEDCgykuAnLXmdF5JmpopIZB9ynRJnrPUHVFccipURjM2NkZJUkhGOFlQRjQxRFhVUTgwT0UwVyQlQCN0PWcu)',
'',
'## XXXXX training sessions',
'',
'```{r}',
'#KINDR::training_sessions("Excel", "2024/07/11")',
'```',
'',
'## Where does this fit in?',
'',
'## Session outline',
'',
'## content 1',
'',
'## content 2',
'',
'## Feedback and resources',
'',
'-   please can I [ask for some feedback](`r KINDR::feedback_url("Title", "Date")`) - takes less than a minute, completely anonymous, helps people like you find the right training for them',
'',
'. . .',
'',
'```{r}',
'#KINDR::training_sessions("Excel", "2024/07/11")',
'```',
''

)

readr::write_lines(qmd_contents, paste0(title, ".qmd"))

customscss <- c('/*-- scss:defaults --*/',
                      '$body-bg: #202c39;',
                      '$body-color: #f4f3ee;',
                      '$link-color: #f2d492;',
                      '$headingColor: #f29559;',
                      '',
                      '',
                      '/*-- scss:rules --*/',
                      '.reveal .slide blockquote {
          border-left: 3px solid $text-muted;
          padding-left: 0.5em;
        }',
        '/*-- c("#009FE3", "#124987", "#009B55","#F1AF00"--*/')

readr::write_lines(customscss, paste0("custom.scss"))

logocss_d <- c(

      '.reveal .slide-logo {
        height: 85px !important;
        width: 300px!important;
        max-width: unset !important;
        max-height: unset !important;
      }'


      )

readr::write_lines(logocss_d, paste0("src//images//logo_d.css"))
curl::curl_download("https://raw.githubusercontent.com/NES-DEW/KIND-training/main/src/images/KLN_banner_v05_125_d.png", "src/images/KLN_banner_v05_125_d.png") 
}