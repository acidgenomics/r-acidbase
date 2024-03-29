% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fileDepth.R
\name{fileDepth}
\alias{fileDepth}
\title{File depth}
\usage{
fileDepth(path)
}
\arguments{
\item{path}{\code{character}.
File path(s).
This function is vectorized and supports multiple files.}
}
\value{
\code{integer}.
Unnamed vector denoting file path depth.
Note that "/" will return 0 here (zero indexed).
}
\description{
File depth
}
\details{
This function intentionally doesn't check whether a file exists.
}
\note{
Updated 2022-05-31.
}
\examples{
a <- tempdir()
b <- tempfile()
fileDepth(c(a, b))
}
