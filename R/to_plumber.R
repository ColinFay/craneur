#' Create a plumberfile that simulates a RAN
#'
#' @param from the `src/` folder
#' @param to where to write the plumber folder
#'
#' @return writes a folder with a plumber.R and the src
#' @export
#'
#' @examples
#' \dontrun{
#'  to_plumber(from = "inst/src/", to = "inst/plumb")
#' }

to_plumber <- function(from, to){
  l_f <- list.files( file.path(from, "contrib"), pattern = "tar.gz$")
  if (!dir.exists(to)) dir.create(to)
  file.copy(from, to, recursive = TRUE)
  file.create( file.path(to, "plumber.R") )
  write_here <- function(...){
    write(..., file = file.path(to, "plumber.R"), append = TRUE)
  }
  write_here("library(plumber)")
  write_here("\n")
  write_here("#* @apiTitle Plumber RAN")
  write_here("\n")
  write_here('#* @serializer contentType list(type="text/plain")')
  write_here("#* @get /src/contrib/PACKAGES")
  write_here("\n")
  write_here("function(){")
  write_here("    tmp <- tempfile()")
  write_here('    PACKAGE <- readLines("src/contrib/PACKAGES")')
  write_here("    for (i in seq_along(PACKAGE)){")
  write_here("    write(PACKAGE[i], tmp, append = TRUE)")
  write_here("    }")
  write_here('    readBin(tmp, "raw", n=file.info(tmp)$size)')
  write_here("}")
  write_here("\n")

  for (i in seq_along(l_f)){
    write_here('#* @serializer contentType list(type="application/x-tar")')
    write_here(glue('#* @get /src/contrib/{l_f[i]}'))
    write_here('function(){')
    write_here('    tmp <- tempfile()')
    write_here(glue('    file.copy(normalizePath("src/contrib/{l_f[i]}"), tmp)'))
    write_here(glue('    readBin(tmp, "raw", n=file.info(tmp)$size)'))
    write_here('}')
    write_here('\n')
  }
  return(file.path(to, "plumber.R"))
}


