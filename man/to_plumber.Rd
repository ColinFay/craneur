% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/to_plumber.R
\name{to_plumber}
\alias{to_plumber}
\title{Create a plumberfile that simulates a RAN}
\usage{
to_plumber(from, to)
}
\arguments{
\item{from}{the `src/` folder}

\item{to}{where to write the plumber folder}
}
\value{
writes a folder with a plumber.R and the src
}
\description{
Create a plumberfile that simulates a RAN
}
\examples{
\dontrun{
 to_plumber(from = "inst/src/", to = "inst/plumb")
}
}
