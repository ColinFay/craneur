#' Craneur
#'
#' R6 class for RA? creation
#'
#' @section Methods:
#' \describe{
#'   \item{\code{name}}{name of the RAN}
#'   \item{\code{add_package}}{add a source package to the RAN}
#'   \item{\code{packages}}{Current packages in the RAN}
#'   \item{\code{paths}}{Paths to packages in the RAN}
#'   \item{\code{write}}{Save the RAN}
#'}
#'
#' @importFrom R6 R6Class
#'
#' @export
#'
#' @examples
#' \dontrun{
#' library(craneur)
#' colin <- Craneur$new("Colin")
#' colin$add_package("../craneur_0.0.0.9000.tar.gz")
#' colin$add_package("../jekyllthat_0.0.0.9000.tar.gz")
#' colin$add_package("../tidystringdist_0.1.2.tar.gz")
#' colin$add_package("../attempt_0.2.1.tar.gz")
#' colin$add_package("../rpinterest_0.4.0.tar.gz")
#' colin$add_package("../rgeoapi_1.2.0.tar.gz")
#' colin$add_package("../proustr_0.3.0.9000.tar.gz")
#' colin$add_package("../languagelayeR_1.2.3.tar.gz")
#' colin$add_package("../fryingpane_0.0.0.9000.tar.gz")
#' colin$add_package("../dockerfiler_0.1.1.tar.gz")
#' colin$add_package("../devaddins_0.0.0.9000.tar.gz")
#' colin$write(path = ".")}

Craneur <- R6::R6Class("Craneur",
                       public = list(
                         initialize = function(name){
                          self$name <- name
                         },
                         name = character(0),
                         add_package = function(path){
                           name <- gsub(".*\\/(.*)_.*", "\\1", path)
                           parsed <- parse_pkg(name, path)
                           self$packages[[parsed$Package]] <- parsed
                           self$paths[[parsed$Package]] <- path
                         },
                         packages = list(),
                         paths = list(),
                         print = function(){
                           print(data.frame(package = names(self$paths),
                                      path = as.character(self$paths)))
                         },
                         write = function(path = ".", index = TRUE){
                           save_packages(name = self$name,
                                         pkg = self$packages,
                                         paths = self$paths,
                                         path = path)
                         }
                       ))


#' @importFrom attempt stop_if_not
#' @importFrom tools file_ext md5sum
#' @importFrom utils untar
#' @importFrom desc description

parse_pkg <- function(name, path){
  stop_if_not(path, ~ file_ext(.x) == "gz", "Please provide a tar.gz")
  tmp_dir <- tempdir()
  on.exit(
    unlink(tmp_dir)
  )
  untar(normalizePath(path), exdir = tmp_dir)
  l <- list.files(tmp_dir, all.files = TRUE, recursive = TRUE, full.names = TRUE)
  greped_desc <- description$new(grep(paste0(name, "/","DESCRIPTION"), l, value = TRUE))
  list(
    Package = greped_desc$get("Package"),
    Version = paste(greped_desc$get_version(), sep = "."),
    Imports = greped_desc$get("Imports"),
    Depends = greped_desc$get("Depends"),
    Suggests = greped_desc$get("Suggests"),
    License = greped_desc$get("License"),
    MD5sum = md5sum(path),
    NeedsCompilation = if(any(grepl("src", l))) "yes" else "no"
    )
}

# parse_pkg("nmviewer","../nmviewer_0.3.0.tar.gz")

one_package <- function(vec){
  vec <- vec[ ! is.na(vec) ]
  paste(names(vec), vec, sep = ": ", collapse = "\n")
}

build_PACKAGES <- function(list){
  paste(lapply(list, one_package), collapse = "\n\n")
}

save_packages <- function(name, pkg, paths, path = ".", build_index = TRUE){
  location <- file.path(normalizePath(path),"src", "contrib")
  dir.create(location, recursive = TRUE, showWarnings = FALSE)
  pkg <- build_PACKAGES(pkg)
  write(pkg, file.path(location, "PACKAGES"))
  file.copy(as.character(paths), location, overwrite = TRUE)
  l <- list.files(location, pattern = "tar.gz")
  if (build_index) build_index(l, name, location)
}

#' @importFrom glue glue

build_index <- function(paths, name, location){
  pkg_list <- lapply(paths, function(x){
    glue('<li><a href="{x}">{x}</a></li>')
  })
  html <- glue('<!DOCTYPE html>
        <html lang="en">
        <head>
        <meta charset="utf-8">
        <title>{name} R Archive Network</title>
        </head>
        <body>
        <h2>{name} R Archive Network</h2>
        <p>List of available packages:</p>
        <ul>
        {paste(pkg_list, collapse = "\n")}
        </ul>
        </body>
        </html>')
  write(html, file.path(location, "index.html"))

  md <- glue('## {name} R Archive Network\n\nList of available packages:\n\n{paste("+ [", paths, "](", paths, ")", collapse = "\n")}')

  write(md, file.path(location, "index.md"))

}


