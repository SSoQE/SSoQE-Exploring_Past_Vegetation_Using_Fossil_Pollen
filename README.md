# Workshop "Neotoma - basics"

The presentation and materials for a workshop "Neotoma - basics" for PalaeOpen Prague 2025.

## Presentation

This workshop has a build-in presentation, which is accessible in `Presentation/presentation.html` file. The presentation is built using [Quarto](https://quarto.org/) and can be rendered by running the `Presentation/render.R` script.

## Structure and content

```plaintext
├─ Data
|   ├─ Input
|   ├─ Processed
|   └─ Temp
├─ docs
|   ├─ presentation_files
|   └─ index.html
├─ Presentation
|   ├─ .gitignore
|   ├─ color_palette.png
|   ├─ custom_theme.scss
|   ├─ presentation.qmd
|   └─ render.R
├─ R
|   ├─ ___Init_project___.R
|   ├─ 00_Config_file.R
|   ├─ Exercises
|   ├─ Functions
|   └─ Project
├─ renv
|   ├─ activate.R
|   ├─ library
|   └─ settings.json
├─ .gitignore
├─ .Rprofile
├─ Workshop-neotoma-basic-20250704.Rproj
├─ LICENSE
├─ README.md
└─ renv.lock
```

## Setup

### Getting the repo

The project is accessible in two ways:
  
1. Use can download the latest [Release](https://github.com/PalaeOpen/Workshop-neotoma-basic-20250704/releases) of the Workflow as a zip file.
2. If a user has a [GitHub account](https://github.com/) and can use [git](https://git-scm.com/), the easiest way is to [clone the repo](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository).

### Set up R project

Once a user obtains their version of the project, there are several steps to be done before using it:

* Update [R](https://en.wikipedia.org/wiki/R_(programming_language)) and [R-studio IDE](https://posit.co/products/open-source/rstudio/). There are many guides on how to do so (e.g. [here](https://jennhuck.github.io/workshops/install_update_R.html))
* Execute all individual steps with the `R/___Init_project___.R` script. This will result in the preparation of all R-packages using the [`{renv}` package](https://rstudio.github.io/renv/articles/renv.html), which is an R dependency management of your projects. Mainly it will install [`{RUtilpol}`](https://github.com/HOPE-UIB-BIO/R-Utilpol-package) and all dependencies. `{RUtilpol}` is used throughout the project as a version control of files.
* Set up your preferences by editing the The Config file in `R/00_Config_file.R` script. The Config file is a script where all settings (configurations) and criteria used throughout the project are predefined by the user before running individual scripts. In addition, it prepares the current session by loading the required packages and saving all settings throughout the project
