% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ram.R
\name{ram}
\alias{ram}
\title{Return system random access memory (RAM) information}
\usage{
ram(type = c("total", "free"), units = "GB", digits = 0L)
}
\arguments{
\item{type}{\code{character(1)}.
Type of RAM to return, either \code{"total"} or \code{"free"}.}

\item{units}{\code{character(1)}.
Size format.}

\item{digits}{\code{integer(1)}.
Number of significant digits to include.}
}
\value{
\code{numeric(1)}.
}
\description{
Return system random access memory (RAM) information
}
\details{
Requires the memuse package to be installed.
}
\note{
Updated 2023-11-10.
}
\examples{
ram(type = "total", units = "GB")
ram(type = "free", units = "GB")
}
\seealso{
\itemize{
\item memuse package.
\item https://stackoverflow.com/questions/29787452/
\item \code{help("object.size")}
}
}
