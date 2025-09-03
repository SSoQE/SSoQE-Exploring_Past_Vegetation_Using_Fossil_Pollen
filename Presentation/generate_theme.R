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
    "\n// SSoQE Brand Guidelines - direct color usage\n",
    "$body-color: $black !default;\n",
    "$backgroundColor: $white !default;\n",
    "$headingColor: $midnightGreen !default;\n",
    "$link-color: $persianGreen !default;\n",
    "$selection-bg: $persianGreen !default;\n",
    "$code-color: $black !default;\n",
    "$accent-color: $satinSheenGold !default;\n",
    "\n// Additional SSoQE brand utilities\n",
    ".text-color-body { color: $body-color !important; }\n",
    ".text-color-background { color: $backgroundColor !important; }\n",
    ".text-color-heading { color: $headingColor !important; }\n",
    ".text-color-link { color: $link-color !important; }\n",
    ".text-color-accent { color: $accent-color !important; }\n"
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
    paste0('$headingFont: "', fonts$heading, '", "Arial", sans-serif !default;\n'),
    paste0('$monospaceFont: "', fonts$monospace, '", "Courier New", monospace !default;\n'),
    "",
    ".text-font-body { font-family: $mainFont; }",
    ".text-font-heading { font-family: $headingFont; }",
    ".text-font-monospace { font-family: $monospaceFont; }",
    "",
    "/* Debug font loading - this will help us see if fonts are loaded */",
    paste0('@supports (font-family: "', fonts$heading, '") {'),
    "  .debug-font-heading::before {",
    paste0('    content: "', fonts$heading, ' font is supported";'),
    "    display: block;",
    "    font-size: 12px;",
    "    color: green;",
    "  }",
    "}",
    paste0('@supports (font-family: "', fonts$monospace, '") {'),
    "  .debug-font-mono::before {",
    paste0('    content: "', fonts$monospace, ' font is supported";'),
    "    display: block;",
    "    font-size: 12px;",
    "    color: green;",
    "  }",
    "}",
    ""
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

