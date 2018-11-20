
<!-- README.md is generated from README.Rmd. Please edit that file -->

[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

> Disclaimer: this is experimental, use deliberately and with caution.

# craneur

The goal of craneur is to provide an easy way to Create your own “R
Archive
Network”.

## Install {craneur}

``` r
install.packages("craneur", repos = "https://colinfay.me", type = "source")
```

## Why would you use `{craneur}`?

Creating your own R archive repository can be useful for:

  - Not depending on GitHub for your dev packages
  - Internal uses in your company, lab, university…
  - Because you’re a nerd and find it cool

## How does it work?

A R archive repo is a location where you can download R packages with
the `install.packages` function.

This location is composed of, roughly:

  - a `PACKAGES` file
  - the `tar.gz` of your packages

These elements should be put inside a `src/contrib` folder.

Once you’ve installed that, you can do :

``` r
install.packages("pkg", repos = "../craneur", type = "source")
```

For example
:

``` r
install.packages("attempt", repos = "https://colinfay.me", type = "source")
```

## Here comes `{craneur}`

`craneur` provides a user-friendly API for creating this skeleton :
`PACKAGES` file, tar.gz, and a minimal `index.html`.

``` r
library(craneur)
colin <- Craneur$new("Colin")
colin$add_package("../attempt_0.3.0.9000.tar.gz")
colin$add_package("../shinipsum_0.0.0.9000.tar.gz")
colin
```

Create it:

``` r
colin$write(path = "inst")
```

This creates a “src/contrib” folder, and copies all the tar.gz into this
folder.

For a bulk import, you can :

``` r
colin <- Craneur$new("Colin")
lapply(list.files("../", pattern = "tar.gz", full.names = TRUE), function(x) colin$add_package(x))
```

### Put on your sever

You can now put the full “src/contrib” folder onto your server.

For example, if I put “src/contrib” at the root of
“<https://colinfay.me>”, here the index:
<https://colinfay.me/src/contrib/>

You can now install with
:

``` r
install.packages("attempt", repos = "https://colinfay.me", type = "source")
install.packages("shinipsum", repos = "https://colinfay.me", type = "source")
```

## As a plumber API

The function `to_plumber()` takes a `src` directory, and creates a
plumber file. Once launched, this plumber API can be used as a RAN.

``` r
# Suppose you have your src built in inst/src
to_plumber(from = "inst/src/", to = "inst/plumb")
oldwd <- setwd("inst/plumb")
library(plumber)
p <- plumber$new("plumber.R")
p$run()
setwd(oldwd)
```

If you open a new session, you can go
do:

``` r
install.packages("shinipsum", repo = "http://127.0.0.1:6091", type = "source")
```

Why would you want to do that?

You can deploy this “plumber-ran” on RStudio Connect, or on any other
server (in a Docker, for example).

This, for example, allows to use a local package for deploying a shiny
app in RConnect, in two steps:

  - Launch the API:

<!-- end list -->

``` r
library(craneur)
colin <- Craneur$new("Colin")
colin$add_package("../attempt_0.3.0.9000.tar.gz")
colin$add_package("../shinipsum_0.0.0.9000.tar.gz")
colin$write()
to_plumber(from = "inst/src/", to = "inst/plumb")
rsconnect::deployAPI("inst/plumb")
```

  - Use the API:

<!-- end list -->

``` r
# Then, in your app 
adress_of_api <- "XXX"
withr::with_options(
  list(
    pkgType = "source", 
    repos = c( adress_of_api, oldRepos)
  ), 
  rsconnect::deployApp(appDir = "inst/app")
)
```

## Personnalise home page

You can rewrite your index.html by reknitting the index.Rmd you’ll find
in the directory.

## Prior work

See also:

  - `{drat}`: <https://github.com/eddelbuettel/drat>
  - `{cranlike}`: <https://github.com/r-hub/cranlike>
  - `{packrat}`: <https://github.com/rstudio/packrat>

## CoC

Please note that this project is released with a [Contributor Code of
Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree
to abide by its terms.
