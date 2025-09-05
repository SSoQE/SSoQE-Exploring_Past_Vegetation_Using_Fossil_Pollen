# Basic functions of getting pollen data with neotoma2

Simple example of working with pollen data using the [{neotoma2} package](https://open.neotomadb.org/neotoma2/).

## Setup


::: {.cell}

```{.r .cell-code}
# load libraries
library(tidyverse) # general data wrangling and visualisation ✨
library(neotoma2) # # access to the Neotoma database 🌿
library(pander) # nice tables 😍
library(here) # for working directory 🗺️
library(janitor) # string cleaning 🧹
library(geojsonsf) # geojson spatial data 🌐
```
:::





::: {.cell layout-align="center"}

```{.r .cell-code}
# get the plot_table() function
source(
  here::here(
    "R/Functions/plot_table.R"
  )
)
```
:::


Let's practise some of the basic functions of the `{neotoma2}` package.

## Sites


::: {.cell layout-align="center"}

```{.r .cell-code}
# check the documentation
?neotoma2::get_sites()
```
:::


### Search by IDs

Search for site by a single numeric ID:


::: {.cell layout-align="center"}

```{.r .cell-code}
neotoma2::get_sites(15799) %>% 
  plot_table()
```

::: {.cell-output .cell-output-stderr}

```
Warning: package 'magrittr' was built under R version 4.5.1
```


:::

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


::: {.cell layout-align="center"}

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


Searching for Sites by Name. Note that `%` is a wildcard character:


::: {.cell layout-align="center"}

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


::: {.cell layout-align="center"}

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


::: {.cell layout-align="center"}

```{.r .cell-code}
neotoma2::get_sites(
  minage = 5000,
  maxage = 8000,
  all_data = FALSE # this will only show 25 records
) %>% 
 plot_table(head = TRUE)
```

::: {.cell-output .cell-output-stderr}

```
Warning in get_sites.default(minage = 5000, maxage = 8000, all_data = FALSE):
Some parameters seem invalid. The current accepted parameters are: sitename,
database, datasettype, altmin, altmax, loc, siteid, datasetid, doidata, gpid,
keyword, contactid, taxa, ageyoung, ageold, ageof, all_data, limit, offset
```


:::

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


::: {.cell layout-align="center"}

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


::: {.cell layout-align="center"}

```{.r .cell-code}
# check the documentation
?neotoma2::get_datasets()
```
:::


### Search by IDs


::: {.cell layout-align="center"}

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
   5                 17/2              55.25    -74.93    NA    300  

   10     Site 1 (Cohen unpublished)   30.83    -82.33    NA     36  

   15              Aguilar             -23.83   -65.75    NA    3828 

   20              Akuvaara            69.12    27.67     NA    159  
---------------------------------------------------------------------
```


:::
:::


### Search by type


::: {.cell layout-align="center"}

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

-----------------------------------------------------------------------
 siteid             sitename              lat      long    area   elev 
-------- ------------------------------ -------- -------- ------ ------
   7            Three Pines Bog            47     -80.12    NA    329  

   8          Abalone Rocks Marsh        33.96     -120     NA     9   

   9                 Adange              43.31    41.33     NA    2065 

   11     Konus Exposure, Adycha River   67.75    135.6     NA    137  

   12            Ageröds Mosse           55.93    13.43     NA     47  

   13           Aguas Calientes          -23.08   -67.4     NA    4233 
-----------------------------------------------------------------------
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
  1399        Kameničky       49.73   15.97    NA    618  

  3021          Bláto         49.04   15.19    NA    649  

  3052        Chraňbož        49.77   15.37    NA    469  

  3152        Hroznotín       49.76   15.36    NA    503  

  3168          Spolí         48.99   14.71    NA    446  

  3169     Velanská cesta     48.77   14.93    NA    494  

  3170      Červené blato     48.86   14.8     NA    475  

  3171    Borkovická blata    49.23   14.62    NA    415  

  3172         Branná         48.96   14.8     NA    434  

  3173         Barbora        48.94   14.81    NA    435  

  3174       Švarcenberk      49.14   14.7     NA    416  

  3175    Jestřebské blato    50.6    14.61    NA    244  

  3201    Komořanské jezero   50.54   13.53    NA    172  
----------------------------------------------------------
```


:::
:::


### Filter

You can additionally filter the compilation based on `lat`, `long`, `altitude`, `age_range_young`, and/or `age_range_old`


::: {.cell layout-align="center"}

```{.r .cell-code}
# check the documentation
?neotoma2::filter()
```
:::



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

::: {.cell-output .cell-output-stderr}

```
Warning in options(scipen = 9999999): invalid 'scipen' 9999999, used 9999
```


:::

::: {.cell-output .cell-output-stdout}

```

--------------------------------------------------
 siteid   sitename     lat    long    area   elev 
-------- ----------- ------- ------- ------ ------
  1399    Kameničky   49.73   15.97    NA    618  

  3021      Bláto     49.04   15.19    NA    649  
--------------------------------------------------
```


:::
:::


## Downloading data

### Download individual record

Let's download a record with `datasetid` 24279


::: {.cell layout-align="center"}

```{.r .cell-code}
dataset_24279 <-
  neotoma2::get_downloads(24279)

plot_table(
  dataset_24279@sites[[1]]@collunits[[1]])
```

::: {.cell-output .cell-output-stdout}

```

-------------------------------------------------------------------------------
 collectionunitid    handle    colldate   location   waterdepth   collunittype 
------------------ ---------- ---------- ---------- ------------ --------------
      17790         KULZERMO      NA         NA          NA           Core     
-------------------------------------------------------------------------------

Table: Table continues below

 
----------------------------------------------------------------
   collectiondevice     defaultchronology   collectionunitname  
---------------------- ------------------- ---------------------
 Russian peat sampler         14609         Kulzer Moos XIV 1-5 
----------------------------------------------------------------

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


::: {.cell layout-align="center"}

```{.r .cell-code}
# get sites information
data_sites_alex <-
neotoma2::get_sites(sitename = "Alex%") %>%
  # get datasets information
  neotoma2::get_datasets() %>%
  # get downloads
  neotoma2::get_downloads()
```

::: {.cell-output .cell-output-stderr}

```
Warning in options(scipen = 9999999): invalid 'scipen' 9999999, used 9999
```


:::

```{.r .cell-code}
plot_table(data_sites_alex)
```

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


Download all records by datasets


::: {.cell layout-align="center"}

```{.r .cell-code}
# get datasets information
data_datasets_polygon <-
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

```{.r .cell-code}
plot_table(data_datasets_polygon)
```

::: {.cell-output .cell-output-stdout}

```

--------------------------------------------------
 siteid   sitename     lat    long    area   elev 
-------- ----------- ------- ------- ------ ------
  1399    Kameničky   49.73   15.97    NA    618  

  3021      Bláto     49.04   15.19    NA    649  
--------------------------------------------------
```


:::
:::

