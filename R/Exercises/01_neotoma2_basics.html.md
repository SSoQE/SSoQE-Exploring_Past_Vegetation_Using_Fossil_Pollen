---
format:
  html:
    author: "Ondřej Mottl"
    date: 2024/09/23
    date-format: long
    date-modified: last-modified
    toc: true
    keep-md: true
    code-link: false
    embed-resources: true
    code-line-numbers: true
    theme: [default, ../../Presentation/custom_theme.scss]
    highlight-style: none
execute: 
  cache: true
---

# Basic functions of neotoma2 : Working with pollen data

Simple example of woking with pollen data using the [{neotoma2} package](https://open.neotomadb.org/neotoma2/).

## Setup


::: {.cell}

```{.r .cell-code}
# load libraries
library(tidyverse) # general data wrangling and visualisation ✨
library(neotoma2) # # access to the Neotoma database 🌿
library(pander) # nice tables 😍
library(here) # for working directory 🗺️
library(janitor) # string cleaning 🧹
library(jsonlite) # for reading JSON files 📄
library(geojsonsf) # geojson spatial data 🌐

# set the working directory
here::i_am("R/Exercises/01_neotoma2_basics.qmd")

# source the plot_table() function
source(
  here::here(
    "R/Functions/plot_table.R"
  )
)

# quarto render options
options(htmltools.dir.version = FALSE)
knitr::opts_chunk$set(
  fig.width = 7,
  fig.height = 7,
  fig.align = "center",
  out.width = "100%",
  echo = TRUE
)
```
:::


## Sites


::: {.cell}

```{.r .cell-code}
# check the documentation
?neotoma2::get_sites()
```
:::


### Search by IDs

Search for site by a single numeric ID:


::: {.cell}

```{.r .cell-code}
neotoma2::get_sites(15799) %>% 
  plot_table()
```

::: {.cell-output .cell-output-stdout}

```

----------------------------------------------------
 siteid    sitename      lat    long    area   elev 
-------- ------------- ------- ------- ------ ------
 15799    Kulzer Moos   49.39   12.45    NA    466  
----------------------------------------------------
```


:::
:::


Search for sites with multiple IDs:


::: {.cell}

```{.r .cell-code}
neotoma2::get_sites(
  c(15799, 15683)
) %>% 
  plot_table()
```

::: {.cell-output .cell-output-stdout}

```

----------------------------------------------------
 siteid    sitename      lat    long    area   elev 
-------- ------------- ------- ------- ------ ------
 15683     Windbruch    49.61   12.54    NA    495  

 15799    Kulzer Moos   49.39   12.45    NA    466  
----------------------------------------------------
```


:::
:::


Searching for Sites by Name. Notet that `%` is a wildcard character:


::: {.cell}

```{.r .cell-code}
neotoma2::get_sites(sitename = "Alex%") %>% 
  plot_table()
```

::: {.cell-output .cell-output-stderr}

```
Warning in options(scipen = 9999999): invalid 'scipen' 9999999, used 9999
```


:::

::: {.cell-output .cell-output-stdout}

```

------------------------------------------------------------
 siteid        sitename         lat     long    area   elev 
-------- -------------------- ------- -------- ------ ------
   24       Alexander Lake     53.33   -60.58    NA     73  

   25        Alexis Lake       52.52   -57.03    NA    193  

  4478    Alexander [3CN117]   35.25   -92.62    NA    180  

 26226      Alexandra Lake     43.29   -74.17    NA    351  
------------------------------------------------------------
```


:::
:::


### Searching for Sites by Age

Record span at least 8200 years:


::: {.cell}

```{.r .cell-code}
neotoma2::get_sites(
  ageof = 8200,
  all_data = FALSE # this will only show 25 records
) %>% 
 plot_table(head = TRUE)
```

::: {.cell-output .cell-output-stderr}

```
Warning in options(scipen = 9999999): invalid 'scipen' 9999999, used 9999
```


:::

::: {.cell-output .cell-output-stdout}

```

-----------------------------------------------------------------------
 siteid             sitename              lat      long    area   elev 
-------- ------------------------------ -------- -------- ------ ------
   11     Konus Exposure, Adycha River   67.75    135.6     NA    137  

   12            Ageröds Mosse           55.93    13.43     NA     47  

   15               Aguilar              -23.83   -65.75    NA    3828 

   19       Akulinin Exposure P1282      47.12    138.6     NA    367  

   20               Akuvaara             69.12    27.67     NA    159  

   25             Alexis Lake            52.52    -57.03    NA    193  
-----------------------------------------------------------------------
```


:::
:::


Record must PARTLY span the age range


::: {.cell}

```{.r .cell-code}
neotoma2::get_sites(
  minage = 5000,
  maxage = 8000,
  all_data = FALSE # this will only show 
) %>% 
 plot_table(head = TRUE)
```

::: {.cell-output .cell-output-stderr}

```
Warning in options(scipen = 9999999): invalid 'scipen' 9999999, used 9999
```


:::

::: {.cell-output .cell-output-stdout}

```

-----------------------------------------------------------------------
 siteid             sitename              lat      long    area   elev 
-------- ------------------------------ -------- -------- ------ ------
   7            Three Pines Bog            47     -80.12    NA    329  

   8          Abalone Rocks Marsh        33.96     -120     NA     9   

   9                 Adange              43.31    41.33     NA    2065 

   11     Konus Exposure, Adycha River   67.75    135.6     NA    137  

   12            Ageröds Mosse           55.93    13.43     NA     47  

   15               Aguilar              -23.83   -65.75    NA    3828 
-----------------------------------------------------------------------
```


:::
:::


Record must COMPLETELY span the age range


::: {.cell}

```{.r .cell-code}
neotoma2::get_sites(
  ageyoung = 5000,
  ageold = 8000,
  all_data = FALSE # this will only show 25 records
) %>% 
 plot_table(head = TRUE)
```

::: {.cell-output .cell-output-stderr}

```
Warning in options(scipen = 9999999): invalid 'scipen' 9999999, used 9999
```


:::

::: {.cell-output .cell-output-stdout}

```

-----------------------------------------------------------------------
 siteid             sitename              lat      long    area   elev 
-------- ------------------------------ -------- -------- ------ ------
   11     Konus Exposure, Adycha River   67.75    135.6     NA    137  

   12            Ageröds Mosse           55.93    13.43     NA     47  

   15               Aguilar              -23.83   -65.75    NA    3828 

   19       Akulinin Exposure P1282      47.12    138.6     NA    367  

   20               Akuvaara             69.12    27.67     NA    159  

   25             Alexis Lake            52.52    -57.03    NA    193  
-----------------------------------------------------------------------
```


:::
:::


## Datasets

You can search by all the same age properties as for sites (`ageof`, `minage`, `maxage`, `ageyoung`, `ageold`).


::: {.cell}

```{.r .cell-code}
# check the documentation
?neotoma2::get_datasets()
```
:::


### Search by IDs


::: {.cell}

```{.r .cell-code}
neotoma2::get_datasets(
  c(5, 10, 15, 20)
) %>% 
 plot_table(head = TRUE)
```

::: {.cell-output .cell-output-stdout}

```

---------------------------------------------------------------------
 siteid            sitename             lat      long    area   elev 
-------- ---------------------------- -------- -------- ------ ------
   15              Aguilar             -23.83   -65.75    NA    3828 

   10     Site 1 (Cohen unpublished)   30.83    -82.33    NA     36  

   5                 17/2              55.25    -74.93    NA    300  

   20              Akuvaara            69.12    27.67     NA    159  
---------------------------------------------------------------------
```


:::
:::


### Search by type


::: {.cell}

```{.r .cell-code}
neotoma2::get_datasets(
  all_data = FALSE, # running with `all_data = TRUE` is heavy on the server
  datasettype = "pollen"
) %>% 
 plot_table(head = TRUE)
```

::: {.cell-output .cell-output-stderr}

```
Warning in options(scipen = 9999999): invalid 'scipen' 9999999, used 9999
```


:::

::: {.cell-output .cell-output-stdout}

```

------------------------------------------------------------------------
 siteid             sitename               lat      long    area   elev 
-------- ------------------------------- -------- -------- ------ ------
  1712          18 [Moraine Lake]         52.27    -58.05    NA    388  

  1511         Kotyrkol' Peat Bog         52.96    70.38     NA    435  

   15                Aguilar              -23.83   -65.75    NA    3828 

   70     Amguema River Valley Exposure    67.3    178.8     NA    552  
                        3                                               

  1644         Molotkovskii Kamen         68.33    161.5     NA     6   

  1121        Ivanovskoye Peat Bog        56.82    38.77     NA    152  
------------------------------------------------------------------------
```


:::
:::


### Search by geo location

Go to [geojson.io](https://geojson.io/) and get the coordinates of a polygon.

For example:


::: {.cell}

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
                  ...
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


::: {.cell}

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

::: {.cell-output .cell-output-stderr}

```
Warning in options(scipen = 9999999): invalid 'scipen' 9999999, used 9999
```


:::

::: {.cell-output .cell-output-stdout}

```

----------------------------------------------------------------
 siteid          sitename            lat    long    area   elev 
-------- ------------------------- ------- ------- ------ ------
 31819             Pěkná            48.84   13.94    NA    730  

  3377           Řežabinec          49.25   14.09    NA    365  

 15721      Teplice nad Metují      50.59   16.18    NA    474  

 14274        Stráženská slať       48.9    13.74    NA    792  

  3519        Zbudovská blata       49.07   14.35    NA    379  

  3289      Mokré louky (South)      49     14.78    NA    421  

  3201       Komořanské jezero      50.54   13.53    NA    172  

 24031          Kolbermoor          47.86   12.07    NA    460  

 31420            Mondsee           47.82   13.38    NA    481  

 14266        Teplické údolí        50.59   16.13    NA    676  

 31463    Mondsee (lake), Seeache   47.8    13.45    NA    479  
              (stream) outlet                                   

 28329           Tüttensee          47.85   12.57    NA    535  

 13451            Zahájí            50.38   14.12    NA    215  

 31477    Mondsee (lake), Bay of    47.81   13.39    NA    479  
                 Mooswinkl                                      

 29155     Pod Šindelným vrchem     49.67   15.96    NA    699  

 29133             Bahna            49.75   15.99    NA    645  

  3171       Borkovická blata       49.23   14.62    NA    415  

 14272           Malá niva          48.91   13.81    NA    749  

 29148          Nový Rybník         49.8    15.82    NA    561  

 15765    Mělnický úval - Přívory   50.3    14.58    NA    171  

 26991       Prášilské jezero       49.08   13.4     NA    1086 

 24140            Zeifen            47.93   12.83    NA    426  

 15778             Kožlí            49.38   14.03    NA    462  

 15732       Úpské rašeliniště      50.74   15.71    NA    1420 
----------------------------------------------------------------
```


:::
:::


### Filter

You can additionally filter the compilation based on `lat`, `long`, `altitude`, `age_range_young`, and/or `age_range_old`


::: {.cell}

```{.r .cell-code}
# check the documentation
?neotoma2::filter()
```
:::



::: {.cell}

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

::: {.cell-output .cell-output-stderr}

```
Warning in options(scipen = 9999999): invalid 'scipen' 9999999, used 9999
```


:::

::: {.cell-output .cell-output-stdout}

```

----------------------------------------------------------
 siteid       sitename         lat    long    area   elev 
-------- ------------------- ------- ------- ------ ------
 31819          Pěkná         48.84   13.94    NA    730  

 14274     Stráženská slať    48.9    13.74    NA    792  

 14266     Teplické údolí     50.59   16.13    NA    676  

 28329        Tüttensee       47.85   12.57    NA    535  

 14272        Malá niva       48.91   13.81    NA    749  

 26991    Prášilské jezero    49.08   13.4     NA    1086 

 15732    Úpské rašeliniště   50.74   15.71    NA    1420 
----------------------------------------------------------
```


:::
:::


## Downloading data

### Download individual record

Let's download a record with `datasetid` 24279


::: {.cell}

```{.r .cell-code}
dataset_24279 <-
  neotoma2::get_downloads(24279)
```

::: {.cell-output .cell-output-stdout}

```
.
```


:::

```{.r .cell-code}
plot_table(
  dataset_24279@sites[[1]]@collunits[[1]])
```

::: {.cell-output .cell-output-stdout}

```

-------------------------------------------------------------------------------
 collectionunitid    handle    colldate   location   waterdepth   collunittype 
------------------ ---------- ---------- ---------- ------------ --------------
      17790         KULZERMO      NA         NA          NA            NA      
-------------------------------------------------------------------------------

Table: Table continues below

 
---------------------------------------------------------------
   collectiondevice     defaultchronology   collectionunitname 
---------------------- ------------------- --------------------
 Russian peat sampler         14609                 NA         
---------------------------------------------------------------

Table: Table continues below

 
-------------------------
 depositionalenvironment 
-------------------------
           Fen           
-------------------------
```


:::
:::


### Download multiple records

Download all records by sites


::: {.cell}

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
Warning in options(scipen = 9999999): invalid 'scipen' 9999999, used 9999
```


:::

::: {.cell-output .cell-output-stderr}

```
Warning in get_datasets.sites(.): SiteID 26226 or DatasetID NA does not exist in the Neotoma DB yet or it has been removed. 
                        It will be removed from your search.
```


:::

::: {.cell-output .cell-output-stdout}

```
.........
------------------------------------------------------------
 siteid        sitename         lat     long    area   elev 
-------- -------------------- ------- -------- ------ ------
   24       Alexander Lake     53.33   -60.58    NA     73  

  4478    Alexander [3CN117]   35.25   -92.62    NA    180  

 26226      Alexandra Lake     43.29   -74.17    NA    351  

   25        Alexis Lake       52.52   -57.03    NA    193  
------------------------------------------------------------
```


:::
:::


Download all records by datasets


::: {.cell}

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

::: {.cell-output .cell-output-stderr}

```
Warning in options(scipen = 9999999): invalid 'scipen' 9999999, used 9999
```


:::

::: {.cell-output .cell-output-stdout}

```
........
----------------------------------------------------------
 siteid       sitename         lat    long    area   elev 
-------- ------------------- ------- ------- ------ ------
 31819          Pěkná         48.84   13.94    NA    730  

 26991    Prášilské jezero    49.08   13.4     NA    1086 

 15732    Úpské rašeliniště   50.74   15.71    NA    1420 

 14266     Teplické údolí     50.59   16.13    NA    676  

 14274     Stráženská slať    48.9    13.74    NA    792  

 14272        Malá niva       48.91   13.81    NA    749  

 28329        Tüttensee       47.85   12.57    NA    535  
----------------------------------------------------------
```


:::
:::


## Working with pollen counts

### Get samples

download all records by datasets


::: {.cell}

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

::: {.cell-output .cell-output-stderr}

```
Warning in options(scipen = 9999999): invalid 'scipen' 9999999, used 9999
```


:::

::: {.cell-output .cell-output-stdout}

```
........
```


:::
:::



::: {.cell}

```{.r .cell-code}
# check the documentation
?neotoma2::samples()
```
:::


Extract Sample information


::: {.cell}

```{.r .cell-code}
data_selected_samples <-
  neotoma2::samples(data_selected_downloads) %>%
  as.data.frame() %>%
  tibble::as_tibble() %>%
  dplyr::mutate(
    datasetid_sampleid = paste0(datasetid, "_", sampleid)
  )

plot_table(
  data_selected_samples[1:5, c("age","variablename", "value")])
```

::: {.cell-output .cell-output-stdout}

```

-----------------------------------
 age      variablename       value 
----- --------------------- -------
 -68     Sample quantity       1   

 -68       Cyperaceae          1   

 -68   Plantago lanceolata     1   

 -68       Prunus-type         1   

 -68        Vaccinium          1   
-----------------------------------
```


:::
:::


### Get pollen counts


::: {.cell}

```{.r .cell-code}
# check the documentation
?neotoma2::taxa()
```
:::


Get vector of all "pollen" taxa


::: {.cell}

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
[1] "Abies"         "Abies alba"    "Acer"          "Achillea-type"
[5] "Aconitum"      "Aconitum-type"
```


:::
:::


Get pollen counts


::: {.cell}

```{.r .cell-code}
data_sample_pollen_counts <-
  data_selected_samples %>%
  dplyr::select("datasetid_sampleid", "value", "variablename") %>%
  # only include selected taxons
  dplyr::filter(
    variablename %in% vec_taxa_pollen
  ) %>%
  # now we need to remove duplicates
  dplyr::group_by(
    datasetid_sampleid, variablename
  ) %>%
  dplyr::summarise(
    value = sum(value, na.rm = TRUE),
    .groups = "drop"
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

plot_table(data_sample_pollen_counts[1:5, 1:5]) 
```

::: {.cell-output .cell-output-stdout}

```

----------------------------------------------------------------
 datasetid_sampleid   abies   abies_alba   acer   achillea_type 
-------------------- ------- ------------ ------ ---------------
    22322_216317       24         0         0           0       

    22322_216318       122        0         0           0       

    22322_216319       154        0         1           0       

    22322_216320       170        0         0           0       

    22322_216321       232        0         2           0       
----------------------------------------------------------------
```


:::
:::


### Getting the age information


::: {.cell}

```{.r .cell-code}
data_sample_age <-
  data_selected_samples %>%
  dplyr::distinct(datasetid_sampleid, depth, age) %>%
  dplyr::arrange(datasetid_sampleid, age)

plot_table(data_sample_age, head = TRUE)
```

::: {.cell-output .cell-output-stdout}

```

----------------------------------
 datasetid_sampleid   depth   age 
-------------------- ------- -----
    22322_216316        0     -50 

    22322_216317        5     45  

    22322_216318       10     140 

    22322_216319       20     331 

    22322_216320       30     521 

    22322_216321       45     807 
----------------------------------
```


:::
:::


### Plotting pollen diagram

Data wrangling


::: {.cell}

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

::: {.cell-output .cell-output-stdout}

```

----------------------------------------------------
 datasetid   sampleid   age       taxon       count 
----------- ---------- ----- --------------- -------
   22322      216317    45        abies       9.125 

   22322      216317    45     abies_alba       0   

   22322      216317    45        acer          0   

   22322      216317    45    achillea_type     0   

   22322      216317    45      aconitum        0   

   22322      216317    45    aconitum_type     0   
----------------------------------------------------
```


:::
:::


Get the most common taxa


::: {.cell}

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



::: {.cell}

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
![](01_neotoma2_basics_files/figure-html/7.3.-1.png){width=672}
:::
:::

