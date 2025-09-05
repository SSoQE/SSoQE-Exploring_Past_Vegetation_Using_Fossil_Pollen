#----------------------------------------------------------#
#
#
#        Exploring Past Vegetation Using Fossil Pollen
#
#                  Render presentation
#
#
#
#                       O. Mottl
#                         2025
#
#----------------------------------------------------------#

# The QUARTO is curently unable to render into other directory.
# GitHub pages require the presentation to be in the `docs` directory.
# This is a workaround to render the presentation into the `docs`` directory

# Setup -----

library(here)

source(
  here::here("R/00_Config_file.R")
)

# Render -----
quarto::quarto_render(
  input = here::here("R/Exercises/01_getting_data_with_neotoma2-online.qmd")
)

quarto::quarto_render(
  input = here::here("R/Exercises/02_working_with_pollen_data-offline.qmd")
)

quarto::quarto_render(
  input = here::here("R/Exercises/03_age_depth_model-offline.qmd")
)
