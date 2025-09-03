#----------------------------------------------------------#
#
#
#        Exploring Past Vegetation Using Fossil Pollen
#
#                     Config file
#
#
#                      O. Mottl
#                         2025
#
#----------------------------------------------------------#
# Configuration script with the variables that should be consistent throughout
#   the whole repo. It loads packages, defines important variables,
#   authorises the user, and saves config file.

# Set the current environment
current_env <- environment()

# set seed
set.seed(1234)


#----------------------------------------------------------#
# 1. Load packages -----
#----------------------------------------------------------#

if (
  isFALSE(
    exists("already_synch", envir = current_env)
  )
) {
  already_synch <- FALSE
}

if (
  isFALSE(already_synch)
) {
  library(here)
  # Synchronise the package versions
  renv::restore(
    lockfile = here::here("renv.lock")
  )
  already_synch <- TRUE

  # Save snapshot of package versions
  # renv::snapshot(lockfile =  "renv.lock")  # do only for update
}

# Define packages
package_list <-
  c(
    "Bchron",
    "countdown",
    "fs",
    "geojsonsf",
    "here",
    "janitor",
    "jsonlite",
    "knitr",
    "languageserver",
    "neotoma2",
    "pander",
    "quarto",
    "renv",
    "remotes",
    "rlang",
    "tidyverse",
    "tinytable",
    "usethis",
    "utils"
  )

# Attach all packages
sapply(package_list, library, character.only = TRUE)


#----------------------------------------------------------#
# 2. Load functions -----
#----------------------------------------------------------#

# get vector of general functions
fun_list <-
  list.files(
    path = here::here("R/Functions/"),
    pattern = "*.R",
    recursive = TRUE
  )

# source them
if (
  length(fun_list) > 0
) {
  here::here("R/Functions", fun_list) %>%
    purrr::walk(
      .f = source
    )
}


#----------------------------------------------------------#
# 3. Graphical options -----
#----------------------------------------------------------#

source(
  here::here("R/generate_theme.R")
)

source(
  here::here("R/set_r_theme.R")
)