# Function to generate R theme file from JSON
generate_r_theme <- function(
    colors_file = here::here("Presentation/colors.json"),
    fonts_file = here::here("Presentation/fonts.json"),
    output_file = here::here("R/_Set_r_theme.R")) {
  message("Generating _Set_r_theme.R...\n")

  # Check if input files exist
  if (!file.exists(colors_file)) {
    stop("colors.json not found. Please create this file first.")
  }
  if (!file.exists(fonts_file)) {
    stop("fonts.json not found. Please create this file first.")
  }

  # Read colors and fonts from JSON
  colors <- jsonlite::fromJSON(colors_file)
  fonts <- jsonlite::fromJSON(fonts_file)

  # Generate R theme content
  r_theme_content <- c(
    "# This file is auto-generated from colors.json and fonts.json. Do not edit directly.",
    "# Generated by generate_theme.R based on SSoQE Brand Guidelines v1.1",
    "",
    "#----------------------------------------------------------#",
    "# SSoQE Brand Compliant R Theme Settings",
    "#----------------------------------------------------------#",
    "",
    "# Load required packages for theme",
    "if (!require(\"ggplot2\")) stop(\"ggplot2 package is required\")",
    "",
    "# SSoQE Brand Colors (from brand guidelines)",
    paste0("ssoqe_cols <- c("),
    paste0("  black = \"", colors$black, "\","),
    paste0("  white = \"", colors$white, "\","),
    paste0("  midnight_green = \"", colors$midnightGreen, "\","),
    paste0("  persian_green = \"", colors$persianGreen, "\","),
    paste0("  cambridge_blue = \"", colors$cambridgeBlue, "\","),
    paste0("  satin_sheen_gold = \"", colors$satinSheenGold, "\""),
    ")",
    "",
    "# SSoQE Color Scales for ggplot2",
    "scale_colour_ssoqe <- function(...) ggplot2::scale_colour_manual(values = ssoqe_cols, ...)",
    "scale_fill_ssoqe <- function(...) ggplot2::scale_fill_manual(values = ssoqe_cols, ...)",
    "",
    "# Primary color sequence (for ordered data)",
    paste0("ssoqe_primary_sequence <- c(\"", colors$midnightGreen, "\", \"", colors$persianGreen, "\", \"", colors$cambridgeBlue, "\")"),
    "",
    "# Diverging color palette (for diverging data)",
    paste0("ssoqe_diverging <- c(\"", colors$midnightGreen, "\", \"", colors$white, "\", \"", colors$satinSheenGold, "\")"),
    "",
    "# Text and background colors",
    paste0("ssoqe_text_color <- \"", colors$black, "\""),
    paste0("ssoqe_background_color <- \"", colors$white, "\""),
    paste0("ssoqe_accent_color <- \"", colors$satinSheenGold, "\""),
    "",
    "# Define typography (based on SSoQE brand guidelines)",
    paste0("ssoqe_base_font <- \"", fonts$body, "\""),
    paste0("ssoqe_heading_font <- \"", fonts$heading, "\""),
    paste0("ssoqe_mono_font <- \"", fonts$monospace, "\""),
    "",
    "# Define text sizes (following brand hierarchy)",
    "text_size_small <- 10",
    "text_size_base <- 12",
    "text_size_medium <- 14",
    "text_size_large <- 16",
    "text_size_xlarge <- 18",
    "",
    "# Define line sizes",
    "line_size_thin <- 0.25",
    "line_size_base <- 0.5",
    "line_size_thick <- 1.0",
    "",
    "# Define output dimensions (standard sizes)",
    "image_width <- 16",
    "image_height <- 12",
    "image_units <- \"cm\"",
    "image_dpi <- 300",
    "",
    "# Create SSoQE-compliant ggplot2 theme",
    "theme_ssoqe <- function(base_size = text_size_base,",
    "                       base_family = ssoqe_base_font,",
    "                       base_line_size = line_size_base,",
    "                       base_rect_size = line_size_base) {",
    "  ggplot2::theme_bw(base_size = base_size,",
    "                   base_family = base_family,",
    "                   base_line_size = base_line_size,",
    "                   base_rect_size = base_rect_size) +",
    "  ggplot2::theme(",
    "    # Text elements",
    paste0("    text = ggplot2::element_text(family = ssoqe_base_font, colour = \"", colors$black, "\"),"),
    paste0("    plot.title = ggplot2::element_text(family = ssoqe_heading_font, colour = \"", colors$midnightGreen, "\", face = \"bold\", size = ggplot2::rel(1.4)),"),
    paste0("    plot.subtitle = ggplot2::element_text(family = ssoqe_base_font, colour = \"", colors$black, "\", size = ggplot2::rel(1.1)),"),
    paste0("    axis.title = ggplot2::element_text(family = ssoqe_base_font, colour = \"", colors$black, "\", size = ggplot2::rel(1.0)),"),
    paste0("    axis.text = ggplot2::element_text(family = ssoqe_base_font, colour = \"", colors$black, "\", size = ggplot2::rel(0.9)),"),
    paste0("    legend.title = ggplot2::element_text(family = ssoqe_base_font, colour = \"", colors$black, "\", size = ggplot2::rel(1.0)),"),
    paste0("    legend.text = ggplot2::element_text(family = ssoqe_base_font, colour = \"", colors$black, "\", size = ggplot2::rel(0.9)),"),
    paste0("    strip.text = ggplot2::element_text(family = ssoqe_heading_font, colour = \"", colors$midnightGreen, "\", face = \"bold\"),"),
    "    ",
    "    # Background elements",
    paste0("    plot.background = ggplot2::element_rect(fill = \"", colors$white, "\", colour = NA),"),
    paste0("    panel.background = ggplot2::element_rect(fill = \"", colors$white, "\", colour = NA),"),
    paste0("    legend.background = ggplot2::element_rect(fill = \"", colors$white, "\", colour = NA),"),
    paste0("    strip.background = ggplot2::element_rect(fill = \"", colors$cambridgeBlue, "\", colour = \"", colors$midnightGreen, "\"),"),
    "    ",
    "    # Grid and axis lines",
    paste0("    panel.grid.major = ggplot2::element_line(colour = \"", colors$cambridgeBlue, "\", linewidth = line_size_thin),"),
    paste0("    panel.grid.minor = ggplot2::element_line(colour = \"", colors$cambridgeBlue, "\", linewidth = line_size_thin * 0.5),"),
    paste0("    axis.line = ggplot2::element_line(colour = \"", colors$black, "\", linewidth = line_size_base),"),
    paste0("    axis.ticks = ggplot2::element_line(colour = \"", colors$black, "\", linewidth = line_size_thin),"),
    "    ",
    "    # Other elements",
    "    legend.key = ggplot2::element_blank(),",
    "    plot.margin = ggplot2::margin(t = 10, r = 10, b = 10, l = 10)",
    "  )",
    "}",
    "",
    "# Set the default ggplot2 theme to SSoQE theme",
    "ggplot2::theme_set(theme_ssoqe())",
    "",
    "# Helper functions for common SSoQE visualizations",
    "ssoqe_discrete_colors <- function(n) {",
    "  if (n <= length(ssoqe_cols)) {",
    "    return(ssoqe_cols[1:n])",
    "  } else {",
    "    # Extend with interpolated colors if needed",
    "    return(grDevices::colorRampPalette(ssoqe_cols)(n))",
    "  }",
    "}",
    "",
    "# Export commonly used values for backward compatibility",
    "text_size <- text_size_base",
    "line_size <- line_size_base"
  )

  # Write to _Set_r_theme.R
  writeLines(
    text = r_theme_content,
    con = output_file
  )

  message("_Set_r_theme.R generated successfully\n")
}
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

  # Add specific font links for Google Fonts
  if (!is.null(fonts$body) && fonts$body != "") {
    body_font_url <- paste0(
      "https://fonts.googleapis.com/css2?family=",
      gsub(" ", "+", fonts$body), ":wght@400;500;600;700&display=swap"
    )
    font_links <- c(font_links, paste0('<link href="', body_font_url, '" rel="stylesheet">'))
  }

  if (!is.null(fonts$heading) && fonts$heading != "") {
    heading_font_url <- paste0(
      "https://fonts.googleapis.com/css2?family=",
      gsub(" ", "+", fonts$heading), ":wght@500;600;700&display=swap"
    )
    font_links <- c(font_links, paste0('<link href="', heading_font_url, '" rel="stylesheet">'))
  }

  if (!is.null(fonts$monospace) && fonts$monospace != "") {
    mono_font_url <- paste0(
      "https://fonts.googleapis.com/css2?family=",
      gsub(" ", "+", fonts$monospace), ":wght@400;500;700&display=swap"
    )
    font_links <- c(font_links, paste0('<link href="', mono_font_url, '" rel="stylesheet">'))
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
    generate_r_theme()

    message("\nTheme generation completed successfully!\n")
    message("Generated files:\n")
    message("  - _colors.scss\n")
    message("  - _fonts.scss\n")
    message("  - fonts-include.html\n")
    message("  - R/_Set_r_theme.R\n")
  },
  error = function(e) {
    message("\nError during theme generation:\n")
    message(paste("Error:", e$message, "\n"))
    quit(status = 1)
  }
)
