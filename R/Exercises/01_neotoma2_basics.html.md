---
format:
  html:
    author: "Ondřej Mottl"
    toc: true
    keep-md: true
    code-link: true
    embed-resources: true
    code-line-numbers: true
    theme: [default, custom_theme_exercise.scss]
---



# Basic functions of neotoma2 : Working with pollen data

Simple example of woking with pollen data using the [{neotoma2} package](https://open.neotomadb.org/neotoma2/).

## Setup


::: {.cell}

```{.r .cell-code}
# load libraries
library(tidyverse) # general data wrangling and visualisation
library(tinytable) # nice tables
library(neotoma2) # obtain data from the Neotoma database
library(janitor) # string cleaning
library(here) # file paths

# set the working directory
here::i_am("R/Exercises/01_neotoma2_basics.qmd")

# source the config file
source(
  here::here("R/00_Confiq_file.R")
)

# quarto render options
options(htmltools.dir.version = FALSE)
knitr::opts_chunk$set(
  fig.width = 7,
  fig.height = 5,
  fig.align = "center",
  out.width = "100%",
  echo = TRUE
)

# Helper function to plot tables
plot_table <- function(data_source, head = FALSE) {
  data_frame <-
    data_source %>%
    as.data.frame()

  if (
    "description" %in% colnames(data_frame) |
      "notes" %in% colnames(data_frame)
  ) {
    data_frame <-
      data_frame %>%
      dplyr::select(
        !dplyr::any_of(c("description", "notes"))
      )
  }

  if (
    isTRUE(head)
  ) {
    data_frame <-
      head(data_frame)
  }

  data_frame %>%
    tinytable::tt()
}
```
:::


## Sites

### Search by IDs

Search for site by a single numeric ID:

::: {.cell layout-align="center"}

```{.r .cell-code}
neotoma2::get_sites(15799) %>% 
  plot_table()
```

::: {.cell-output-display}


```{=html}
<!-- preamble start -->

    <script>
      function styleCell_lyf2l9lo2ipm5j6v5qb7(i, j, css_id) {
        var table = document.getElementById("tinytable_lyf2l9lo2ipm5j6v5qb7");
        table.rows[i].cells[j].classList.add(css_id);
      }
      function insertSpanRow(i, colspan, content) {
        var table = document.getElementById('tinytable_lyf2l9lo2ipm5j6v5qb7');
        var newRow = table.insertRow(i);
        var newCell = newRow.insertCell(0);
        newCell.setAttribute("colspan", colspan);
        // newCell.innerText = content;
        // this may be unsafe, but innerText does not interpret <br>
        newCell.innerHTML = content;
      }
      function spanCell_lyf2l9lo2ipm5j6v5qb7(i, j, rowspan, colspan) {
        var table = document.getElementById("tinytable_lyf2l9lo2ipm5j6v5qb7");
        const targetRow = table.rows[i];
        const targetCell = targetRow.cells[j];
        for (let r = 0; r < rowspan; r++) {
          // Only start deleting cells to the right for the first row (r == 0)
          if (r === 0) {
            // Delete cells to the right of the target cell in the first row
            for (let c = colspan - 1; c > 0; c--) {
              if (table.rows[i + r].cells[j + c]) {
                table.rows[i + r].deleteCell(j + c);
              }
            }
          }
          // For rows below the first, delete starting from the target column
          if (r > 0) {
            for (let c = colspan - 1; c >= 0; c--) {
              if (table.rows[i + r] && table.rows[i + r].cells[j]) {
                table.rows[i + r].deleteCell(j);
              }
            }
          }
        }
        // Set rowspan and colspan of the target cell
        targetCell.rowSpan = rowspan;
        targetCell.colSpan = colspan;
      }
window.addEventListener('load', function () { styleCell_lyf2l9lo2ipm5j6v5qb7(0, 0, 'tinytable_css_idvgoy1t9lyof8jbg2lhti') })
window.addEventListener('load', function () { styleCell_lyf2l9lo2ipm5j6v5qb7(0, 1, 'tinytable_css_idvgoy1t9lyof8jbg2lhti') })
window.addEventListener('load', function () { styleCell_lyf2l9lo2ipm5j6v5qb7(0, 2, 'tinytable_css_idvgoy1t9lyof8jbg2lhti') })
window.addEventListener('load', function () { styleCell_lyf2l9lo2ipm5j6v5qb7(0, 3, 'tinytable_css_idvgoy1t9lyof8jbg2lhti') })
window.addEventListener('load', function () { styleCell_lyf2l9lo2ipm5j6v5qb7(0, 4, 'tinytable_css_idvgoy1t9lyof8jbg2lhti') })
window.addEventListener('load', function () { styleCell_lyf2l9lo2ipm5j6v5qb7(0, 5, 'tinytable_css_idvgoy1t9lyof8jbg2lhti') })
    </script>

    <style>
    .table td.tinytable_css_idvgoy1t9lyof8jbg2lhti, .table th.tinytable_css_idvgoy1t9lyof8jbg2lhti {  border-bottom: solid 0.1em #d3d8dc; }
    </style>
    <div class="container">
      <table class="table table-borderless" id="tinytable_lyf2l9lo2ipm5j6v5qb7" style="width: auto; margin-left: auto; margin-right: auto;" data-quarto-disable-processing='true'>
        <thead>
        
              <tr>
                <th scope="col">siteid</th>
                <th scope="col">sitename</th>
                <th scope="col">lat</th>
                <th scope="col">long</th>
                <th scope="col">area</th>
                <th scope="col">elev</th>
              </tr>
        </thead>
        
        <tbody>
                <tr>
                  <td>15799</td>
                  <td>Kulzer Moos</td>
                  <td>49.3912</td>
                  <td>12.4482</td>
                  <td>NA</td>
                  <td>466</td>
                </tr>
        </tbody>
      </table>
    </div>
<!-- hack to avoid NA insertion in last line -->
```


:::
:::


Search for sites with multiple IDs:

::: {.cell layout-align="center"}

```{.r .cell-code}
neotoma2::get_sites(
  c(15799, 15683)
) %>% 
  plot_table()
```

::: {.cell-output-display}


```{=html}
<!-- preamble start -->

    <script>
      function styleCell_lcqhmu1nodavrwwvek9x(i, j, css_id) {
        var table = document.getElementById("tinytable_lcqhmu1nodavrwwvek9x");
        table.rows[i].cells[j].classList.add(css_id);
      }
      function insertSpanRow(i, colspan, content) {
        var table = document.getElementById('tinytable_lcqhmu1nodavrwwvek9x');
        var newRow = table.insertRow(i);
        var newCell = newRow.insertCell(0);
        newCell.setAttribute("colspan", colspan);
        // newCell.innerText = content;
        // this may be unsafe, but innerText does not interpret <br>
        newCell.innerHTML = content;
      }
      function spanCell_lcqhmu1nodavrwwvek9x(i, j, rowspan, colspan) {
        var table = document.getElementById("tinytable_lcqhmu1nodavrwwvek9x");
        const targetRow = table.rows[i];
        const targetCell = targetRow.cells[j];
        for (let r = 0; r < rowspan; r++) {
          // Only start deleting cells to the right for the first row (r == 0)
          if (r === 0) {
            // Delete cells to the right of the target cell in the first row
            for (let c = colspan - 1; c > 0; c--) {
              if (table.rows[i + r].cells[j + c]) {
                table.rows[i + r].deleteCell(j + c);
              }
            }
          }
          // For rows below the first, delete starting from the target column
          if (r > 0) {
            for (let c = colspan - 1; c >= 0; c--) {
              if (table.rows[i + r] && table.rows[i + r].cells[j]) {
                table.rows[i + r].deleteCell(j);
              }
            }
          }
        }
        // Set rowspan and colspan of the target cell
        targetCell.rowSpan = rowspan;
        targetCell.colSpan = colspan;
      }
window.addEventListener('load', function () { styleCell_lcqhmu1nodavrwwvek9x(0, 0, 'tinytable_css_id7fbmvezcdiw3ndu9ccqe') })
window.addEventListener('load', function () { styleCell_lcqhmu1nodavrwwvek9x(0, 1, 'tinytable_css_id7fbmvezcdiw3ndu9ccqe') })
window.addEventListener('load', function () { styleCell_lcqhmu1nodavrwwvek9x(0, 2, 'tinytable_css_id7fbmvezcdiw3ndu9ccqe') })
window.addEventListener('load', function () { styleCell_lcqhmu1nodavrwwvek9x(0, 3, 'tinytable_css_id7fbmvezcdiw3ndu9ccqe') })
window.addEventListener('load', function () { styleCell_lcqhmu1nodavrwwvek9x(0, 4, 'tinytable_css_id7fbmvezcdiw3ndu9ccqe') })
window.addEventListener('load', function () { styleCell_lcqhmu1nodavrwwvek9x(0, 5, 'tinytable_css_id7fbmvezcdiw3ndu9ccqe') })
    </script>

    <style>
    .table td.tinytable_css_id7fbmvezcdiw3ndu9ccqe, .table th.tinytable_css_id7fbmvezcdiw3ndu9ccqe {  border-bottom: solid 0.1em #d3d8dc; }
    </style>
    <div class="container">
      <table class="table table-borderless" id="tinytable_lcqhmu1nodavrwwvek9x" style="width: auto; margin-left: auto; margin-right: auto;" data-quarto-disable-processing='true'>
        <thead>
        
              <tr>
                <th scope="col">siteid</th>
                <th scope="col">sitename</th>
                <th scope="col">lat</th>
                <th scope="col">long</th>
                <th scope="col">area</th>
                <th scope="col">elev</th>
              </tr>
        </thead>
        
        <tbody>
                <tr>
                  <td>15683</td>
                  <td>Windbruch  </td>
                  <td>49.60793</td>
                  <td>12.54137</td>
                  <td>NA</td>
                  <td>495</td>
                </tr>
                <tr>
                  <td>15799</td>
                  <td>Kulzer Moos</td>
                  <td>49.39120</td>
                  <td>12.44820</td>
                  <td>NA</td>
                  <td>466</td>
                </tr>
        </tbody>
      </table>
    </div>
<!-- hack to avoid NA insertion in last line -->
```


:::
:::


Searching for Sites by Name. Notet that  `%` is a wildcard character:


::: {.cell layout-align="center"}

```{.r .cell-code}
neotoma2::get_sites(sitename = "Alex%") %>% 
  plot_table()
```

::: {.cell-output-display}


```{=html}
<!-- preamble start -->

    <script>
      function styleCell_esth61iepfnkosp6v5wc(i, j, css_id) {
        var table = document.getElementById("tinytable_esth61iepfnkosp6v5wc");
        table.rows[i].cells[j].classList.add(css_id);
      }
      function insertSpanRow(i, colspan, content) {
        var table = document.getElementById('tinytable_esth61iepfnkosp6v5wc');
        var newRow = table.insertRow(i);
        var newCell = newRow.insertCell(0);
        newCell.setAttribute("colspan", colspan);
        // newCell.innerText = content;
        // this may be unsafe, but innerText does not interpret <br>
        newCell.innerHTML = content;
      }
      function spanCell_esth61iepfnkosp6v5wc(i, j, rowspan, colspan) {
        var table = document.getElementById("tinytable_esth61iepfnkosp6v5wc");
        const targetRow = table.rows[i];
        const targetCell = targetRow.cells[j];
        for (let r = 0; r < rowspan; r++) {
          // Only start deleting cells to the right for the first row (r == 0)
          if (r === 0) {
            // Delete cells to the right of the target cell in the first row
            for (let c = colspan - 1; c > 0; c--) {
              if (table.rows[i + r].cells[j + c]) {
                table.rows[i + r].deleteCell(j + c);
              }
            }
          }
          // For rows below the first, delete starting from the target column
          if (r > 0) {
            for (let c = colspan - 1; c >= 0; c--) {
              if (table.rows[i + r] && table.rows[i + r].cells[j]) {
                table.rows[i + r].deleteCell(j);
              }
            }
          }
        }
        // Set rowspan and colspan of the target cell
        targetCell.rowSpan = rowspan;
        targetCell.colSpan = colspan;
      }
window.addEventListener('load', function () { styleCell_esth61iepfnkosp6v5wc(0, 0, 'tinytable_css_iddberxdwq7stvk2uluw65') })
window.addEventListener('load', function () { styleCell_esth61iepfnkosp6v5wc(0, 1, 'tinytable_css_iddberxdwq7stvk2uluw65') })
window.addEventListener('load', function () { styleCell_esth61iepfnkosp6v5wc(0, 2, 'tinytable_css_iddberxdwq7stvk2uluw65') })
window.addEventListener('load', function () { styleCell_esth61iepfnkosp6v5wc(0, 3, 'tinytable_css_iddberxdwq7stvk2uluw65') })
window.addEventListener('load', function () { styleCell_esth61iepfnkosp6v5wc(0, 4, 'tinytable_css_iddberxdwq7stvk2uluw65') })
window.addEventListener('load', function () { styleCell_esth61iepfnkosp6v5wc(0, 5, 'tinytable_css_iddberxdwq7stvk2uluw65') })
    </script>

    <style>
    .table td.tinytable_css_iddberxdwq7stvk2uluw65, .table th.tinytable_css_iddberxdwq7stvk2uluw65 {  border-bottom: solid 0.1em #d3d8dc; }
    </style>
    <div class="container">
      <table class="table table-borderless" id="tinytable_esth61iepfnkosp6v5wc" style="width: auto; margin-left: auto; margin-right: auto;" data-quarto-disable-processing='true'>
        <thead>
        
              <tr>
                <th scope="col">siteid</th>
                <th scope="col">sitename</th>
                <th scope="col">lat</th>
                <th scope="col">long</th>
                <th scope="col">area</th>
                <th scope="col">elev</th>
              </tr>
        </thead>
        
        <tbody>
                <tr>
                  <td>24   </td>
                  <td>Alexander Lake    </td>
                  <td>53.33333</td>
                  <td>-60.58333</td>
                  <td>NA</td>
                  <td> 73</td>
                </tr>
                <tr>
                  <td>25   </td>
                  <td>Alexis Lake       </td>
                  <td>52.51667</td>
                  <td>-57.03333</td>
                  <td>NA</td>
                  <td>193</td>
                </tr>
                <tr>
                  <td>4478 </td>
                  <td>Alexander [3CN117]</td>
                  <td>35.25000</td>
                  <td>-92.61667</td>
                  <td>NA</td>
                  <td>180</td>
                </tr>
                <tr>
                  <td>26226</td>
                  <td>Alexandra Lake    </td>
                  <td>43.29030</td>
                  <td>-74.16966</td>
                  <td>NA</td>
                  <td>351</td>
                </tr>
        </tbody>
      </table>
    </div>
<!-- hack to avoid NA insertion in last line -->
```


:::
:::


### Searching for Sites by Age

Record span at least 8200 years:


::: {.cell layout-align="center"}

```{.r .cell-code}
neotoma2::get_sites(
  ageof = 8200,
  all_data = FALSE # this will only show 25 records
) %>% 
 plot_table(head = TRUE)
```

::: {.cell-output-display}


```{=html}
<!-- preamble start -->

    <script>
      function styleCell_bzq2wwfayglwjfsvv4um(i, j, css_id) {
        var table = document.getElementById("tinytable_bzq2wwfayglwjfsvv4um");
        table.rows[i].cells[j].classList.add(css_id);
      }
      function insertSpanRow(i, colspan, content) {
        var table = document.getElementById('tinytable_bzq2wwfayglwjfsvv4um');
        var newRow = table.insertRow(i);
        var newCell = newRow.insertCell(0);
        newCell.setAttribute("colspan", colspan);
        // newCell.innerText = content;
        // this may be unsafe, but innerText does not interpret <br>
        newCell.innerHTML = content;
      }
      function spanCell_bzq2wwfayglwjfsvv4um(i, j, rowspan, colspan) {
        var table = document.getElementById("tinytable_bzq2wwfayglwjfsvv4um");
        const targetRow = table.rows[i];
        const targetCell = targetRow.cells[j];
        for (let r = 0; r < rowspan; r++) {
          // Only start deleting cells to the right for the first row (r == 0)
          if (r === 0) {
            // Delete cells to the right of the target cell in the first row
            for (let c = colspan - 1; c > 0; c--) {
              if (table.rows[i + r].cells[j + c]) {
                table.rows[i + r].deleteCell(j + c);
              }
            }
          }
          // For rows below the first, delete starting from the target column
          if (r > 0) {
            for (let c = colspan - 1; c >= 0; c--) {
              if (table.rows[i + r] && table.rows[i + r].cells[j]) {
                table.rows[i + r].deleteCell(j);
              }
            }
          }
        }
        // Set rowspan and colspan of the target cell
        targetCell.rowSpan = rowspan;
        targetCell.colSpan = colspan;
      }
window.addEventListener('load', function () { styleCell_bzq2wwfayglwjfsvv4um(0, 0, 'tinytable_css_idab0pvr2w1fwnqznx6ifd') })
window.addEventListener('load', function () { styleCell_bzq2wwfayglwjfsvv4um(0, 1, 'tinytable_css_idab0pvr2w1fwnqznx6ifd') })
window.addEventListener('load', function () { styleCell_bzq2wwfayglwjfsvv4um(0, 2, 'tinytable_css_idab0pvr2w1fwnqznx6ifd') })
window.addEventListener('load', function () { styleCell_bzq2wwfayglwjfsvv4um(0, 3, 'tinytable_css_idab0pvr2w1fwnqznx6ifd') })
window.addEventListener('load', function () { styleCell_bzq2wwfayglwjfsvv4um(0, 4, 'tinytable_css_idab0pvr2w1fwnqznx6ifd') })
window.addEventListener('load', function () { styleCell_bzq2wwfayglwjfsvv4um(0, 5, 'tinytable_css_idab0pvr2w1fwnqznx6ifd') })
    </script>

    <style>
    .table td.tinytable_css_idab0pvr2w1fwnqznx6ifd, .table th.tinytable_css_idab0pvr2w1fwnqznx6ifd {  border-bottom: solid 0.1em #d3d8dc; }
    </style>
    <div class="container">
      <table class="table table-borderless" id="tinytable_bzq2wwfayglwjfsvv4um" style="width: auto; margin-left: auto; margin-right: auto;" data-quarto-disable-processing='true'>
        <thead>
        
              <tr>
                <th scope="col">siteid</th>
                <th scope="col">sitename</th>
                <th scope="col">lat</th>
                <th scope="col">long</th>
                <th scope="col">area</th>
                <th scope="col">elev</th>
              </tr>
        </thead>
        
        <tbody>
                <tr>
                  <td>11</td>
                  <td>Konus Exposure, Adycha River</td>
                  <td> 67.75000</td>
                  <td>135.58333</td>
                  <td>NA</td>
                  <td> 137</td>
                </tr>
                <tr>
                  <td>12</td>
                  <td>Ageröds Mosse               </td>
                  <td> 55.93329</td>
                  <td> 13.42559</td>
                  <td>NA</td>
                  <td>  47</td>
                </tr>
                <tr>
                  <td>15</td>
                  <td>Aguilar                     </td>
                  <td>-23.83333</td>
                  <td>-65.75000</td>
                  <td>NA</td>
                  <td>3828</td>
                </tr>
                <tr>
                  <td>19</td>
                  <td>Akulinin Exposure P1282     </td>
                  <td> 47.11667</td>
                  <td>138.55000</td>
                  <td>NA</td>
                  <td> 367</td>
                </tr>
                <tr>
                  <td>20</td>
                  <td>Akuvaara                    </td>
                  <td> 69.12326</td>
                  <td> 27.67406</td>
                  <td>NA</td>
                  <td> 159</td>
                </tr>
                <tr>
                  <td>25</td>
                  <td>Alexis Lake                 </td>
                  <td> 52.51667</td>
                  <td>-57.03333</td>
                  <td>NA</td>
                  <td> 193</td>
                </tr>
        </tbody>
      </table>
    </div>
<!-- hack to avoid NA insertion in last line -->
```


:::
:::


Record must PARTLY span the age range


::: {.cell layout-align="center"}

```{.r .cell-code}
neotoma2::get_sites(
  minage = 5000,
  maxage = 8000,
  all_data = FALSE # this will only show 
) %>% 
 plot_table(head = TRUE)
```

::: {.cell-output-display}


```{=html}
<!-- preamble start -->

    <script>
      function styleCell_4lsyopf3r8qwwog7q7cs(i, j, css_id) {
        var table = document.getElementById("tinytable_4lsyopf3r8qwwog7q7cs");
        table.rows[i].cells[j].classList.add(css_id);
      }
      function insertSpanRow(i, colspan, content) {
        var table = document.getElementById('tinytable_4lsyopf3r8qwwog7q7cs');
        var newRow = table.insertRow(i);
        var newCell = newRow.insertCell(0);
        newCell.setAttribute("colspan", colspan);
        // newCell.innerText = content;
        // this may be unsafe, but innerText does not interpret <br>
        newCell.innerHTML = content;
      }
      function spanCell_4lsyopf3r8qwwog7q7cs(i, j, rowspan, colspan) {
        var table = document.getElementById("tinytable_4lsyopf3r8qwwog7q7cs");
        const targetRow = table.rows[i];
        const targetCell = targetRow.cells[j];
        for (let r = 0; r < rowspan; r++) {
          // Only start deleting cells to the right for the first row (r == 0)
          if (r === 0) {
            // Delete cells to the right of the target cell in the first row
            for (let c = colspan - 1; c > 0; c--) {
              if (table.rows[i + r].cells[j + c]) {
                table.rows[i + r].deleteCell(j + c);
              }
            }
          }
          // For rows below the first, delete starting from the target column
          if (r > 0) {
            for (let c = colspan - 1; c >= 0; c--) {
              if (table.rows[i + r] && table.rows[i + r].cells[j]) {
                table.rows[i + r].deleteCell(j);
              }
            }
          }
        }
        // Set rowspan and colspan of the target cell
        targetCell.rowSpan = rowspan;
        targetCell.colSpan = colspan;
      }
window.addEventListener('load', function () { styleCell_4lsyopf3r8qwwog7q7cs(0, 0, 'tinytable_css_id45ev7e23pwv9mpl3qqju') })
window.addEventListener('load', function () { styleCell_4lsyopf3r8qwwog7q7cs(0, 1, 'tinytable_css_id45ev7e23pwv9mpl3qqju') })
window.addEventListener('load', function () { styleCell_4lsyopf3r8qwwog7q7cs(0, 2, 'tinytable_css_id45ev7e23pwv9mpl3qqju') })
window.addEventListener('load', function () { styleCell_4lsyopf3r8qwwog7q7cs(0, 3, 'tinytable_css_id45ev7e23pwv9mpl3qqju') })
window.addEventListener('load', function () { styleCell_4lsyopf3r8qwwog7q7cs(0, 4, 'tinytable_css_id45ev7e23pwv9mpl3qqju') })
window.addEventListener('load', function () { styleCell_4lsyopf3r8qwwog7q7cs(0, 5, 'tinytable_css_id45ev7e23pwv9mpl3qqju') })
    </script>

    <style>
    .table td.tinytable_css_id45ev7e23pwv9mpl3qqju, .table th.tinytable_css_id45ev7e23pwv9mpl3qqju {  border-bottom: solid 0.1em #d3d8dc; }
    </style>
    <div class="container">
      <table class="table table-borderless" id="tinytable_4lsyopf3r8qwwog7q7cs" style="width: auto; margin-left: auto; margin-right: auto;" data-quarto-disable-processing='true'>
        <thead>
        
              <tr>
                <th scope="col">siteid</th>
                <th scope="col">sitename</th>
                <th scope="col">lat</th>
                <th scope="col">long</th>
                <th scope="col">area</th>
                <th scope="col">elev</th>
              </tr>
        </thead>
        
        <tbody>
                <tr>
                  <td>7 </td>
                  <td>Three Pines Bog             </td>
                  <td> 47.00000</td>
                  <td> -80.11667</td>
                  <td>NA</td>
                  <td> 329</td>
                </tr>
                <tr>
                  <td>8 </td>
                  <td>Abalone Rocks Marsh         </td>
                  <td> 33.95639</td>
                  <td>-119.97667</td>
                  <td>NA</td>
                  <td>   9</td>
                </tr>
                <tr>
                  <td>9 </td>
                  <td>Adange                      </td>
                  <td> 43.30556</td>
                  <td>  41.33333</td>
                  <td>NA</td>
                  <td>2065</td>
                </tr>
                <tr>
                  <td>11</td>
                  <td>Konus Exposure, Adycha River</td>
                  <td> 67.75000</td>
                  <td> 135.58333</td>
                  <td>NA</td>
                  <td> 137</td>
                </tr>
                <tr>
                  <td>12</td>
                  <td>Ageröds Mosse               </td>
                  <td> 55.93329</td>
                  <td>  13.42559</td>
                  <td>NA</td>
                  <td>  47</td>
                </tr>
                <tr>
                  <td>15</td>
                  <td>Aguilar                     </td>
                  <td>-23.83333</td>
                  <td> -65.75000</td>
                  <td>NA</td>
                  <td>3828</td>
                </tr>
        </tbody>
      </table>
    </div>
<!-- hack to avoid NA insertion in last line -->
```


:::
:::


Record must COMPLETELY span the age range


::: {.cell layout-align="center"}

```{.r .cell-code}
neotoma2::get_sites(
  ageyounger = 5000,
  ageolder = 8000,
  all_data = FALSE # this will only show 25 records
) %>% 
 plot_table(head = TRUE)
```

::: {.cell-output-display}


```{=html}
<!-- preamble start -->

    <script>
      function styleCell_rtcv1md7s1635rt167gs(i, j, css_id) {
        var table = document.getElementById("tinytable_rtcv1md7s1635rt167gs");
        table.rows[i].cells[j].classList.add(css_id);
      }
      function insertSpanRow(i, colspan, content) {
        var table = document.getElementById('tinytable_rtcv1md7s1635rt167gs');
        var newRow = table.insertRow(i);
        var newCell = newRow.insertCell(0);
        newCell.setAttribute("colspan", colspan);
        // newCell.innerText = content;
        // this may be unsafe, but innerText does not interpret <br>
        newCell.innerHTML = content;
      }
      function spanCell_rtcv1md7s1635rt167gs(i, j, rowspan, colspan) {
        var table = document.getElementById("tinytable_rtcv1md7s1635rt167gs");
        const targetRow = table.rows[i];
        const targetCell = targetRow.cells[j];
        for (let r = 0; r < rowspan; r++) {
          // Only start deleting cells to the right for the first row (r == 0)
          if (r === 0) {
            // Delete cells to the right of the target cell in the first row
            for (let c = colspan - 1; c > 0; c--) {
              if (table.rows[i + r].cells[j + c]) {
                table.rows[i + r].deleteCell(j + c);
              }
            }
          }
          // For rows below the first, delete starting from the target column
          if (r > 0) {
            for (let c = colspan - 1; c >= 0; c--) {
              if (table.rows[i + r] && table.rows[i + r].cells[j]) {
                table.rows[i + r].deleteCell(j);
              }
            }
          }
        }
        // Set rowspan and colspan of the target cell
        targetCell.rowSpan = rowspan;
        targetCell.colSpan = colspan;
      }
window.addEventListener('load', function () { styleCell_rtcv1md7s1635rt167gs(0, 0, 'tinytable_css_idly8w3lgqbfjrahyn2td8') })
window.addEventListener('load', function () { styleCell_rtcv1md7s1635rt167gs(0, 1, 'tinytable_css_idly8w3lgqbfjrahyn2td8') })
window.addEventListener('load', function () { styleCell_rtcv1md7s1635rt167gs(0, 2, 'tinytable_css_idly8w3lgqbfjrahyn2td8') })
window.addEventListener('load', function () { styleCell_rtcv1md7s1635rt167gs(0, 3, 'tinytable_css_idly8w3lgqbfjrahyn2td8') })
window.addEventListener('load', function () { styleCell_rtcv1md7s1635rt167gs(0, 4, 'tinytable_css_idly8w3lgqbfjrahyn2td8') })
window.addEventListener('load', function () { styleCell_rtcv1md7s1635rt167gs(0, 5, 'tinytable_css_idly8w3lgqbfjrahyn2td8') })
    </script>

    <style>
    .table td.tinytable_css_idly8w3lgqbfjrahyn2td8, .table th.tinytable_css_idly8w3lgqbfjrahyn2td8 {  border-bottom: solid 0.1em #d3d8dc; }
    </style>
    <div class="container">
      <table class="table table-borderless" id="tinytable_rtcv1md7s1635rt167gs" style="width: auto; margin-left: auto; margin-right: auto;" data-quarto-disable-processing='true'>
        <thead>
        
              <tr>
                <th scope="col">siteid</th>
                <th scope="col">sitename</th>
                <th scope="col">lat</th>
                <th scope="col">long</th>
                <th scope="col">area</th>
                <th scope="col">elev</th>
              </tr>
        </thead>
        
        <tbody>
                <tr>
                  <td>1</td>
                  <td>15/1</td>
                  <td>55.09167</td>
                  <td>-75.25000</td>
                  <td>NA</td>
                  <td>244</td>
                </tr>
                <tr>
                  <td>2</td>
                  <td>15/2</td>
                  <td>55.83333</td>
                  <td>-75.01667</td>
                  <td>NA</td>
                  <td>261</td>
                </tr>
                <tr>
                  <td>3</td>
                  <td>16/1</td>
                  <td>55.41333</td>
                  <td>-75.06667</td>
                  <td>NA</td>
                  <td>290</td>
                </tr>
                <tr>
                  <td>4</td>
                  <td>17/1</td>
                  <td>55.06667</td>
                  <td>-75.70000</td>
                  <td>NA</td>
                  <td>235</td>
                </tr>
                <tr>
                  <td>5</td>
                  <td>17/2</td>
                  <td>55.25000</td>
                  <td>-74.93333</td>
                  <td>NA</td>
                  <td>300</td>
                </tr>
                <tr>
                  <td>6</td>
                  <td>17/3</td>
                  <td>55.11667</td>
                  <td>-75.95000</td>
                  <td>NA</td>
                  <td>278</td>
                </tr>
        </tbody>
      </table>
    </div>
<!-- hack to avoid NA insertion in last line -->
```


:::
:::


## Datasets

### Search by IDs


::: {.cell layout-align="center"}

```{.r .cell-code}
neotoma2::get_sites(
  c(15799, 15683)
) %>% 
  plot_table()
```

::: {.cell-output-display}


```{=html}
<!-- preamble start -->

    <script>
      function styleCell_am6g0tn76mazi0crnl3j(i, j, css_id) {
        var table = document.getElementById("tinytable_am6g0tn76mazi0crnl3j");
        table.rows[i].cells[j].classList.add(css_id);
      }
      function insertSpanRow(i, colspan, content) {
        var table = document.getElementById('tinytable_am6g0tn76mazi0crnl3j');
        var newRow = table.insertRow(i);
        var newCell = newRow.insertCell(0);
        newCell.setAttribute("colspan", colspan);
        // newCell.innerText = content;
        // this may be unsafe, but innerText does not interpret <br>
        newCell.innerHTML = content;
      }
      function spanCell_am6g0tn76mazi0crnl3j(i, j, rowspan, colspan) {
        var table = document.getElementById("tinytable_am6g0tn76mazi0crnl3j");
        const targetRow = table.rows[i];
        const targetCell = targetRow.cells[j];
        for (let r = 0; r < rowspan; r++) {
          // Only start deleting cells to the right for the first row (r == 0)
          if (r === 0) {
            // Delete cells to the right of the target cell in the first row
            for (let c = colspan - 1; c > 0; c--) {
              if (table.rows[i + r].cells[j + c]) {
                table.rows[i + r].deleteCell(j + c);
              }
            }
          }
          // For rows below the first, delete starting from the target column
          if (r > 0) {
            for (let c = colspan - 1; c >= 0; c--) {
              if (table.rows[i + r] && table.rows[i + r].cells[j]) {
                table.rows[i + r].deleteCell(j);
              }
            }
          }
        }
        // Set rowspan and colspan of the target cell
        targetCell.rowSpan = rowspan;
        targetCell.colSpan = colspan;
      }
window.addEventListener('load', function () { styleCell_am6g0tn76mazi0crnl3j(0, 0, 'tinytable_css_idia9vcrlgop0fwipuv2un') })
window.addEventListener('load', function () { styleCell_am6g0tn76mazi0crnl3j(0, 1, 'tinytable_css_idia9vcrlgop0fwipuv2un') })
window.addEventListener('load', function () { styleCell_am6g0tn76mazi0crnl3j(0, 2, 'tinytable_css_idia9vcrlgop0fwipuv2un') })
window.addEventListener('load', function () { styleCell_am6g0tn76mazi0crnl3j(0, 3, 'tinytable_css_idia9vcrlgop0fwipuv2un') })
window.addEventListener('load', function () { styleCell_am6g0tn76mazi0crnl3j(0, 4, 'tinytable_css_idia9vcrlgop0fwipuv2un') })
window.addEventListener('load', function () { styleCell_am6g0tn76mazi0crnl3j(0, 5, 'tinytable_css_idia9vcrlgop0fwipuv2un') })
    </script>

    <style>
    .table td.tinytable_css_idia9vcrlgop0fwipuv2un, .table th.tinytable_css_idia9vcrlgop0fwipuv2un {  border-bottom: solid 0.1em #d3d8dc; }
    </style>
    <div class="container">
      <table class="table table-borderless" id="tinytable_am6g0tn76mazi0crnl3j" style="width: auto; margin-left: auto; margin-right: auto;" data-quarto-disable-processing='true'>
        <thead>
        
              <tr>
                <th scope="col">siteid</th>
                <th scope="col">sitename</th>
                <th scope="col">lat</th>
                <th scope="col">long</th>
                <th scope="col">area</th>
                <th scope="col">elev</th>
              </tr>
        </thead>
        
        <tbody>
                <tr>
                  <td>15683</td>
                  <td>Windbruch  </td>
                  <td>49.60793</td>
                  <td>12.54137</td>
                  <td>NA</td>
                  <td>495</td>
                </tr>
                <tr>
                  <td>15799</td>
                  <td>Kulzer Moos</td>
                  <td>49.39120</td>
                  <td>12.44820</td>
                  <td>NA</td>
                  <td>466</td>
                </tr>
        </tbody>
      </table>
    </div>
<!-- hack to avoid NA insertion in last line -->
```


:::
:::


### Search by type

::: {.cell layout-align="center"}

```{.r .cell-code}
neotoma2::get_sites(
  c(15799, 15683)
) %>% 
  plot_table()
```

::: {.cell-output-display}


```{=html}
<!-- preamble start -->

    <script>
      function styleCell_vhls7946okt3nx05h2v5(i, j, css_id) {
        var table = document.getElementById("tinytable_vhls7946okt3nx05h2v5");
        table.rows[i].cells[j].classList.add(css_id);
      }
      function insertSpanRow(i, colspan, content) {
        var table = document.getElementById('tinytable_vhls7946okt3nx05h2v5');
        var newRow = table.insertRow(i);
        var newCell = newRow.insertCell(0);
        newCell.setAttribute("colspan", colspan);
        // newCell.innerText = content;
        // this may be unsafe, but innerText does not interpret <br>
        newCell.innerHTML = content;
      }
      function spanCell_vhls7946okt3nx05h2v5(i, j, rowspan, colspan) {
        var table = document.getElementById("tinytable_vhls7946okt3nx05h2v5");
        const targetRow = table.rows[i];
        const targetCell = targetRow.cells[j];
        for (let r = 0; r < rowspan; r++) {
          // Only start deleting cells to the right for the first row (r == 0)
          if (r === 0) {
            // Delete cells to the right of the target cell in the first row
            for (let c = colspan - 1; c > 0; c--) {
              if (table.rows[i + r].cells[j + c]) {
                table.rows[i + r].deleteCell(j + c);
              }
            }
          }
          // For rows below the first, delete starting from the target column
          if (r > 0) {
            for (let c = colspan - 1; c >= 0; c--) {
              if (table.rows[i + r] && table.rows[i + r].cells[j]) {
                table.rows[i + r].deleteCell(j);
              }
            }
          }
        }
        // Set rowspan and colspan of the target cell
        targetCell.rowSpan = rowspan;
        targetCell.colSpan = colspan;
      }
window.addEventListener('load', function () { styleCell_vhls7946okt3nx05h2v5(0, 0, 'tinytable_css_idv7yuk1qhyxreehjvb8vv') })
window.addEventListener('load', function () { styleCell_vhls7946okt3nx05h2v5(0, 1, 'tinytable_css_idv7yuk1qhyxreehjvb8vv') })
window.addEventListener('load', function () { styleCell_vhls7946okt3nx05h2v5(0, 2, 'tinytable_css_idv7yuk1qhyxreehjvb8vv') })
window.addEventListener('load', function () { styleCell_vhls7946okt3nx05h2v5(0, 3, 'tinytable_css_idv7yuk1qhyxreehjvb8vv') })
window.addEventListener('load', function () { styleCell_vhls7946okt3nx05h2v5(0, 4, 'tinytable_css_idv7yuk1qhyxreehjvb8vv') })
window.addEventListener('load', function () { styleCell_vhls7946okt3nx05h2v5(0, 5, 'tinytable_css_idv7yuk1qhyxreehjvb8vv') })
    </script>

    <style>
    .table td.tinytable_css_idv7yuk1qhyxreehjvb8vv, .table th.tinytable_css_idv7yuk1qhyxreehjvb8vv {  border-bottom: solid 0.1em #d3d8dc; }
    </style>
    <div class="container">
      <table class="table table-borderless" id="tinytable_vhls7946okt3nx05h2v5" style="width: auto; margin-left: auto; margin-right: auto;" data-quarto-disable-processing='true'>
        <thead>
        
              <tr>
                <th scope="col">siteid</th>
                <th scope="col">sitename</th>
                <th scope="col">lat</th>
                <th scope="col">long</th>
                <th scope="col">area</th>
                <th scope="col">elev</th>
              </tr>
        </thead>
        
        <tbody>
                <tr>
                  <td>15683</td>
                  <td>Windbruch  </td>
                  <td>49.60793</td>
                  <td>12.54137</td>
                  <td>NA</td>
                  <td>495</td>
                </tr>
                <tr>
                  <td>15799</td>
                  <td>Kulzer Moos</td>
                  <td>49.39120</td>
                  <td>12.44820</td>
                  <td>NA</td>
                  <td>466</td>
                </tr>
        </tbody>
      </table>
    </div>
<!-- hack to avoid NA insertion in last line -->
```


:::
:::


### Search by geo location

Go to [geojson.io](https://geojson.io/) and get the coordinates of a polygon.


For example:

::: {.cell layout-align="center"}

```{.r .cell-code}
{
        "type": "FeatureCollection",
        "features": [
          {
            "type": "Feature",
            "properties": {},
            "geometry": {
              "coordinates": [
                [
                  [
                    8.885566596626347,
                    49.771446037909755
                  ],
                  [
                    10.222591262669596,
                    48.31793402541106
                  ],
                  [
                    12.353498585013057,
                    47.56711633708565
                  ],
                  [
                    16.327096438141012,
                    48.350003278892444
                  ],
                  [
                    16.435889807717132,
                    49.83389459390426
                  ],
                  [
                    16.022485237853516,
                    51.17135995959822
                  ],
                  [
                    14.214447964984942,
                    51.55099235084026
                  ],
                  [
                    10.091782211463311,
                    50.45895941972614
                  ],
                  [
                    9.223835080442456,
                    50.26942261795418
                  ],
                  [
                    8.885566596626347,
                    49.771446037909755
                  ]
                ]
              ],
              "type": "Polygon"
            }
          }
        ]
      }
```
:::


Now, we can use the coordinates to search for datasets:


::: {.cell layout-align="center"}

```{.r .cell-code}
sel_polygon <-
  geojsonsf::geojson_sf(
    '{
        "type": "FeatureCollection",
        "features": [
          {
            "type": "Feature",
            "properties": {},
            "geometry": {
              "coordinates": [
                [
                  [
                    8.885566596626347,
                    49.771446037909755
                  ],
                  [
                    10.222591262669596,
                    48.31793402541106
                  ],
                  [
                    12.353498585013057,
                    47.56711633708565
                  ],
                  [
                    16.327096438141012,
                    48.350003278892444
                  ],
                  [
                    16.435889807717132,
                    49.83389459390426
                  ],
                  [
                    16.022485237853516,
                    51.17135995959822
                  ],
                  [
                    14.214447964984942,
                    51.55099235084026
                  ],
                  [
                    10.091782211463311,
                    50.45895941972614
                  ],
                  [
                    9.223835080442456,
                    50.26942261795418
                  ],
                  [
                    8.885566596626347,
                    49.771446037909755
                  ]
                ]
              ],
              "type": "Polygon"
            }
          }
        ]
      }'
  )

neotoma2::get_datasets(
  loc = sel_polygon
) %>% 
 plot_table()
```

::: {.cell-output-display}


```{=html}
<!-- preamble start -->

    <script>
      function styleCell_4chrt62ogm4qruvc6hdo(i, j, css_id) {
        var table = document.getElementById("tinytable_4chrt62ogm4qruvc6hdo");
        table.rows[i].cells[j].classList.add(css_id);
      }
      function insertSpanRow(i, colspan, content) {
        var table = document.getElementById('tinytable_4chrt62ogm4qruvc6hdo');
        var newRow = table.insertRow(i);
        var newCell = newRow.insertCell(0);
        newCell.setAttribute("colspan", colspan);
        // newCell.innerText = content;
        // this may be unsafe, but innerText does not interpret <br>
        newCell.innerHTML = content;
      }
      function spanCell_4chrt62ogm4qruvc6hdo(i, j, rowspan, colspan) {
        var table = document.getElementById("tinytable_4chrt62ogm4qruvc6hdo");
        const targetRow = table.rows[i];
        const targetCell = targetRow.cells[j];
        for (let r = 0; r < rowspan; r++) {
          // Only start deleting cells to the right for the first row (r == 0)
          if (r === 0) {
            // Delete cells to the right of the target cell in the first row
            for (let c = colspan - 1; c > 0; c--) {
              if (table.rows[i + r].cells[j + c]) {
                table.rows[i + r].deleteCell(j + c);
              }
            }
          }
          // For rows below the first, delete starting from the target column
          if (r > 0) {
            for (let c = colspan - 1; c >= 0; c--) {
              if (table.rows[i + r] && table.rows[i + r].cells[j]) {
                table.rows[i + r].deleteCell(j);
              }
            }
          }
        }
        // Set rowspan and colspan of the target cell
        targetCell.rowSpan = rowspan;
        targetCell.colSpan = colspan;
      }
window.addEventListener('load', function () { styleCell_4chrt62ogm4qruvc6hdo(0, 0, 'tinytable_css_id9eau78nrai1nd3dcz71k') })
window.addEventListener('load', function () { styleCell_4chrt62ogm4qruvc6hdo(0, 1, 'tinytable_css_id9eau78nrai1nd3dcz71k') })
window.addEventListener('load', function () { styleCell_4chrt62ogm4qruvc6hdo(0, 2, 'tinytable_css_id9eau78nrai1nd3dcz71k') })
window.addEventListener('load', function () { styleCell_4chrt62ogm4qruvc6hdo(0, 3, 'tinytable_css_id9eau78nrai1nd3dcz71k') })
window.addEventListener('load', function () { styleCell_4chrt62ogm4qruvc6hdo(0, 4, 'tinytable_css_id9eau78nrai1nd3dcz71k') })
window.addEventListener('load', function () { styleCell_4chrt62ogm4qruvc6hdo(0, 5, 'tinytable_css_id9eau78nrai1nd3dcz71k') })
    </script>

    <style>
    .table td.tinytable_css_id9eau78nrai1nd3dcz71k, .table th.tinytable_css_id9eau78nrai1nd3dcz71k {  border-bottom: solid 0.1em #d3d8dc; }
    </style>
    <div class="container">
      <table class="table table-borderless" id="tinytable_4chrt62ogm4qruvc6hdo" style="width: auto; margin-left: auto; margin-right: auto;" data-quarto-disable-processing='true'>
        <thead>
        
              <tr>
                <th scope="col">siteid</th>
                <th scope="col">sitename</th>
                <th scope="col">lat</th>
                <th scope="col">long</th>
                <th scope="col">area</th>
                <th scope="col">elev</th>
              </tr>
        </thead>
        
        <tbody>
                <tr>
                  <td>1399</td>
                  <td>Kameničky        </td>
                  <td>49.72633</td>
                  <td>15.97060</td>
                  <td>NA</td>
                  <td>618</td>
                </tr>
                <tr>
                  <td>3152</td>
                  <td>Hroznotín        </td>
                  <td>49.75811</td>
                  <td>15.35538</td>
                  <td>NA</td>
                  <td>503</td>
                </tr>
                <tr>
                  <td>3168</td>
                  <td>Spolí            </td>
                  <td>48.98535</td>
                  <td>14.70859</td>
                  <td>NA</td>
                  <td>446</td>
                </tr>
                <tr>
                  <td>3169</td>
                  <td>Velanská cesta   </td>
                  <td>48.77444</td>
                  <td>14.92716</td>
                  <td>NA</td>
                  <td>494</td>
                </tr>
                <tr>
                  <td>3172</td>
                  <td>Branná           </td>
                  <td>48.95542</td>
                  <td>14.80408</td>
                  <td>NA</td>
                  <td>434</td>
                </tr>
                <tr>
                  <td>3173</td>
                  <td>Barbora          </td>
                  <td>48.94240</td>
                  <td>14.80709</td>
                  <td>NA</td>
                  <td>435</td>
                </tr>
                <tr>
                  <td>3175</td>
                  <td>Jestřebské blato </td>
                  <td>50.60157</td>
                  <td>14.60999</td>
                  <td>NA</td>
                  <td>244</td>
                </tr>
                <tr>
                  <td>3021</td>
                  <td>Bláto            </td>
                  <td>49.04174</td>
                  <td>15.19097</td>
                  <td>NA</td>
                  <td>649</td>
                </tr>
                <tr>
                  <td>3052</td>
                  <td>Chraňbož         </td>
                  <td>49.76853</td>
                  <td>15.37287</td>
                  <td>NA</td>
                  <td>469</td>
                </tr>
                <tr>
                  <td>3170</td>
                  <td>Červené blato    </td>
                  <td>48.86363</td>
                  <td>14.79583</td>
                  <td>NA</td>
                  <td>475</td>
                </tr>
                <tr>
                  <td>3171</td>
                  <td>Borkovická blata </td>
                  <td>49.23226</td>
                  <td>14.62157</td>
                  <td>NA</td>
                  <td>415</td>
                </tr>
                <tr>
                  <td>3174</td>
                  <td>Švarcenberk      </td>
                  <td>49.14399</td>
                  <td>14.70340</td>
                  <td>NA</td>
                  <td>416</td>
                </tr>
                <tr>
                  <td>3201</td>
                  <td>Komořanské jezero</td>
                  <td>50.53839</td>
                  <td>13.52740</td>
                  <td>NA</td>
                  <td>172</td>
                </tr>
        </tbody>
      </table>
    </div>
<!-- hack to avoid NA insertion in last line -->
```


:::
:::


### Filter

You can additionaly filter the compilation based on `lat`, `long`, `altitude`, `datasettype`, `age_range_young`, and/or `age_range_old`


::: {.cell layout-align="center"}

```{.r .cell-code}
neotoma2::get_datasets(
  loc = sel_polygon
) %>%
  neotoma2::filter(
    datasettype == "pollen" &
      altitude > 500 &
      age_range_young <= 1e3
  ) %>% 
 plot_table()
```

::: {.cell-output-display}


```{=html}
<!-- preamble start -->

    <script>
      function styleCell_4t9ik0byf5bqopam5tov(i, j, css_id) {
        var table = document.getElementById("tinytable_4t9ik0byf5bqopam5tov");
        table.rows[i].cells[j].classList.add(css_id);
      }
      function insertSpanRow(i, colspan, content) {
        var table = document.getElementById('tinytable_4t9ik0byf5bqopam5tov');
        var newRow = table.insertRow(i);
        var newCell = newRow.insertCell(0);
        newCell.setAttribute("colspan", colspan);
        // newCell.innerText = content;
        // this may be unsafe, but innerText does not interpret <br>
        newCell.innerHTML = content;
      }
      function spanCell_4t9ik0byf5bqopam5tov(i, j, rowspan, colspan) {
        var table = document.getElementById("tinytable_4t9ik0byf5bqopam5tov");
        const targetRow = table.rows[i];
        const targetCell = targetRow.cells[j];
        for (let r = 0; r < rowspan; r++) {
          // Only start deleting cells to the right for the first row (r == 0)
          if (r === 0) {
            // Delete cells to the right of the target cell in the first row
            for (let c = colspan - 1; c > 0; c--) {
              if (table.rows[i + r].cells[j + c]) {
                table.rows[i + r].deleteCell(j + c);
              }
            }
          }
          // For rows below the first, delete starting from the target column
          if (r > 0) {
            for (let c = colspan - 1; c >= 0; c--) {
              if (table.rows[i + r] && table.rows[i + r].cells[j]) {
                table.rows[i + r].deleteCell(j);
              }
            }
          }
        }
        // Set rowspan and colspan of the target cell
        targetCell.rowSpan = rowspan;
        targetCell.colSpan = colspan;
      }
window.addEventListener('load', function () { styleCell_4t9ik0byf5bqopam5tov(0, 0, 'tinytable_css_idlw0njft7poaq2q1tlsqb') })
window.addEventListener('load', function () { styleCell_4t9ik0byf5bqopam5tov(0, 1, 'tinytable_css_idlw0njft7poaq2q1tlsqb') })
window.addEventListener('load', function () { styleCell_4t9ik0byf5bqopam5tov(0, 2, 'tinytable_css_idlw0njft7poaq2q1tlsqb') })
window.addEventListener('load', function () { styleCell_4t9ik0byf5bqopam5tov(0, 3, 'tinytable_css_idlw0njft7poaq2q1tlsqb') })
window.addEventListener('load', function () { styleCell_4t9ik0byf5bqopam5tov(0, 4, 'tinytable_css_idlw0njft7poaq2q1tlsqb') })
window.addEventListener('load', function () { styleCell_4t9ik0byf5bqopam5tov(0, 5, 'tinytable_css_idlw0njft7poaq2q1tlsqb') })
    </script>

    <style>
    .table td.tinytable_css_idlw0njft7poaq2q1tlsqb, .table th.tinytable_css_idlw0njft7poaq2q1tlsqb {  border-bottom: solid 0.1em #d3d8dc; }
    </style>
    <div class="container">
      <table class="table table-borderless" id="tinytable_4t9ik0byf5bqopam5tov" style="width: auto; margin-left: auto; margin-right: auto;" data-quarto-disable-processing='true'>
        <thead>
        
              <tr>
                <th scope="col">siteid</th>
                <th scope="col">sitename</th>
                <th scope="col">lat</th>
                <th scope="col">long</th>
                <th scope="col">area</th>
                <th scope="col">elev</th>
              </tr>
        </thead>
        
        <tbody>
                <tr>
                  <td>1399</td>
                  <td>Kameničky</td>
                  <td>49.72633</td>
                  <td>15.97060</td>
                  <td>NA</td>
                  <td>618</td>
                </tr>
                <tr>
                  <td>3021</td>
                  <td>Bláto    </td>
                  <td>49.04174</td>
                  <td>15.19097</td>
                  <td>NA</td>
                  <td>649</td>
                </tr>
        </tbody>
      </table>
    </div>
<!-- hack to avoid NA insertion in last line -->
```


:::
:::


## Downloading data

### Download individual record

Let's download a record with `datasetid` 24279


::: {.cell layout-align="center"}

```{.r .cell-code}
neotoma2::get_downloads(24279) %>% 
 plot_table()
```

::: {.cell-output .cell-output-stdout}

```
.
```


:::

::: {.cell-output-display}


```{=html}
<!-- preamble start -->

    <script>
      function styleCell_ka5npll6xtdys8gkig38(i, j, css_id) {
        var table = document.getElementById("tinytable_ka5npll6xtdys8gkig38");
        table.rows[i].cells[j].classList.add(css_id);
      }
      function insertSpanRow(i, colspan, content) {
        var table = document.getElementById('tinytable_ka5npll6xtdys8gkig38');
        var newRow = table.insertRow(i);
        var newCell = newRow.insertCell(0);
        newCell.setAttribute("colspan", colspan);
        // newCell.innerText = content;
        // this may be unsafe, but innerText does not interpret <br>
        newCell.innerHTML = content;
      }
      function spanCell_ka5npll6xtdys8gkig38(i, j, rowspan, colspan) {
        var table = document.getElementById("tinytable_ka5npll6xtdys8gkig38");
        const targetRow = table.rows[i];
        const targetCell = targetRow.cells[j];
        for (let r = 0; r < rowspan; r++) {
          // Only start deleting cells to the right for the first row (r == 0)
          if (r === 0) {
            // Delete cells to the right of the target cell in the first row
            for (let c = colspan - 1; c > 0; c--) {
              if (table.rows[i + r].cells[j + c]) {
                table.rows[i + r].deleteCell(j + c);
              }
            }
          }
          // For rows below the first, delete starting from the target column
          if (r > 0) {
            for (let c = colspan - 1; c >= 0; c--) {
              if (table.rows[i + r] && table.rows[i + r].cells[j]) {
                table.rows[i + r].deleteCell(j);
              }
            }
          }
        }
        // Set rowspan and colspan of the target cell
        targetCell.rowSpan = rowspan;
        targetCell.colSpan = colspan;
      }
window.addEventListener('load', function () { styleCell_ka5npll6xtdys8gkig38(0, 0, 'tinytable_css_idsx8zg8bwik5y3y6qqben') })
window.addEventListener('load', function () { styleCell_ka5npll6xtdys8gkig38(0, 1, 'tinytable_css_idsx8zg8bwik5y3y6qqben') })
window.addEventListener('load', function () { styleCell_ka5npll6xtdys8gkig38(0, 2, 'tinytable_css_idsx8zg8bwik5y3y6qqben') })
window.addEventListener('load', function () { styleCell_ka5npll6xtdys8gkig38(0, 3, 'tinytable_css_idsx8zg8bwik5y3y6qqben') })
window.addEventListener('load', function () { styleCell_ka5npll6xtdys8gkig38(0, 4, 'tinytable_css_idsx8zg8bwik5y3y6qqben') })
window.addEventListener('load', function () { styleCell_ka5npll6xtdys8gkig38(0, 5, 'tinytable_css_idsx8zg8bwik5y3y6qqben') })
    </script>

    <style>
    .table td.tinytable_css_idsx8zg8bwik5y3y6qqben, .table th.tinytable_css_idsx8zg8bwik5y3y6qqben {  border-bottom: solid 0.1em #d3d8dc; }
    </style>
    <div class="container">
      <table class="table table-borderless" id="tinytable_ka5npll6xtdys8gkig38" style="width: auto; margin-left: auto; margin-right: auto;" data-quarto-disable-processing='true'>
        <thead>
        
              <tr>
                <th scope="col">siteid</th>
                <th scope="col">sitename</th>
                <th scope="col">lat</th>
                <th scope="col">long</th>
                <th scope="col">area</th>
                <th scope="col">elev</th>
              </tr>
        </thead>
        
        <tbody>
                <tr>
                  <td>15799</td>
                  <td>Kulzer Moos</td>
                  <td>49.3912</td>
                  <td>12.4482</td>
                  <td>NA</td>
                  <td>466</td>
                </tr>
        </tbody>
      </table>
    </div>
<!-- hack to avoid NA insertion in last line -->
```


:::
:::


### Download multiple records

Download all records by sites


::: {.cell layout-align="center"}

```{.r .cell-code}
# get sites information
neotoma2::get_sites(sitename = "Alex%") %>%
  # get datasets information
  neotoma2::get_datasets() %>%
  # get downloads
  neotoma2::get_downloads() %>% 
  plot_table()
```

::: {.cell-output .cell-output-stderr}

```
Warning in get_datasets.sites(.): SiteID 26226 or DatasetID NA does not exist in the Neotoma DB yet or it has been removed. 
                        It will be removed from your search.
```


:::

::: {.cell-output .cell-output-stdout}

```
.......
```


:::

::: {.cell-output-display}


```{=html}
<!-- preamble start -->

    <script>
      function styleCell_a4wen9ewzarvd51w7349(i, j, css_id) {
        var table = document.getElementById("tinytable_a4wen9ewzarvd51w7349");
        table.rows[i].cells[j].classList.add(css_id);
      }
      function insertSpanRow(i, colspan, content) {
        var table = document.getElementById('tinytable_a4wen9ewzarvd51w7349');
        var newRow = table.insertRow(i);
        var newCell = newRow.insertCell(0);
        newCell.setAttribute("colspan", colspan);
        // newCell.innerText = content;
        // this may be unsafe, but innerText does not interpret <br>
        newCell.innerHTML = content;
      }
      function spanCell_a4wen9ewzarvd51w7349(i, j, rowspan, colspan) {
        var table = document.getElementById("tinytable_a4wen9ewzarvd51w7349");
        const targetRow = table.rows[i];
        const targetCell = targetRow.cells[j];
        for (let r = 0; r < rowspan; r++) {
          // Only start deleting cells to the right for the first row (r == 0)
          if (r === 0) {
            // Delete cells to the right of the target cell in the first row
            for (let c = colspan - 1; c > 0; c--) {
              if (table.rows[i + r].cells[j + c]) {
                table.rows[i + r].deleteCell(j + c);
              }
            }
          }
          // For rows below the first, delete starting from the target column
          if (r > 0) {
            for (let c = colspan - 1; c >= 0; c--) {
              if (table.rows[i + r] && table.rows[i + r].cells[j]) {
                table.rows[i + r].deleteCell(j);
              }
            }
          }
        }
        // Set rowspan and colspan of the target cell
        targetCell.rowSpan = rowspan;
        targetCell.colSpan = colspan;
      }
window.addEventListener('load', function () { styleCell_a4wen9ewzarvd51w7349(0, 0, 'tinytable_css_idcpk8ar2rmchdpqk77eyu') })
window.addEventListener('load', function () { styleCell_a4wen9ewzarvd51w7349(0, 1, 'tinytable_css_idcpk8ar2rmchdpqk77eyu') })
window.addEventListener('load', function () { styleCell_a4wen9ewzarvd51w7349(0, 2, 'tinytable_css_idcpk8ar2rmchdpqk77eyu') })
window.addEventListener('load', function () { styleCell_a4wen9ewzarvd51w7349(0, 3, 'tinytable_css_idcpk8ar2rmchdpqk77eyu') })
window.addEventListener('load', function () { styleCell_a4wen9ewzarvd51w7349(0, 4, 'tinytable_css_idcpk8ar2rmchdpqk77eyu') })
window.addEventListener('load', function () { styleCell_a4wen9ewzarvd51w7349(0, 5, 'tinytable_css_idcpk8ar2rmchdpqk77eyu') })
    </script>

    <style>
    .table td.tinytable_css_idcpk8ar2rmchdpqk77eyu, .table th.tinytable_css_idcpk8ar2rmchdpqk77eyu {  border-bottom: solid 0.1em #d3d8dc; }
    </style>
    <div class="container">
      <table class="table table-borderless" id="tinytable_a4wen9ewzarvd51w7349" style="width: auto; margin-left: auto; margin-right: auto;" data-quarto-disable-processing='true'>
        <thead>
        
              <tr>
                <th scope="col">siteid</th>
                <th scope="col">sitename</th>
                <th scope="col">lat</th>
                <th scope="col">long</th>
                <th scope="col">area</th>
                <th scope="col">elev</th>
              </tr>
        </thead>
        
        <tbody>
                <tr>
                  <td>24   </td>
                  <td>Alexander Lake    </td>
                  <td>53.33333</td>
                  <td>-60.58333</td>
                  <td>NA</td>
                  <td> 73</td>
                </tr>
                <tr>
                  <td>26226</td>
                  <td>Alexandra Lake    </td>
                  <td>43.29030</td>
                  <td>-74.16966</td>
                  <td>NA</td>
                  <td>351</td>
                </tr>
                <tr>
                  <td>25   </td>
                  <td>Alexis Lake       </td>
                  <td>52.51667</td>
                  <td>-57.03333</td>
                  <td>NA</td>
                  <td>193</td>
                </tr>
                <tr>
                  <td>4478 </td>
                  <td>Alexander [3CN117]</td>
                  <td>35.25000</td>
                  <td>-92.61667</td>
                  <td>NA</td>
                  <td>180</td>
                </tr>
        </tbody>
      </table>
    </div>
<!-- hack to avoid NA insertion in last line -->
```


:::
:::


Download all records by datasets


::: {.cell layout-align="center"}

```{.r .cell-code}
# get datasets information
neotoma2::get_datasets(
  loc = sel_polygon
) %>%
  # filter datasets
  neotoma2::filter(
    datasettype == "pollen" &
      altitude > 500 &
      age_range_young <= 1e3
  ) %>%
  # get downloads
  neotoma2::get_downloads() %>% 
  plot_table()
```

::: {.cell-output .cell-output-stdout}

```
..
```


:::

::: {.cell-output-display}


```{=html}
<!-- preamble start -->

    <script>
      function styleCell_sk4t4nwvv3s14hfhzt3g(i, j, css_id) {
        var table = document.getElementById("tinytable_sk4t4nwvv3s14hfhzt3g");
        table.rows[i].cells[j].classList.add(css_id);
      }
      function insertSpanRow(i, colspan, content) {
        var table = document.getElementById('tinytable_sk4t4nwvv3s14hfhzt3g');
        var newRow = table.insertRow(i);
        var newCell = newRow.insertCell(0);
        newCell.setAttribute("colspan", colspan);
        // newCell.innerText = content;
        // this may be unsafe, but innerText does not interpret <br>
        newCell.innerHTML = content;
      }
      function spanCell_sk4t4nwvv3s14hfhzt3g(i, j, rowspan, colspan) {
        var table = document.getElementById("tinytable_sk4t4nwvv3s14hfhzt3g");
        const targetRow = table.rows[i];
        const targetCell = targetRow.cells[j];
        for (let r = 0; r < rowspan; r++) {
          // Only start deleting cells to the right for the first row (r == 0)
          if (r === 0) {
            // Delete cells to the right of the target cell in the first row
            for (let c = colspan - 1; c > 0; c--) {
              if (table.rows[i + r].cells[j + c]) {
                table.rows[i + r].deleteCell(j + c);
              }
            }
          }
          // For rows below the first, delete starting from the target column
          if (r > 0) {
            for (let c = colspan - 1; c >= 0; c--) {
              if (table.rows[i + r] && table.rows[i + r].cells[j]) {
                table.rows[i + r].deleteCell(j);
              }
            }
          }
        }
        // Set rowspan and colspan of the target cell
        targetCell.rowSpan = rowspan;
        targetCell.colSpan = colspan;
      }
window.addEventListener('load', function () { styleCell_sk4t4nwvv3s14hfhzt3g(0, 0, 'tinytable_css_id5hi25lvx13xvid1l1327') })
window.addEventListener('load', function () { styleCell_sk4t4nwvv3s14hfhzt3g(0, 1, 'tinytable_css_id5hi25lvx13xvid1l1327') })
window.addEventListener('load', function () { styleCell_sk4t4nwvv3s14hfhzt3g(0, 2, 'tinytable_css_id5hi25lvx13xvid1l1327') })
window.addEventListener('load', function () { styleCell_sk4t4nwvv3s14hfhzt3g(0, 3, 'tinytable_css_id5hi25lvx13xvid1l1327') })
window.addEventListener('load', function () { styleCell_sk4t4nwvv3s14hfhzt3g(0, 4, 'tinytable_css_id5hi25lvx13xvid1l1327') })
window.addEventListener('load', function () { styleCell_sk4t4nwvv3s14hfhzt3g(0, 5, 'tinytable_css_id5hi25lvx13xvid1l1327') })
    </script>

    <style>
    .table td.tinytable_css_id5hi25lvx13xvid1l1327, .table th.tinytable_css_id5hi25lvx13xvid1l1327 {  border-bottom: solid 0.1em #d3d8dc; }
    </style>
    <div class="container">
      <table class="table table-borderless" id="tinytable_sk4t4nwvv3s14hfhzt3g" style="width: auto; margin-left: auto; margin-right: auto;" data-quarto-disable-processing='true'>
        <thead>
        
              <tr>
                <th scope="col">siteid</th>
                <th scope="col">sitename</th>
                <th scope="col">lat</th>
                <th scope="col">long</th>
                <th scope="col">area</th>
                <th scope="col">elev</th>
              </tr>
        </thead>
        
        <tbody>
                <tr>
                  <td>3021</td>
                  <td>Bláto    </td>
                  <td>49.04174</td>
                  <td>15.19097</td>
                  <td>NA</td>
                  <td>649</td>
                </tr>
                <tr>
                  <td>1399</td>
                  <td>Kameničky</td>
                  <td>49.72633</td>
                  <td>15.97060</td>
                  <td>NA</td>
                  <td>618</td>
                </tr>
        </tbody>
      </table>
    </div>
<!-- hack to avoid NA insertion in last line -->
```


:::
:::


## Working with pollen counts

### Get samples

download all records by datasets

::: {.cell layout-align="center"}

```{.r .cell-code}
data_selected_downloads <-
  neotoma2::get_datasets(
    loc = sel_polygon
  ) %>%
  # filter datasets
  neotoma2::filter(
    datasettype == "pollen" &
      altitude > 500 &
      age_range_young <= 1e3
  ) %>%
  # get downloads
  neotoma2::get_downloads()
```

::: {.cell-output .cell-output-stdout}

```
..
```


:::
:::


Extraxt Sample information

::: {.cell layout-align="center"}

```{.r .cell-code}
data_selected_samples <-
  neotoma2::samples(data_selected_downloads) %>%
  as.data.frame() %>%
  tibble::as_tibble() %>%
  dplyr::mutate(
    datasetid_sampleid = paste0(datasetid, "_", sampleid)
  )

plot_table(data_selected_samples, head = TRUE)
```

::: {.cell-output-display}


```{=html}
<!-- preamble start -->

    <script>
      function styleCell_4vp0986t0afx59eevybf(i, j, css_id) {
        var table = document.getElementById("tinytable_4vp0986t0afx59eevybf");
        table.rows[i].cells[j].classList.add(css_id);
      }
      function insertSpanRow(i, colspan, content) {
        var table = document.getElementById('tinytable_4vp0986t0afx59eevybf');
        var newRow = table.insertRow(i);
        var newCell = newRow.insertCell(0);
        newCell.setAttribute("colspan", colspan);
        // newCell.innerText = content;
        // this may be unsafe, but innerText does not interpret <br>
        newCell.innerHTML = content;
      }
      function spanCell_4vp0986t0afx59eevybf(i, j, rowspan, colspan) {
        var table = document.getElementById("tinytable_4vp0986t0afx59eevybf");
        const targetRow = table.rows[i];
        const targetCell = targetRow.cells[j];
        for (let r = 0; r < rowspan; r++) {
          // Only start deleting cells to the right for the first row (r == 0)
          if (r === 0) {
            // Delete cells to the right of the target cell in the first row
            for (let c = colspan - 1; c > 0; c--) {
              if (table.rows[i + r].cells[j + c]) {
                table.rows[i + r].deleteCell(j + c);
              }
            }
          }
          // For rows below the first, delete starting from the target column
          if (r > 0) {
            for (let c = colspan - 1; c >= 0; c--) {
              if (table.rows[i + r] && table.rows[i + r].cells[j]) {
                table.rows[i + r].deleteCell(j);
              }
            }
          }
        }
        // Set rowspan and colspan of the target cell
        targetCell.rowSpan = rowspan;
        targetCell.colSpan = colspan;
      }
window.addEventListener('load', function () { styleCell_4vp0986t0afx59eevybf(0, 0, 'tinytable_css_id6p7lepit6yp8gejlvznm') })
window.addEventListener('load', function () { styleCell_4vp0986t0afx59eevybf(0, 1, 'tinytable_css_id6p7lepit6yp8gejlvznm') })
window.addEventListener('load', function () { styleCell_4vp0986t0afx59eevybf(0, 2, 'tinytable_css_id6p7lepit6yp8gejlvznm') })
window.addEventListener('load', function () { styleCell_4vp0986t0afx59eevybf(0, 3, 'tinytable_css_id6p7lepit6yp8gejlvznm') })
window.addEventListener('load', function () { styleCell_4vp0986t0afx59eevybf(0, 4, 'tinytable_css_id6p7lepit6yp8gejlvznm') })
window.addEventListener('load', function () { styleCell_4vp0986t0afx59eevybf(0, 5, 'tinytable_css_id6p7lepit6yp8gejlvznm') })
window.addEventListener('load', function () { styleCell_4vp0986t0afx59eevybf(0, 6, 'tinytable_css_id6p7lepit6yp8gejlvznm') })
window.addEventListener('load', function () { styleCell_4vp0986t0afx59eevybf(0, 7, 'tinytable_css_id6p7lepit6yp8gejlvznm') })
window.addEventListener('load', function () { styleCell_4vp0986t0afx59eevybf(0, 8, 'tinytable_css_id6p7lepit6yp8gejlvznm') })
window.addEventListener('load', function () { styleCell_4vp0986t0afx59eevybf(0, 9, 'tinytable_css_id6p7lepit6yp8gejlvznm') })
window.addEventListener('load', function () { styleCell_4vp0986t0afx59eevybf(0, 10, 'tinytable_css_id6p7lepit6yp8gejlvznm') })
window.addEventListener('load', function () { styleCell_4vp0986t0afx59eevybf(0, 11, 'tinytable_css_id6p7lepit6yp8gejlvznm') })
window.addEventListener('load', function () { styleCell_4vp0986t0afx59eevybf(0, 12, 'tinytable_css_id6p7lepit6yp8gejlvznm') })
window.addEventListener('load', function () { styleCell_4vp0986t0afx59eevybf(0, 13, 'tinytable_css_id6p7lepit6yp8gejlvznm') })
window.addEventListener('load', function () { styleCell_4vp0986t0afx59eevybf(0, 14, 'tinytable_css_id6p7lepit6yp8gejlvznm') })
window.addEventListener('load', function () { styleCell_4vp0986t0afx59eevybf(0, 15, 'tinytable_css_id6p7lepit6yp8gejlvznm') })
window.addEventListener('load', function () { styleCell_4vp0986t0afx59eevybf(0, 16, 'tinytable_css_id6p7lepit6yp8gejlvznm') })
window.addEventListener('load', function () { styleCell_4vp0986t0afx59eevybf(0, 17, 'tinytable_css_id6p7lepit6yp8gejlvznm') })
window.addEventListener('load', function () { styleCell_4vp0986t0afx59eevybf(0, 18, 'tinytable_css_id6p7lepit6yp8gejlvznm') })
window.addEventListener('load', function () { styleCell_4vp0986t0afx59eevybf(0, 19, 'tinytable_css_id6p7lepit6yp8gejlvznm') })
window.addEventListener('load', function () { styleCell_4vp0986t0afx59eevybf(0, 20, 'tinytable_css_id6p7lepit6yp8gejlvznm') })
window.addEventListener('load', function () { styleCell_4vp0986t0afx59eevybf(0, 21, 'tinytable_css_id6p7lepit6yp8gejlvznm') })
window.addEventListener('load', function () { styleCell_4vp0986t0afx59eevybf(0, 22, 'tinytable_css_id6p7lepit6yp8gejlvznm') })
window.addEventListener('load', function () { styleCell_4vp0986t0afx59eevybf(0, 23, 'tinytable_css_id6p7lepit6yp8gejlvznm') })
window.addEventListener('load', function () { styleCell_4vp0986t0afx59eevybf(0, 24, 'tinytable_css_id6p7lepit6yp8gejlvznm') })
window.addEventListener('load', function () { styleCell_4vp0986t0afx59eevybf(0, 25, 'tinytable_css_id6p7lepit6yp8gejlvznm') })
window.addEventListener('load', function () { styleCell_4vp0986t0afx59eevybf(0, 26, 'tinytable_css_id6p7lepit6yp8gejlvznm') })
window.addEventListener('load', function () { styleCell_4vp0986t0afx59eevybf(0, 27, 'tinytable_css_id6p7lepit6yp8gejlvznm') })
window.addEventListener('load', function () { styleCell_4vp0986t0afx59eevybf(0, 28, 'tinytable_css_id6p7lepit6yp8gejlvznm') })
window.addEventListener('load', function () { styleCell_4vp0986t0afx59eevybf(0, 29, 'tinytable_css_id6p7lepit6yp8gejlvznm') })
window.addEventListener('load', function () { styleCell_4vp0986t0afx59eevybf(0, 30, 'tinytable_css_id6p7lepit6yp8gejlvznm') })
window.addEventListener('load', function () { styleCell_4vp0986t0afx59eevybf(0, 31, 'tinytable_css_id6p7lepit6yp8gejlvznm') })
window.addEventListener('load', function () { styleCell_4vp0986t0afx59eevybf(0, 32, 'tinytable_css_id6p7lepit6yp8gejlvznm') })
window.addEventListener('load', function () { styleCell_4vp0986t0afx59eevybf(0, 33, 'tinytable_css_id6p7lepit6yp8gejlvznm') })
window.addEventListener('load', function () { styleCell_4vp0986t0afx59eevybf(0, 34, 'tinytable_css_id6p7lepit6yp8gejlvznm') })
window.addEventListener('load', function () { styleCell_4vp0986t0afx59eevybf(0, 35, 'tinytable_css_id6p7lepit6yp8gejlvznm') })
window.addEventListener('load', function () { styleCell_4vp0986t0afx59eevybf(0, 36, 'tinytable_css_id6p7lepit6yp8gejlvznm') })
    </script>

    <style>
    .table td.tinytable_css_id6p7lepit6yp8gejlvznm, .table th.tinytable_css_id6p7lepit6yp8gejlvznm {  border-bottom: solid 0.1em #d3d8dc; }
    </style>
    <div class="container">
      <table class="table table-borderless" id="tinytable_4vp0986t0afx59eevybf" style="width: auto; margin-left: auto; margin-right: auto;" data-quarto-disable-processing='true'>
        <thead>
        
              <tr>
                <th scope="col">age</th>
                <th scope="col">agetype</th>
                <th scope="col">ageolder</th>
                <th scope="col">ageyounger</th>
                <th scope="col">chronologyid</th>
                <th scope="col">chronologyname</th>
                <th scope="col">units</th>
                <th scope="col">value</th>
                <th scope="col">context</th>
                <th scope="col">element</th>
                <th scope="col">taxonid</th>
                <th scope="col">symmetry</th>
                <th scope="col">taxongroup</th>
                <th scope="col">elementtype</th>
                <th scope="col">variablename</th>
                <th scope="col">ecologicalgroup</th>
                <th scope="col">analysisunitid</th>
                <th scope="col">sampleanalyst</th>
                <th scope="col">sampleid</th>
                <th scope="col">depth</th>
                <th scope="col">thickness</th>
                <th scope="col">samplename</th>
                <th scope="col">datasetid</th>
                <th scope="col">database</th>
                <th scope="col">datasettype</th>
                <th scope="col">age_range_old</th>
                <th scope="col">age_range_young</th>
                <th scope="col">datasetnotes</th>
                <th scope="col">siteid</th>
                <th scope="col">sitename</th>
                <th scope="col">lat</th>
                <th scope="col">long</th>
                <th scope="col">area</th>
                <th scope="col">sitenotes</th>
                <th scope="col">elev</th>
                <th scope="col">collunitid</th>
                <th scope="col">datasetid_sampleid</th>
              </tr>
        </thead>
        
        <tbody>
                <tr>
                  <td>236</td>
                  <td>Calibrated radiocarbon years BP</td>
                  <td>687</td>
                  <td>-56</td>
                  <td>25602</td>
                  <td>Giesecke et al. 2014 (MADCAP)</td>
                  <td>NISP</td>
                  <td>1</td>
                  <td>NA</td>
                  <td>pollen</td>
                  <td> 284</td>
                  <td>NA</td>
                  <td>Vascular plants</td>
                  <td>pollen</td>
                  <td>Scrophulariaceae</td>
                  <td>UPHE</td>
                  <td>49681</td>
                  <td>Rybníčková, Eliška</td>
                  <td>347661</td>
                  <td>0</td>
                  <td>NA</td>
                  <td>NA</td>
                  <td>3935</td>
                  <td>European Pollen Database</td>
                  <td>pollen</td>
                  <td>11372</td>
                  <td>6115</td>
                  <td>Data contributed by Rybníčková Eliška.</td>
                  <td>3021</td>
                  <td>Bláto</td>
                  <td>49.04174</td>
                  <td>15.19097</td>
                  <td>NA</td>
                  <td>This site ceased to exist after 1970.</td>
                  <td>649</td>
                  <td>3810</td>
                  <td>3935_347661</td>
                </tr>
                <tr>
                  <td>236</td>
                  <td>Calibrated radiocarbon years BP</td>
                  <td>687</td>
                  <td>-56</td>
                  <td>25602</td>
                  <td>Giesecke et al. 2014 (MADCAP)</td>
                  <td>NISP</td>
                  <td>1</td>
                  <td>NA</td>
                  <td>pollen</td>
                  <td> 311</td>
                  <td>NA</td>
                  <td>Vascular plants</td>
                  <td>pollen</td>
                  <td>Apiaceae        </td>
                  <td>UPHE</td>
                  <td>49681</td>
                  <td>Rybníčková, Eliška</td>
                  <td>347661</td>
                  <td>0</td>
                  <td>NA</td>
                  <td>NA</td>
                  <td>3935</td>
                  <td>European Pollen Database</td>
                  <td>pollen</td>
                  <td>11372</td>
                  <td>6115</td>
                  <td>Data contributed by Rybníčková Eliška.</td>
                  <td>3021</td>
                  <td>Bláto</td>
                  <td>49.04174</td>
                  <td>15.19097</td>
                  <td>NA</td>
                  <td>This site ceased to exist after 1970.</td>
                  <td>649</td>
                  <td>3810</td>
                  <td>3935_347661</td>
                </tr>
                <tr>
                  <td>236</td>
                  <td>Calibrated radiocarbon years BP</td>
                  <td>687</td>
                  <td>-56</td>
                  <td>25602</td>
                  <td>Giesecke et al. 2014 (MADCAP)</td>
                  <td>NISP</td>
                  <td>1</td>
                  <td>NA</td>
                  <td>pollen</td>
                  <td> 350</td>
                  <td>NA</td>
                  <td>Vascular plants</td>
                  <td>pollen</td>
                  <td>Ranunculaceae   </td>
                  <td>UPHE</td>
                  <td>49681</td>
                  <td>Rybníčková, Eliška</td>
                  <td>347661</td>
                  <td>0</td>
                  <td>NA</td>
                  <td>NA</td>
                  <td>3935</td>
                  <td>European Pollen Database</td>
                  <td>pollen</td>
                  <td>11372</td>
                  <td>6115</td>
                  <td>Data contributed by Rybníčková Eliška.</td>
                  <td>3021</td>
                  <td>Bláto</td>
                  <td>49.04174</td>
                  <td>15.19097</td>
                  <td>NA</td>
                  <td>This site ceased to exist after 1970.</td>
                  <td>649</td>
                  <td>3810</td>
                  <td>3935_347661</td>
                </tr>
                <tr>
                  <td>236</td>
                  <td>Calibrated radiocarbon years BP</td>
                  <td>687</td>
                  <td>-56</td>
                  <td>25602</td>
                  <td>Giesecke et al. 2014 (MADCAP)</td>
                  <td>NISP</td>
                  <td>1</td>
                  <td>NA</td>
                  <td>pollen</td>
                  <td>1319</td>
                  <td>NA</td>
                  <td>Vascular plants</td>
                  <td>pollen</td>
                  <td>Carpinus betulus</td>
                  <td>TRSH</td>
                  <td>49681</td>
                  <td>Rybníčková, Eliška</td>
                  <td>347661</td>
                  <td>0</td>
                  <td>NA</td>
                  <td>NA</td>
                  <td>3935</td>
                  <td>European Pollen Database</td>
                  <td>pollen</td>
                  <td>11372</td>
                  <td>6115</td>
                  <td>Data contributed by Rybníčková Eliška.</td>
                  <td>3021</td>
                  <td>Bláto</td>
                  <td>49.04174</td>
                  <td>15.19097</td>
                  <td>NA</td>
                  <td>This site ceased to exist after 1970.</td>
                  <td>649</td>
                  <td>3810</td>
                  <td>3935_347661</td>
                </tr>
                <tr>
                  <td>236</td>
                  <td>Calibrated radiocarbon years BP</td>
                  <td>687</td>
                  <td>-56</td>
                  <td>25602</td>
                  <td>Giesecke et al. 2014 (MADCAP)</td>
                  <td>NISP</td>
                  <td>1</td>
                  <td>NA</td>
                  <td>pollen</td>
                  <td>3645</td>
                  <td>NA</td>
                  <td>Vascular plants</td>
                  <td>pollen</td>
                  <td>Barbarea-type   </td>
                  <td>UPHE</td>
                  <td>49681</td>
                  <td>Rybníčková, Eliška</td>
                  <td>347661</td>
                  <td>0</td>
                  <td>NA</td>
                  <td>NA</td>
                  <td>3935</td>
                  <td>European Pollen Database</td>
                  <td>pollen</td>
                  <td>11372</td>
                  <td>6115</td>
                  <td>Data contributed by Rybníčková Eliška.</td>
                  <td>3021</td>
                  <td>Bláto</td>
                  <td>49.04174</td>
                  <td>15.19097</td>
                  <td>NA</td>
                  <td>This site ceased to exist after 1970.</td>
                  <td>649</td>
                  <td>3810</td>
                  <td>3935_347661</td>
                </tr>
                <tr>
                  <td>236</td>
                  <td>Calibrated radiocarbon years BP</td>
                  <td>687</td>
                  <td>-56</td>
                  <td>25602</td>
                  <td>Giesecke et al. 2014 (MADCAP)</td>
                  <td>NISP</td>
                  <td>1</td>
                  <td>NA</td>
                  <td>spore </td>
                  <td>  91</td>
                  <td>NA</td>
                  <td>Vascular plants</td>
                  <td>spore </td>
                  <td>Equisetum       </td>
                  <td>VACR</td>
                  <td>49681</td>
                  <td>Rybníčková, Eliška</td>
                  <td>347661</td>
                  <td>0</td>
                  <td>NA</td>
                  <td>NA</td>
                  <td>3935</td>
                  <td>European Pollen Database</td>
                  <td>pollen</td>
                  <td>11372</td>
                  <td>6115</td>
                  <td>Data contributed by Rybníčková Eliška.</td>
                  <td>3021</td>
                  <td>Bláto</td>
                  <td>49.04174</td>
                  <td>15.19097</td>
                  <td>NA</td>
                  <td>This site ceased to exist after 1970.</td>
                  <td>649</td>
                  <td>3810</td>
                  <td>3935_347661</td>
                </tr>
        </tbody>
      </table>
    </div>
<!-- hack to avoid NA insertion in last line -->
```


:::
:::


### Get pollen counts

Get vector of all "pollen" taxa

::: {.cell layout-align="center"}

```{.r .cell-code}
vec_taxa_pollen <-
  neotoma2::taxa(data_selected_downloads) %>%
  dplyr::filter(element == "pollen") %>%
  purrr::pluck("variablename") %>%
  sort()

head(vec_taxa_pollen)
```

::: {.cell-output .cell-output-stdout}

```
[1] "Abies alba"    "Acer"          "Achillea-type" "Alisma"       
[5] "Alnus"         "Amaranthaceae"
```


:::
:::


Get pollen counts

::: {.cell layout-align="center"}

```{.r .cell-code}
data_sample_pollen_counts <-
  data_selected_samples %>%
  dplyr::select("datasetid_sampleid", "value", "variablename") %>%
  # only include selected taxons
  dplyr::filter(
    variablename %in% vec_taxa_pollen
  ) %>%
  dplyr::arrange(variablename) %>%
  # turn into the wider format
  tidyr::pivot_wider(
    names_from = "variablename",
    values_from = "value",
    values_fill = 0
  ) %>%
  # clean names
  janitor::clean_names()

plot_table(data_sample_pollen_counts, head = TRUE) 
```

::: {.cell-output-display}


```{=html}
<!-- preamble start -->

    <script>
      function styleCell_rtdyf01rhc8f7f3d0whd(i, j, css_id) {
        var table = document.getElementById("tinytable_rtdyf01rhc8f7f3d0whd");
        table.rows[i].cells[j].classList.add(css_id);
      }
      function insertSpanRow(i, colspan, content) {
        var table = document.getElementById('tinytable_rtdyf01rhc8f7f3d0whd');
        var newRow = table.insertRow(i);
        var newCell = newRow.insertCell(0);
        newCell.setAttribute("colspan", colspan);
        // newCell.innerText = content;
        // this may be unsafe, but innerText does not interpret <br>
        newCell.innerHTML = content;
      }
      function spanCell_rtdyf01rhc8f7f3d0whd(i, j, rowspan, colspan) {
        var table = document.getElementById("tinytable_rtdyf01rhc8f7f3d0whd");
        const targetRow = table.rows[i];
        const targetCell = targetRow.cells[j];
        for (let r = 0; r < rowspan; r++) {
          // Only start deleting cells to the right for the first row (r == 0)
          if (r === 0) {
            // Delete cells to the right of the target cell in the first row
            for (let c = colspan - 1; c > 0; c--) {
              if (table.rows[i + r].cells[j + c]) {
                table.rows[i + r].deleteCell(j + c);
              }
            }
          }
          // For rows below the first, delete starting from the target column
          if (r > 0) {
            for (let c = colspan - 1; c >= 0; c--) {
              if (table.rows[i + r] && table.rows[i + r].cells[j]) {
                table.rows[i + r].deleteCell(j);
              }
            }
          }
        }
        // Set rowspan and colspan of the target cell
        targetCell.rowSpan = rowspan;
        targetCell.colSpan = colspan;
      }
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 0, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 1, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 2, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 3, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 4, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 5, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 6, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 7, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 8, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 9, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 10, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 11, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 12, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 13, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 14, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 15, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 16, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 17, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 18, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 19, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 20, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 21, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 22, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 23, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 24, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 25, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 26, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 27, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 28, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 29, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 30, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 31, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 32, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 33, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 34, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 35, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 36, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 37, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 38, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 39, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 40, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 41, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 42, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 43, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 44, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 45, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 46, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 47, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 48, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 49, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 50, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 51, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 52, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 53, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 54, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 55, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 56, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 57, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 58, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 59, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 60, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 61, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 62, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 63, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 64, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 65, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 66, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 67, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 68, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 69, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 70, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 71, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 72, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 73, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 74, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 75, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 76, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 77, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 78, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 79, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 80, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 81, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 82, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 83, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 84, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 85, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 86, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 87, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 88, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 89, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 90, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 91, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 92, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 93, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 94, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 95, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 96, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 97, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 98, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 99, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 100, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 101, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 102, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 103, 'tinytable_css_idwrian3btvfwchulh80bn') })
window.addEventListener('load', function () { styleCell_rtdyf01rhc8f7f3d0whd(0, 104, 'tinytable_css_idwrian3btvfwchulh80bn') })
    </script>

    <style>
    .table td.tinytable_css_idwrian3btvfwchulh80bn, .table th.tinytable_css_idwrian3btvfwchulh80bn {  border-bottom: solid 0.1em #d3d8dc; }
    </style>
    <div class="container">
      <table class="table table-borderless" id="tinytable_rtdyf01rhc8f7f3d0whd" style="width: auto; margin-left: auto; margin-right: auto;" data-quarto-disable-processing='true'>
        <thead>
        
              <tr>
                <th scope="col">datasetid_sampleid</th>
                <th scope="col">abies_alba</th>
                <th scope="col">acer</th>
                <th scope="col">achillea_type</th>
                <th scope="col">alisma</th>
                <th scope="col">alnus</th>
                <th scope="col">amaranthaceae</th>
                <th scope="col">anemone_type</th>
                <th scope="col">apiaceae</th>
                <th scope="col">artemisia</th>
                <th scope="col">asteroideae</th>
                <th scope="col">avena_type</th>
                <th scope="col">barbarea_type</th>
                <th scope="col">betula</th>
                <th scope="col">bistorta_officinalis_type</th>
                <th scope="col">brassicaceae</th>
                <th scope="col">calluna_vulgaris</th>
                <th scope="col">caltha_type</th>
                <th scope="col">campanula</th>
                <th scope="col">cardamine_pratensis_type</th>
                <th scope="col">carpinus_betulus</th>
                <th scope="col">centaurea_cyanus</th>
                <th scope="col">centaurea_cyanus_type</th>
                <th scope="col">centaurea_scabiosa</th>
                <th scope="col">centaurea_scabiosa_type</th>
                <th scope="col">chamaenerion_angustifolium</th>
                <th scope="col">chrysosplenium</th>
                <th scope="col">cichorioideae</th>
                <th scope="col">cirsium_type</th>
                <th scope="col">comarum</th>
                <th scope="col">corylus_avellana</th>
                <th scope="col">cyperaceae</th>
                <th scope="col">echium</th>
                <th scope="col">ephedra_distachya</th>
                <th scope="col">ephedra_foeminea_type</th>
                <th scope="col">epilobium</th>
                <th scope="col">euonymus</th>
                <th scope="col">fagus_sylvatica</th>
                <th scope="col">filipendula</th>
                <th scope="col">frangula_alnus</th>
                <th scope="col">fraxinus</th>
                <th scope="col">galium_type</th>
                <th scope="col">hedera_helix</th>
                <th scope="col">helianthemum</th>
                <th scope="col">juglans</th>
                <th scope="col">juniperus</th>
                <th scope="col">lamium_type</th>
                <th scope="col">larix_decidua</th>
                <th scope="col">liliaceae</th>
                <th scope="col">lonicera</th>
                <th scope="col">lotus_type</th>
                <th scope="col">lycopus_type</th>
                <th scope="col">lysimachia_vulgaris_type</th>
                <th scope="col">lythrum</th>
                <th scope="col">melampyrum</th>
                <th scope="col">mentha_type</th>
                <th scope="col">menyanthes_trifoliata_type</th>
                <th scope="col">parnassia_palustris</th>
                <th scope="col">persicaria_maculosa_type</th>
                <th scope="col">petasites_type</th>
                <th scope="col">picea_abies</th>
                <th scope="col">pinus</th>
                <th scope="col">plantago_lanceolata</th>
                <th scope="col">plantago_lanceolata_type</th>
                <th scope="col">plantago_major_p_media</th>
                <th scope="col">pleurospermum</th>
                <th scope="col">pleurospermum_austriacum</th>
                <th scope="col">poaceae</th>
                <th scope="col">poaceae_cerealia_undiff</th>
                <th scope="col">poaceae_cerealia_type</th>
                <th scope="col">polygonum_aviculare</th>
                <th scope="col">populus</th>
                <th scope="col">potamogeton_type</th>
                <th scope="col">quercus</th>
                <th scope="col">ranunculaceae</th>
                <th scope="col">ranunculus_arvensis_type</th>
                <th scope="col">ranunculus_type</th>
                <th scope="col">rosaceae</th>
                <th scope="col">rumex_acetosa_type</th>
                <th scope="col">salix</th>
                <th scope="col">sambucus_nigra_type</th>
                <th scope="col">sanguisorba_officinalis</th>
                <th scope="col">scrophulariaceae</th>
                <th scope="col">secale_type</th>
                <th scope="col">senecio_type</th>
                <th scope="col">silene_type</th>
                <th scope="col">silene_type_undiff</th>
                <th scope="col">sorbus</th>
                <th scope="col">succisa</th>
                <th scope="col">succisa_pratensis</th>
                <th scope="col">thalictrum</th>
                <th scope="col">tilia</th>
                <th scope="col">trifolium_pratense_type</th>
                <th scope="col">typha_angustifolia_sparganium</th>
                <th scope="col">typha_latifolia</th>
                <th scope="col">ulmus</th>
                <th scope="col">urtica</th>
                <th scope="col">vaccinium_type</th>
                <th scope="col">valeriana</th>
                <th scope="col">viburnum_cf_v_opulus</th>
                <th scope="col">viburnum_undiff</th>
                <th scope="col">vicia_type</th>
                <th scope="col">viola</th>
                <th scope="col">viscum</th>
                <th scope="col">vitis</th>
              </tr>
        </thead>
        
        <tbody>
                <tr>
                  <td>3935_347661</td>
                  <td> 8</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>13</td>
                  <td>2</td>
                  <td>0</td>
                  <td>1</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>1</td>
                  <td>27</td>
                  <td>0</td>
                  <td>0</td>
                  <td>14</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>1</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td> 5</td>
                  <td> 2</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td> 8</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>26</td>
                  <td>110</td>
                  <td>0</td>
                  <td>8</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td> 7</td>
                  <td>0</td>
                  <td> 9</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>2</td>
                  <td>1</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>2</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>1</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                </tr>
                <tr>
                  <td>3935_347662</td>
                  <td>12</td>
                  <td>1</td>
                  <td>0</td>
                  <td>0</td>
                  <td>15</td>
                  <td>3</td>
                  <td>0</td>
                  <td>0</td>
                  <td>4</td>
                  <td>2</td>
                  <td>0</td>
                  <td>2</td>
                  <td>30</td>
                  <td>0</td>
                  <td>0</td>
                  <td>47</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>1</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>11</td>
                  <td> 6</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>15</td>
                  <td>1</td>
                  <td>0</td>
                  <td>1</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>26</td>
                  <td> 82</td>
                  <td>0</td>
                  <td>6</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>33</td>
                  <td>0</td>
                  <td>18</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>6</td>
                  <td>2</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>4</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>1</td>
                  <td>0</td>
                  <td>0</td>
                  <td>3</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                </tr>
                <tr>
                  <td>3935_347663</td>
                  <td>16</td>
                  <td>1</td>
                  <td>0</td>
                  <td>0</td>
                  <td> 8</td>
                  <td>1</td>
                  <td>0</td>
                  <td>3</td>
                  <td>3</td>
                  <td>2</td>
                  <td>0</td>
                  <td>2</td>
                  <td>64</td>
                  <td>0</td>
                  <td>0</td>
                  <td> 0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>2</td>
                  <td>0</td>
                  <td>1</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>1</td>
                  <td>0</td>
                  <td>0</td>
                  <td>12</td>
                  <td> 8</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>16</td>
                  <td>0</td>
                  <td>1</td>
                  <td>0</td>
                  <td>2</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>25</td>
                  <td> 53</td>
                  <td>0</td>
                  <td>2</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>10</td>
                  <td>0</td>
                  <td>17</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>1</td>
                  <td>3</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>2</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>1</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>1</td>
                  <td>0</td>
                  <td>3</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                </tr>
                <tr>
                  <td>3935_347664</td>
                  <td>18</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td> 2</td>
                  <td>1</td>
                  <td>0</td>
                  <td>2</td>
                  <td>2</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>53</td>
                  <td>0</td>
                  <td>0</td>
                  <td> 1</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>3</td>
                  <td>0</td>
                  <td>1</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>1</td>
                  <td>0</td>
                  <td>0</td>
                  <td>24</td>
                  <td>13</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>15</td>
                  <td>1</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>30</td>
                  <td> 48</td>
                  <td>0</td>
                  <td>1</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>23</td>
                  <td>0</td>
                  <td>10</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>5</td>
                  <td>4</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>4</td>
                  <td>1</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>2</td>
                  <td>1</td>
                  <td>0</td>
                  <td>4</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                </tr>
                <tr>
                  <td>3935_347665</td>
                  <td>76</td>
                  <td>1</td>
                  <td>0</td>
                  <td>0</td>
                  <td> 7</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>3</td>
                  <td>1</td>
                  <td>0</td>
                  <td>0</td>
                  <td> 5</td>
                  <td>0</td>
                  <td>0</td>
                  <td> 1</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>2</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>12</td>
                  <td> 7</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>45</td>
                  <td>0</td>
                  <td>0</td>
                  <td>1</td>
                  <td>1</td>
                  <td>0</td>
                  <td>0</td>
                  <td>1</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>18</td>
                  <td> 28</td>
                  <td>0</td>
                  <td>2</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td> 6</td>
                  <td>0</td>
                  <td> 5</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>3</td>
                  <td>2</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>1</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>4</td>
                  <td>0</td>
                  <td>1</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                </tr>
                <tr>
                  <td>3935_347666</td>
                  <td>61</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>19</td>
                  <td>1</td>
                  <td>0</td>
                  <td>0</td>
                  <td>1</td>
                  <td>1</td>
                  <td>0</td>
                  <td>0</td>
                  <td>10</td>
                  <td>0</td>
                  <td>0</td>
                  <td> 0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>1</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>14</td>
                  <td> 0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>40</td>
                  <td>0</td>
                  <td>1</td>
                  <td>2</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>23</td>
                  <td> 19</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td> 3</td>
                  <td>0</td>
                  <td> 0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>1</td>
                  <td>5</td>
                  <td>1</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>1</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>1</td>
                  <td>1</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>4</td>
                  <td>0</td>
                  <td>1</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                  <td>0</td>
                </tr>
        </tbody>
      </table>
    </div>
<!-- hack to avoid NA insertion in last line -->
```


:::
:::


### Getting the age information 


::: {.cell layout-align="center"}

```{.r .cell-code}
data_sample_age <-
  data_selected_samples %>%
  dplyr::distinct(datasetid_sampleid, depth, age) %>%
  dplyr::arrange(datasetid_sampleid, age)

plot_table(data_sample_age, head = TRUE)
```

::: {.cell-output-display}


```{=html}
<!-- preamble start -->

    <script>
      function styleCell_nunr5uf86exah1cmh7c4(i, j, css_id) {
        var table = document.getElementById("tinytable_nunr5uf86exah1cmh7c4");
        table.rows[i].cells[j].classList.add(css_id);
      }
      function insertSpanRow(i, colspan, content) {
        var table = document.getElementById('tinytable_nunr5uf86exah1cmh7c4');
        var newRow = table.insertRow(i);
        var newCell = newRow.insertCell(0);
        newCell.setAttribute("colspan", colspan);
        // newCell.innerText = content;
        // this may be unsafe, but innerText does not interpret <br>
        newCell.innerHTML = content;
      }
      function spanCell_nunr5uf86exah1cmh7c4(i, j, rowspan, colspan) {
        var table = document.getElementById("tinytable_nunr5uf86exah1cmh7c4");
        const targetRow = table.rows[i];
        const targetCell = targetRow.cells[j];
        for (let r = 0; r < rowspan; r++) {
          // Only start deleting cells to the right for the first row (r == 0)
          if (r === 0) {
            // Delete cells to the right of the target cell in the first row
            for (let c = colspan - 1; c > 0; c--) {
              if (table.rows[i + r].cells[j + c]) {
                table.rows[i + r].deleteCell(j + c);
              }
            }
          }
          // For rows below the first, delete starting from the target column
          if (r > 0) {
            for (let c = colspan - 1; c >= 0; c--) {
              if (table.rows[i + r] && table.rows[i + r].cells[j]) {
                table.rows[i + r].deleteCell(j);
              }
            }
          }
        }
        // Set rowspan and colspan of the target cell
        targetCell.rowSpan = rowspan;
        targetCell.colSpan = colspan;
      }
window.addEventListener('load', function () { styleCell_nunr5uf86exah1cmh7c4(0, 0, 'tinytable_css_iduaq2gn8a2xq7n8mv6j1s') })
window.addEventListener('load', function () { styleCell_nunr5uf86exah1cmh7c4(0, 1, 'tinytable_css_iduaq2gn8a2xq7n8mv6j1s') })
window.addEventListener('load', function () { styleCell_nunr5uf86exah1cmh7c4(0, 2, 'tinytable_css_iduaq2gn8a2xq7n8mv6j1s') })
    </script>

    <style>
    .table td.tinytable_css_iduaq2gn8a2xq7n8mv6j1s, .table th.tinytable_css_iduaq2gn8a2xq7n8mv6j1s {  border-bottom: solid 0.1em #d3d8dc; }
    </style>
    <div class="container">
      <table class="table table-borderless" id="tinytable_nunr5uf86exah1cmh7c4" style="width: auto; margin-left: auto; margin-right: auto;" data-quarto-disable-processing='true'>
        <thead>
        
              <tr>
                <th scope="col">datasetid_sampleid</th>
                <th scope="col">depth</th>
                <th scope="col">age</th>
              </tr>
        </thead>
        
        <tbody>
                <tr>
                  <td>1435_342283</td>
                  <td> 0.0</td>
                  <td>  48</td>
                </tr>
                <tr>
                  <td>1435_342284</td>
                  <td> 2.5</td>
                  <td> 274</td>
                </tr>
                <tr>
                  <td>1435_342285</td>
                  <td> 5.0</td>
                  <td> 507</td>
                </tr>
                <tr>
                  <td>1435_342286</td>
                  <td>10.0</td>
                  <td>1010</td>
                </tr>
                <tr>
                  <td>1435_342287</td>
                  <td>15.0</td>
                  <td>1601</td>
                </tr>
                <tr>
                  <td>1435_342288</td>
                  <td>20.0</td>
                  <td>2337</td>
                </tr>
        </tbody>
      </table>
    </div>
<!-- hack to avoid NA insertion in last line -->
```


:::
:::


### Plotting pollen diagram

Data wrangling

::: {.cell layout-align="center"}

```{.r .cell-code}
data_to_plot <-
  data_sample_pollen_counts %>%
  # we need to turn the pollen counts into percentages
  tibble::column_to_rownames("datasetid_sampleid") %>%
  dplyr::mutate(
    colsum = rowSums(.)
  ) %>%
  dplyr::mutate(
    dplyr::across(
      -(colsum),
      ~ (. / colsum) * 100
    )
  ) %>%
  tibble::rownames_to_column("datasetid_sampleid") %>%
  dplyr::select(-colsum) %>%
  # turn into the longer format
  tidyr::pivot_longer(
    cols = -datasetid_sampleid,
    names_to = "taxon",
    values_to = "count"
  ) %>%
  # add age information
  dplyr::left_join(
    data_sample_age,
    by = "datasetid_sampleid"
  ) %>%
  dplyr::select(
    "datasetid_sampleid", "age", "taxon", "count"
  ) %>%
  tidyr::separate(
    datasetid_sampleid,
    c("datasetid", "sampleid"),
    sep = "_"
  )

plot_table(data_to_plot, head = TRUE)
```

::: {.cell-output-display}


```{=html}
<!-- preamble start -->

    <script>
      function styleCell_1ofvv6j2nwbssfeavh4k(i, j, css_id) {
        var table = document.getElementById("tinytable_1ofvv6j2nwbssfeavh4k");
        table.rows[i].cells[j].classList.add(css_id);
      }
      function insertSpanRow(i, colspan, content) {
        var table = document.getElementById('tinytable_1ofvv6j2nwbssfeavh4k');
        var newRow = table.insertRow(i);
        var newCell = newRow.insertCell(0);
        newCell.setAttribute("colspan", colspan);
        // newCell.innerText = content;
        // this may be unsafe, but innerText does not interpret <br>
        newCell.innerHTML = content;
      }
      function spanCell_1ofvv6j2nwbssfeavh4k(i, j, rowspan, colspan) {
        var table = document.getElementById("tinytable_1ofvv6j2nwbssfeavh4k");
        const targetRow = table.rows[i];
        const targetCell = targetRow.cells[j];
        for (let r = 0; r < rowspan; r++) {
          // Only start deleting cells to the right for the first row (r == 0)
          if (r === 0) {
            // Delete cells to the right of the target cell in the first row
            for (let c = colspan - 1; c > 0; c--) {
              if (table.rows[i + r].cells[j + c]) {
                table.rows[i + r].deleteCell(j + c);
              }
            }
          }
          // For rows below the first, delete starting from the target column
          if (r > 0) {
            for (let c = colspan - 1; c >= 0; c--) {
              if (table.rows[i + r] && table.rows[i + r].cells[j]) {
                table.rows[i + r].deleteCell(j);
              }
            }
          }
        }
        // Set rowspan and colspan of the target cell
        targetCell.rowSpan = rowspan;
        targetCell.colSpan = colspan;
      }
window.addEventListener('load', function () { styleCell_1ofvv6j2nwbssfeavh4k(0, 0, 'tinytable_css_idq4fw39yht46nslsm2epq') })
window.addEventListener('load', function () { styleCell_1ofvv6j2nwbssfeavh4k(0, 1, 'tinytable_css_idq4fw39yht46nslsm2epq') })
window.addEventListener('load', function () { styleCell_1ofvv6j2nwbssfeavh4k(0, 2, 'tinytable_css_idq4fw39yht46nslsm2epq') })
window.addEventListener('load', function () { styleCell_1ofvv6j2nwbssfeavh4k(0, 3, 'tinytable_css_idq4fw39yht46nslsm2epq') })
window.addEventListener('load', function () { styleCell_1ofvv6j2nwbssfeavh4k(0, 4, 'tinytable_css_idq4fw39yht46nslsm2epq') })
    </script>

    <style>
    .table td.tinytable_css_idq4fw39yht46nslsm2epq, .table th.tinytable_css_idq4fw39yht46nslsm2epq {  border-bottom: solid 0.1em #d3d8dc; }
    </style>
    <div class="container">
      <table class="table table-borderless" id="tinytable_1ofvv6j2nwbssfeavh4k" style="width: auto; margin-left: auto; margin-right: auto;" data-quarto-disable-processing='true'>
        <thead>
        
              <tr>
                <th scope="col">datasetid</th>
                <th scope="col">sampleid</th>
                <th scope="col">age</th>
                <th scope="col">taxon</th>
                <th scope="col">count</th>
              </tr>
        </thead>
        
        <tbody>
                <tr>
                  <td>3935</td>
                  <td>347661</td>
                  <td>236</td>
                  <td>abies_alba   </td>
                  <td>3.2258065</td>
                </tr>
                <tr>
                  <td>3935</td>
                  <td>347661</td>
                  <td>236</td>
                  <td>acer         </td>
                  <td>0.0000000</td>
                </tr>
                <tr>
                  <td>3935</td>
                  <td>347661</td>
                  <td>236</td>
                  <td>achillea_type</td>
                  <td>0.0000000</td>
                </tr>
                <tr>
                  <td>3935</td>
                  <td>347661</td>
                  <td>236</td>
                  <td>alisma       </td>
                  <td>0.0000000</td>
                </tr>
                <tr>
                  <td>3935</td>
                  <td>347661</td>
                  <td>236</td>
                  <td>alnus        </td>
                  <td>5.2419355</td>
                </tr>
                <tr>
                  <td>3935</td>
                  <td>347661</td>
                  <td>236</td>
                  <td>amaranthaceae</td>
                  <td>0.8064516</td>
                </tr>
        </tbody>
      </table>
    </div>
<!-- hack to avoid NA insertion in last line -->
```


:::
:::


Get the most common taxa

::: {.cell layout-align="center"}

```{.r .cell-code}
vec_common_taxa <-
  data_to_plot %>%
  dplyr::group_by(datasetid, taxon) %>%
  dplyr::summarise(
    .groups = "drop",
    mean_count = mean(count, na.rm = TRUE)
  ) %>%
  dplyr::group_by(datasetid) %>%
  dplyr::arrange(
    dplyr::desc(mean_count)
  ) %>%
  dplyr::slice(1:10) %>%
  dplyr::ungroup() %>%
  dplyr::pull(taxon) %>%
  unique()
```
:::

::: {.cell layout-align="center"}

```{.r .cell-code}
data_to_plot %>%
  dplyr::filter(
    taxon %in% vec_common_taxa
  ) %>%
  ggplot2::ggplot(
    mapping = ggplot2::aes(
      x = age,
      y = count,
      fill = taxon,
      col = taxon
    )
  ) +
  ggplot2::labs(
    x = "Age (cal yr BP)",
    y = "Pollen count (%)",
    title = "Pollen diagrams - Proportion of pollen taxa over time",
    subtitle = "Only 10 most common taxa per record are shown",
    caption = paste(
      "Data from Neotoma database for",
      length(unique(data_to_plot$datasetid)),
      "records"
    )
  ) +
  ggplot2::scale_x_reverse(
    breaks = scales::pretty_breaks(n = 10)
  ) +
  ggplot2::scale_y_continuous(
    limits = c(0, 100),
    breaks = scales::pretty_breaks(n = 5)
  ) +
  ggplot2::theme(
    legend.position = "none",
    axis.text.x = ggplot2::element_blank(),
    axis.ticks.x = ggplot2::element_blank(),
    panel.grid.minor = ggplot2::element_blank()
  ) +
  ggplot2::facet_grid(datasetid ~ taxon) +
  ggplot2::coord_flip() +
  ggplot2::geom_ribbon(
    mapping = ggplot2::aes(
      ymin = 0,
      ymax = count
    ),
    alpha = 0.5
  ) +
  ggplot2::geom_line()
```

::: {.cell-output-display}
![](01_neotoma2_basics_files/figure-html/7.3.-1.png){fig-align='center' width=100%}
:::
:::
