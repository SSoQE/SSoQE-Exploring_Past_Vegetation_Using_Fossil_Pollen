#!/usr/bin/env Rscript

# Theme Generation Script for SSOQE Presentation
# This script automatically generates SCSS files from JSON configuration
# It runs before every Quarto render via the pre-render hook

# Load required libraries
if (!require("jsonlite")) install.packages("jsonlite")
if (!require("here")) install.packages("here")
if (!require("purrr")) install.packages("purrr")

library(jsonlite)
library(here)
library(purrr)

# Set the working directory to the Presentation folder
here::i_am("Presentation/generate_theme.R")

# Function to generate colors SCSS from JSON
generate_colors_scss <- function(
    input_file = here::here("Presentation/colors.json"),
    output_file = here::here("Presentation/_colors.scss")) {
  message("Generating _colors.scss...\n")

  # Check if colors.json exists
  if (!file.exists(input_file)) {
    stop("colors.json not found. Please create this file first.")
  }

  # Read colors from JSON
  colors <- jsonlite::fromJSON(input_file)

  # Generate SCSS color definitions with utility classes
  colors_definition <- purrr::imap(
    .x = colors,
    .f = ~ {
      paste0(
        "// Color: ", .y, "\n",
        "$", .y, ": ", unname(.x), ";\n",
        ".reveal .bg-", .y, " { background-color: ", unname(.x), "; }\n",
        ".text-color-", .y, " { color: ", unname(.x), " !important; }\n",
        ".text-background-", .y, " {\n",
        "  background-color: ", unname(.x), ";\n",
        "  padding: $smallMargin;\n",
        "  border-radius: 5px;\n",
        "}\n",
        ".text-highlight-", .y, " {\n",
        "  background-color: ", unname(.x), ";\n",
        "  color: $white;\n",
        "  padding: 2px 4px;\n",
        "  border-radius: 3px;\n",
        "}\n"
      )
    }
  ) %>%
    paste(collapse = "\n")
  
  # Add semantic color mappings at the end
  semantic_mappings <- paste0(
    "\n// Direct color usage - simple and clear naming\n",
    "$body-color: $black !default;\n",
    "$backgroundColor: $white !default;\n",
    "$headingColor: $byzantium !default;\n",
    "$link-color: $persianGreen !default;\n",
    "$selection-bg: $persianGreen !default;\n",
    "$code-color: $black !default;\n",
    "\n// Additional direct color utilities\n",
    ".text-color-body { color: $body-color !important; }\n",
    ".text-color-background { color: $backgroundColor !important; }\n",
    ".text-color-heading { color: $headingColor !important; }\n",
    ".text-color-link { color: $link-color !important; }\n"
  )

  # Write to _colors.scss
  writeLines(
    text = c(
      "// This file is auto-generated from colors.json. Do not edit directly.",
      "",
      colors_definition,
      semantic_mappings
    ),
    con = output_file
  )

  message("_colors.scss generated successfully\n")
}

# Function to generate fonts SCSS from JSON
generate_fonts_scss <- function(
    input_file = here::here("Presentation/fonts.json"),
    output_file = here::here("Presentation/_fonts.scss")) {
  message("Generating _fonts.scss...\n")

  # Check if fonts.json exists
  if (!file.exists(input_file)) {
    stop("fonts.json not found. Please create this file first.")
  }

  # Read fonts from JSON
  fonts <- jsonlite::fromJSON(input_file)

  # Generate SCSS font definitions
  fonts_definition <- c(
    paste0('$mainFont: "', fonts$body, '", "Arial", sans-serif !default;\n'),
    paste0('$headingFont: "', fonts$heading, '", "Courier New", monospace !default;\n'),
    "",
    ".text-font-body { font-family: $mainFont; }",
    ".text-font-heading { font-family: $headingFont; }",
    "",
    "/* Debug font loading - this will help us see if the font is loaded */",
    paste0('@supports (font-family: "', fonts$heading, '") {'),
    "  .debug-font-loaded::before {",
    paste0('    content: "', fonts$heading, ' font is supported";'),
    "    display: block;",
    "    font-size: 12px;",
    "    color: green;",
    "  }",
    "}",
    "",
    "/* Force font loading for debugging */",
    ".force-font-heading {",
    paste0('  font-family: "', fonts$heading, '", monospace !important;'),
    "  font-display: swap;",
    "}"
  )

  # Write to _fonts.scss
  writeLines(
    text = c(
      "// This file is auto-generated from fonts.json. Do not edit directly.",
      "",
      fonts_definition
    ),
    con = output_file
  )

  message("_fonts.scss generated successfully\n")
}

# Function to generate fonts-include.html from JSON
generate_fonts_html <- function(
    input_file = here::here("Presentation/fonts.json"),
    output_file = here::here("Presentation/fonts-include.html")) {
  message("Generating fonts-include.html...\n")

  # Check if fonts.json exists
  if (!file.exists(input_file)) {
    stop("fonts.json not found. Please create this file first.")
  }

  # Read fonts from JSON
  fonts <- jsonlite::fromJSON(input_file)

  # Generate Google Fonts links
  font_links <- c(
    '<link rel="preconnect" href="https://fonts.googleapis.com">',
    '<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>'
  )

  # Read fonts from JSON
  fonts <- jsonlite::fromJSON(input_file)

  # Generate Google Fonts links
  font_links <- c(
    '<link rel="preconnect" href="https://fonts.googleapis.com">',
    '<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>'
  )

  # Add specific font links (you may need to customize these URLs based on actual fonts)
  if (!is.null(fonts$body) && fonts$body != "") {
    body_font_url <- paste0(
      "https://fonts.googleapis.com/css2?family=",
      gsub(" ", "+", fonts$body), ":wght@400;700&display=swap"
    )
    font_links <- c(font_links, paste0('<link href="', body_font_url, '" rel="stylesheet">'))
  }

  if (!is.null(fonts$heading) && fonts$heading != "") {
    heading_font_url <- paste0(
      "https://fonts.googleapis.com/css2?family=",
      gsub(" ", "+", fonts$heading), "&display=swap"
    )
    font_links <- c(font_links, paste0('<link href="', heading_font_url, '" rel="stylesheet">'))
  }

  # Write to fonts-include.html
  writeLines(
    text = c(
      "<!-- This file is auto-generated from fonts.json. Do not edit directly. -->",
      font_links
    ),
    con = output_file
  )

  message("fonts-include.html generated successfully\n")
}

# Main execution
message("SSOQE Theme Generation\n")
message("Starting theme generation process...\n\n")

tryCatch(
  {
    # Generate all theme files
    generate_colors_scss()
    generate_fonts_scss()
    generate_fonts_html()

    message("\nTheme generation completed successfully!\n")
    message("Generated files:\n")
    message("  - _colors.scss\n")
    message("  - _fonts.scss\n")
    message("  - fonts-include.html\n")
  },
  error = function(e) {
    message("\nError during theme generation:\n")
    message(paste("Error:", e$message, "\n"))
    quit(status = 1)
  }
)
