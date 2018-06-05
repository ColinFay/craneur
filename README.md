
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
install.packages("pkg", repos = "my_repos.com", type = "source")
```

For example
:

``` r
install.packages("attempt", repos = "https://colinfay.me", type = "source")
```

## Here comes `{craneur}`

`craneur` provides a user-friendly API for creating this skeleton :
`PACKAGES` file, tar.gz, and a minimal `index.html`. Note that for now
you need to specify if your package needs compilation.

``` r
library(craneur)
colin <- Craneur$new("Colin")
colin$add_package("../craneur_0.0.0.9000.tar.gz")
colin$add_package("../jekyllthat_0.0.0.9000.tar.gz")
colin$add_package("../tidystringdist_0.1.2.tar.gz")
colin$add_package("../attempt_0.2.1.tar.gz")
colin$add_package("../rpinterest_0.4.0.tar.gz")
colin$add_package("../rgeoapi_1.2.0.tar.gz")
colin$add_package("../proustr_0.3.0.9000.tar.gz")
colin$add_package("../languagelayeR_1.2.3.tar.gz")
colin$add_package("../fryingpane_0.0.0.9000.tar.gz")
colin$add_package("../dockerfiler_0.1.1.tar.gz")
colin$add_package("../devaddins_0.0.0.9000.tar.gz")
colin
#>           package                            path
#> 1         craneur    ../craneur_0.0.0.9000.tar.gz
#> 2      jekyllthat ../jekyllthat_0.0.0.9000.tar.gz
#> 3  tidystringdist  ../tidystringdist_0.1.2.tar.gz
#> 4         attempt         ../attempt_0.2.1.tar.gz
#> 5      rpinterest      ../rpinterest_0.4.0.tar.gz
#> 6         rgeoapi         ../rgeoapi_1.2.0.tar.gz
#> 7         proustr    ../proustr_0.3.0.9000.tar.gz
#> 8   languagelayeR   ../languagelayeR_1.2.3.tar.gz
#> 9      fryingpane ../fryingpane_0.0.0.9000.tar.gz
#> 10    dockerfiler     ../dockerfiler_0.1.1.tar.gz
#> 11      devaddins  ../devaddins_0.0.0.9000.tar.gz
```

Create it:

``` r
colin$write(path = ".")
```

This creates a “src/contrib” folder, and copies all the tar.gz into this
folder.

You can now put the full “src/contrib” folder onto your server.

For example, if I put “src/contrib” at the root of
“<https://colinfay.me>”, here the index:
<https://colinfay.me/src/contrib/>

You can now install with
:

``` r
install.packages("craneur", repos = "https://colinfay.me", type = "source")
install.packages("jekyllthat", repos = "https://colinfay.me", type = "source")
install.packages("tidystringdist", repos = "https://colinfay.me", type = "source")
install.packages("attempt", repos = "https://colinfay.me", type = "source")
install.packages("rpinterest", repos = "https://colinfay.me", type = "source")
install.packages("rgeoapi", repos = "https://colinfay.me", type = "source")
install.packages("proustr", repos = "https://colinfay.me", type = "source")
install.packages("languagelayeR", repos = "https://colinfay.me", type = "source")
install.packages("fryingpane", repos = "https://colinfay.me", type = "source")
install.packages("dockerfiler", repos = "https://colinfay.me", type = "source")
install.packages("devaddins", repos = "https://colinfay.me", type = "source")
```

## Personnalise home page

You can rewrite your index.html by reknitting the index.Rmd you’ll find
in the directory.

## Prior work

See also:

  - `{drat}`: <https://github.com/eddelbuettel/drat>

## CoC

Please note that this project is released with a [Contributor Code of
Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree
to abide by its terms.
