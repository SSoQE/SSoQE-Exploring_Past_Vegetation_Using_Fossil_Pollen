#!/usr/bin/env Rscript

# Theme Generation Script for SSOQE Presentation
# This script automatically generates SCSS files from JSON configuration
# It runs before every Quarto render via the pre-render hook

library(here)
library(jsonlite)
library(purrr)

# Function to generate colors SCSS from JSON
generate_colors_scss <- function(
    input_file = here::here("Presentation/colors.json"),
    output_file = here::here("Presentation/_colors.scss")) {
  message("Generating _colors.scss...\n")

  # Check if colors.json exists
  if (
    !file.exists(input_file)
  ) {
    stop("colors.json not found. Please create this file first.")
  }

  # Read colors from JSON
  colors <- jsonlite::fromJSON(input_file)

  # Generate SCSS color definitions with utility classes
  colors_definition <-
    purrr::imap(
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
    ) |>
    paste(collapse = "\n")

  # Add semantic color mappings at the end
  semantic_mappings <-
    paste0(
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
  if (
    !file.exists(input_file)
  ) {
    stop("fonts.json not found. Please create this file first.")
  }

  # Read fonts from JSON
  fonts <- jsonlite::fromJSON(input_file)

  # Generate SCSS font definitions
  fonts_definition <-
    c(
      paste0('$mainFont: "', fonts$body, '", "Arial", sans-serif !default;\n'),
      paste0('$headingFont: "', fonts$heading, '", "Arial", sans-serif !default;\n'),
      paste0('$monospaceFont: "', fonts$monospace, '", "Courier New", monospace !default;\n'),
      "",
      "// Font sizes from fonts.json",
      paste0('$mainFontSize: ', fonts$sizes$mainFontSize, ' !default;'),
      paste0('$heading1Size: ', fonts$sizes$heading1Size, ' !default;'),
      paste0('$heading2Size: ', fonts$sizes$heading2Size, ' !default;'),
      paste0('$heading3Size: ', fonts$sizes$heading3Size, ' !default;'),
      paste0('$heading4Size: ', fonts$sizes$heading4Size, ' !default;'),
      paste0('$body-line-height: ', fonts$sizes$bodyLineHeight, ' !default;'),
      paste0('$headingLineHeight: ', fonts$sizes$headingLineHeight, ' !default;'),
      "",
      "// Font weights from fonts.json",
      paste0('$headingFontWeight: ', fonts$weights$headingFontWeight, ' !default;'),
      paste0('$bodyFontWeight: ', fonts$weights$bodyFontWeight, ' !default;'),
      paste0('$boldFontWeight: ', fonts$weights$boldFontWeight, ' !default;'),
      "",
      "// Font spacing from fonts.json", 
      paste0('$headingLetterSpacing: ', fonts$spacing$headingLetterSpacing, ' !default;'),
      paste0('$bodyLetterSpacing: ', fonts$spacing$bodyLetterSpacing, ' !default;'),
      "",
      "// Utility classes for font families",
      ".text-font-body { font-family: $mainFont; }",
      ".text-font-heading { font-family: $headingFont; }",
      ".text-font-monospace { font-family: $monospaceFont; }",
      "",
      "// Utility classes for font sizes", 
      paste0(".text-size-main { font-size: $mainFontSize !important; }"),
      paste0(".text-size-heading1 { font-size: $heading1Size !important; }"),
      paste0(".text-size-heading2 { font-size: $heading2Size !important; }"),
      paste0(".text-size-heading3 { font-size: $heading3Size !important; }"),
      paste0(".text-size-heading4 { font-size: $heading4Size !important; }"),
      paste0(".text-size-body { font-size: $mainFontSize !important; }"),
      paste0(".text-smaller { font-size: calc($mainFontSize * ", fonts$sizes$textSizeSmall, ") !important; }"),
      paste0(".text-tiny { font-size: calc($mainFontSize * ", fonts$sizes$textSizeTiny, ") !important; }"),
      paste0(".text-larger { font-size: calc($mainFontSize * ", fonts$sizes$textSizeLarge, ") !important; }"),
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
    output_file = here::here("R/set_r_theme.R")) {
  message("Generating set_r_theme.R...\n")

  # Check if input files exist
  if (
    !file.exists(colors_file)
  ) {
    stop("colors.json not found. Please create this file first.")
  }

  if (
    !file.exists(fonts_file)
  ) {
    stop("fonts.json not found. Please create this file first.")
  }

  # Read colors and fonts from JSON
  colors <- jsonlite::fromJSON(colors_file)
  fonts <- jsonlite::fromJSON(fonts_file)

  # Generate R theme content
  r_theme_content <-
    c(
      "# This file is auto-generated from colors.json and fonts.json. Do not edit directly.",
      "# Generated by generate_theme.R based on SSoQE Brand Guidelines v1.1",
      "",
      "#----------------------------------------------------------#",
      "# SSoQE Brand Compliant R Theme Settings",
      "#----------------------------------------------------------#",
      "",
      "# Load required packages for theme",
      "if (!require(\"ggplot2\")) stop(\"ggplot2 package is required\")",
      "if (!require(\"sysfonts\")) stop(\"sysfonts package is required for custom fonts\")",
      "if (!require(\"showtext\")) stop(\"showtext package is required for custom fonts\")",
      "",
      "# Load Google Fonts using sysfonts with error handling",
      "# Try to load Plus Jakarta Sans (may be named differently in Google Fonts)",
      "tryCatch({",
      "  sysfonts::font_add_google(\"Plus Jakarta Sans\", \"ssoqe_body\")",
      "}, error = function(e) {",
      "  # Try alternative names for Plus Jakarta Sans",
      "  tryCatch({",
      "    sysfonts::font_add_google(\"Jakarta Sans\", \"ssoqe_body\")",
      "  }, error = function(e2) {",
      "    # Fallback to a similar font",
      "    message(\"Plus Jakarta Sans not found, using Inter as fallback\")",
      "    sysfonts::font_add_google(\"Inter\", \"ssoqe_body\")",
      "  })",
      "})",
      "",
      "# Load Space Grotesk",
      "tryCatch({",
      paste0("  sysfonts::font_add_google(\"", fonts$heading, "\", \"ssoqe_heading\")"),
      "}, error = function(e) {",
      "  message(\"Space Grotesk not found, using Roboto Condensed as fallback\")",
      "  sysfonts::font_add_google(\"Roboto Condensed\", \"ssoqe_heading\")",
      "})",
      "",
      "# Load JetBrains Mono", 
      "tryCatch({",
      paste0("  sysfonts::font_add_google(\"", fonts$monospace, "\", \"ssoqe_mono\")"),
      "}, error = function(e) {",
      "  message(\"JetBrains Mono not found, using Fira Code as fallback\")",
      "  sysfonts::font_add_google(\"Fira Code\", \"ssoqe_mono\")",
      "})",
      "",
      "# Enable showtext for rendering custom fonts",
      "showtext::showtext_auto()",
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
      "# Using registered font names from sysfonts",
      "ssoqe_base_font <- \"ssoqe_body\"",
      "ssoqe_heading_font <- \"ssoqe_heading\"", 
      "ssoqe_mono_font <- \"ssoqe_mono\"",
      "",
      "# Define text sizes (following brand hierarchy from fonts.json)",
      "# Convert px to pt: 1px ≈ 0.75pt (at 96 DPI)",
      paste0("text_size_main_px <- ", gsub("px", "", fonts$sizes$mainFontSize)),
      "text_size_main_pt <- text_size_main_px * 0.75  # Convert px to pt",
      "text_size_small <- text_size_main_pt * 0.8",
      "text_size_base <- text_size_main_pt * 0.9", 
      "text_size_medium <- text_size_main_pt * 1.0",
      "text_size_large <- text_size_main_pt * 1.2",
      "text_size_xlarge <- text_size_main_pt * 1.4",
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

  # Write to set_r_theme.R
  writeLines(
    text = r_theme_content,
    con = output_file
  )

  message("set_r_theme.R generated successfully\n")
}

generate_fonts_html <- function(
    input_file = here::here("Presentation/fonts.json"),
    output_file = here::here("Presentation/fonts-include.html")) {
  message("Generating fonts-include.html...\n")

  # Check if fonts.json exists
  if (
    !file.exists(input_file)
  ) {
    stop("fonts.json not found. Please create this file first.")
  }

  # Read fonts from JSON
  fonts <- jsonlite::fromJSON(input_file)

  # Generate Google Fonts links
  font_links <-
    c(
      '<link rel="preconnect" href="https://fonts.googleapis.com">',
      '<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>'
    )

  # Read fonts from JSON
  fonts <- jsonlite::fromJSON(input_file)

  # Generate Google Fonts links
  font_links <-
    c(
      '<link rel="preconnect" href="https://fonts.googleapis.com">',
      '<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>'
    )

  # Add specific font links for Google Fonts
  if (
    !is.null(fonts$body) && fonts$body != ""
  ) {
    body_font_url <-
      paste0(
        "https://fonts.googleapis.com/css2?family=",
        gsub(" ", "+", fonts$body), ":wght@400;500;600;700&display=swap"
      )
    font_links <-
      c(
        font_links,
        paste0('<link href="', body_font_url, '" rel="stylesheet">')
      )
  }

  if (
    !is.null(fonts$heading) && fonts$heading != ""
  ) {
    heading_font_url <-
      paste0(
        "https://fonts.googleapis.com/css2?family=",
        gsub(" ", "+", fonts$heading), ":wght@500;600;700&display=swap"
      )

    font_links <-
      c(
        font_links,
        paste0('<link href="', heading_font_url, '" rel="stylesheet">')
      )
  }

  if (
    !is.null(fonts$monospace) && fonts$monospace != ""
  ) {
    mono_font_url <-
      paste0(
        "https://fonts.googleapis.com/css2?family=",
        gsub(" ", "+", fonts$monospace), ":wght@400;500;700&display=swap"
      )
    font_links <-
      c(
        font_links,
        paste0('<link href="', mono_font_url, '" rel="stylesheet">')
      )
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

# Function to generate exercise SCSS theme for HTML documents
generate_exercise_scss <- function(
    colors_file = here::here("Presentation/colors.json"),
    fonts_file = here::here("Presentation/fonts.json"),
    output_file = here::here("R/Exercises/_exercise_theme.scss")) {
  message("Generating _exercise_theme.scss...\n")

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

  # Generate exercise-specific SCSS content
  exercise_scss_content <- c(
    "// This file is auto-generated from colors.json and fonts.json. Do not edit directly.",
    "// SSoQE Exercise Theme for HTML Documents",
    "",
    "/*-- scss:defaults --*/",
    "",
    "// Import Google Fonts",
    paste0('@import url("https://fonts.googleapis.com/css2?family=', gsub(" ", "+", fonts$body), ':wght@300;400;500;600;700&display=swap");'),
    paste0('@import url("https://fonts.googleapis.com/css2?family=', gsub(" ", "+", fonts$heading), ':wght@400;500;600;700&display=swap");'),
    paste0('@import url("https://fonts.googleapis.com/css2?family=', gsub(" ", "+", fonts$monospace), ':wght@400;500;600&display=swap");'),
    "",
    "// SSoQE Brand Colors",
    paste0("$black: ", colors$black, ";"),
    paste0("$white: ", colors$white, ";"),
    paste0("$midnightGreen: ", colors$midnightGreen, ";"),
    paste0("$persianGreen: ", colors$persianGreen, ";"),
    paste0("$cambridgeBlue: ", colors$cambridgeBlue, ";"),
    paste0("$satinSheenGold: ", colors$satinSheenGold, ";"),
    "",
    "// Semantic color mappings for HTML documents",
    "$body-color: $black !default;",
    "$body-bg: $white !default;",
    "$link-color: $persianGreen !default;",
    "$link-hover-color: darken($persianGreen, 15%) !default;",
    "$code-bg: lighten($cambridgeBlue, 35%) !default;",
    "$code-color: $black !default;",
    "$border-color: $cambridgeBlue !default;",
    "$table-border-color: $cambridgeBlue !default;",
    "$blockquote-border-color: $persianGreen !default;",
    "",
    "// Typography settings for HTML documents",
    paste0('$font-family-sans-serif: "', fonts$body, '", system-ui, -apple-system, "Segoe UI", Roboto, sans-serif !default;'),
    paste0('$headings-font-family: "', fonts$heading, '", system-ui, -apple-system, "Segoe UI", Roboto, sans-serif !default;'),
    paste0('$font-family-monospace: "', fonts$monospace, '", "SF Mono", Monaco, "Cascadia Code", "Roboto Mono", Consolas, "Courier New", monospace !default;'),
    "",
    "// Font sizes optimized for HTML reading",
    paste0("$font-size-base: ", fonts$htmlSizes$mainFontSize, " !default;"),
    paste0("$line-height-base: ", fonts$htmlSizes$bodyLineHeight, " !default;"),
    paste0("$headings-line-height: ", fonts$htmlSizes$headingLineHeight, " !default;"),
    "",
    "// Heading sizes for HTML documents",
    paste0("$h1-font-size: $font-size-base * ", gsub("em", "", fonts$htmlSizes$heading1Size), " !default;"),
    paste0("$h2-font-size: $font-size-base * ", gsub("em", "", fonts$htmlSizes$heading2Size), " !default;"),
    paste0("$h3-font-size: $font-size-base * ", gsub("em", "", fonts$htmlSizes$heading3Size), " !default;"),
    paste0("$h4-font-size: $font-size-base * ", gsub("em", "", fonts$htmlSizes$heading4Size), " !default;"),
    paste0("$h5-font-size: $font-size-base * ", gsub("em", "", fonts$htmlSizes$heading5Size), " !default;"),
    paste0("$h6-font-size: $font-size-base * ", gsub("em", "", fonts$htmlSizes$heading6Size), " !default;"),
    "",
    "// Font weights",
    paste0("$headings-font-weight: ", fonts$weights$headingFontWeight, " !default;"),
    paste0("$font-weight-normal: ", fonts$weights$bodyFontWeight, " !default;"),
    paste0("$font-weight-bold: ", fonts$weights$boldFontWeight, " !default;"),
    "",
    "// Layout settings",
    paste0("$content-max-width: ", fonts$htmlSizes$maxWidth, ";"),
    paste0("$block-margin: ", fonts$htmlSizes$blockMargin, ";"),
    paste0("$small-margin: ", fonts$htmlSizes$smallMargin, ";"),
    "",
    "// Spacing",
    "$headings-margin-bottom: $block-margin * 0.5 !default;",
    "$paragraph-margin-bottom: $block-margin !default;",
    "",
    "/*-- scss:rules --*/",
    "",
    "// Main content styling",
    "body {",
    "  font-family: $font-family-sans-serif;",
    "  font-size: $font-size-base;",
    "  line-height: $line-height-base;",
    "  color: $body-color;",
    "  background-color: $body-bg;",
    "}",
    "",
    "// Content width constraint",
    ".quarto-container {",
    "  max-width: $content-max-width;",
    "}",
    "",
    "// Heading styles with SSoQE brand colors",
    "h1, .h1 {",
    "  color: $midnightGreen;",
    "  font-family: $headings-font-family;",
    "  font-weight: $headings-font-weight;",
    "  line-height: $headings-line-height;",
    "  margin-bottom: $headings-margin-bottom;",
    "}",
    "",
    "h2, .h2 {",
    "  color: $persianGreen;",
    "  font-family: $headings-font-family;",
    "  font-weight: $headings-font-weight;",
    "  line-height: $headings-line-height;",
    "  margin-bottom: $headings-margin-bottom;",
    "}",
    "",
    "h3, .h3 {",
    "  color: $midnightGreen;",
    "  font-family: $headings-font-family;",
    "  font-weight: $headings-font-weight;",
    "  line-height: $headings-line-height;",
    "  margin-bottom: $headings-margin-bottom;",
    "}",
    "",
    "h4, .h4, h5, .h5, h6, .h6 {",
    "  color: $black;",
    "  font-family: $headings-font-family;",
    "  font-weight: $headings-font-weight;",
    "  line-height: $headings-line-height;",
    "  margin-bottom: $headings-margin-bottom;",
    "}",
    "",
    "// Link styling",
    "a {",
    "  color: $link-color;",
    "  text-decoration: none;",
    "  transition: color 0.2s ease;",
    "",
    "  &:hover {",
    "    color: $link-hover-color;",
    "    text-decoration: underline;",
    "  }",
    "}",
    "",
    "// Code styling",
    "code {",
    "  background-color: $code-bg;",
    "  color: $code-color;",
    "  font-family: $font-family-monospace;",
    "  padding: 0.125rem 0.25rem;",
    "  border-radius: 0.25rem;",
    "  font-size: 0.875em;",
    "}",
    "",
    "pre {",
    "  background-color: $code-bg;",
    "  border: 1px solid $border-color;",
    "  border-radius: 0.375rem;",
    "  padding: 1rem;",
    "  margin-bottom: $block-margin;",
    "",
    "  code {",
    "    background-color: transparent;",
    "    border: none;",
    "    padding: 0;",
    "    font-size: 0.875rem;",
    "  }",
    "}",
    "",
    "// Blockquote styling",
    "blockquote {",
    "  border-left: 4px solid $blockquote-border-color;",
    "  padding-left: 1rem;",
    "  margin-left: 0;",
    "  margin-bottom: $block-margin;",
    "  color: lighten($body-color, 20%);",
    "  font-style: italic;",
    "}",
    "",
    "// Table styling",
    "table {",
    "  border-collapse: collapse;",
    "  margin-bottom: $block-margin;",
    "  width: 100%;",
    "",
    "  th, td {",
    "    border: 1px solid $table-border-color;",
    "    padding: 0.5rem;",
    "    text-align: left;",
    "  }",
    "",
    "  th {",
    "    background-color: lighten($cambridgeBlue, 30%);",
    "    color: $midnightGreen;",
    "    font-weight: $headings-font-weight;",
    "  }",
    "",
    "  tr:nth-child(even) {",
    "    background-color: lighten($cambridgeBlue, 40%);",
    "  }",
    "}",
    "",
    "// Utility classes for SSoQE brand colors",
    ".text-midnight-green { color: $midnightGreen !important; }",
    ".text-persian-green { color: $persianGreen !important; }",
    ".text-cambridge-blue { color: $cambridgeBlue !important; }",
    ".text-satin-sheen-gold { color: $satinSheenGold !important; }",
    "",
    ".bg-midnight-green { background-color: $midnightGreen !important; }",
    ".bg-persian-green { background-color: $persianGreen !important; }",
    ".bg-cambridge-blue { background-color: $cambridgeBlue !important; }",
    ".bg-satin-sheen-gold { background-color: $satinSheenGold !important; }",
    "",
    "// Responsive adjustments",
    "@media (max-width: 768px) {",
    "  .quarto-container {",
    "    max-width: 100%;",
    "    padding: 0 1rem;",
    "  }",
    "",
    "  h1, .h1 { font-size: 1.75rem; }",
    "  h2, .h2 { font-size: 1.5rem; }",
    "  h3, .h3 { font-size: 1.25rem; }",
    "}"
  )

  # Write to _exercise_theme.scss
  writeLines(
    text = exercise_scss_content,
    con = output_file
  )

  message("_exercise_theme.scss generated successfully\n")
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
    generate_exercise_scss()
    generate_r_theme()

    message("\nTheme generation completed successfully!\n")
    message("Generated files:\n")
    message("  - _colors.scss\n")
    message("  - _fonts.scss\n")
    message("  - fonts-include.html\n")
    message("  - R/Exercises/_exercise_theme.scss\n")
    message("  - R/set_r_theme.R\n")
  },
  error = function(e) {
    message("\nError during theme generation:\n")
    message(paste("Error:", e$message, "\n"))
    quit(status = 1)
  }
)
