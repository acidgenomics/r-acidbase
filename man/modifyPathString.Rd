% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pathString.R
\name{modifyPathString}
\alias{modifyPathString}
\alias{addToPathEnd}
\alias{addToPathStart}
\alias{removeFromPath}
\title{System path string handlers}
\usage{
addToPathEnd(x, var = "PATH")

addToPathStart(x, var = "PATH")

removeFromPath(x, var = "PATH")
}
\arguments{
\item{x}{\code{character}.
Elements to add to the system path string defined in \code{var}.}

\item{var}{\code{character(1)}.
System environment variable name.
Hands off to \code{Sys.getenv} and \code{Sys.setenv} internally.
Intended for use with \code{"PATH"}, \code{"FPATH"}, \code{"MANPATH"}, etc.}
}
\value{
Invisible \code{character(1)}.
Path string.
}
\description{
System path string handlers
}
\section{Functions}{
\itemize{
\item \code{addToPathEnd()}: Note that input defined in \code{x} is reversed internally, so the first element
in the vector is added to the end of the path string.

}}
\note{
Updated 2021-08-23.
}
\examples{
x <- c("/usr/local/bin", "/usr/bin")
var <- "TESTPATH"
Sys.unsetenv(var)

addToPathEnd(x = x, var = var)
Sys.getenv(var)

removeFromPath(x = x, var = var)
Sys.getenv(var)

addToPathStart(x = x, var = var)
Sys.getenv(var)
}
