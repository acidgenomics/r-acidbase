% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AllGenerics.R, R/showHeader-methods.R
\name{showHeader}
\alias{showHeader}
\alias{showHeader,ANY-method}
\alias{showHeader,Annotated-method}
\title{Header for object show method}
\usage{
showHeader(object, ...)

\S4method{showHeader}{ANY}(object)

\S4method{showHeader}{Annotated}(object)
}
\arguments{
\item{object}{Object.}

\item{...}{Additional arguments.}
}
\value{
Console output, via \code{\link[base:cat]{cat()}}.
}
\description{
Header for object show method
}
\note{
Updated 2023-10-06.
}
\examples{
data(
    DFrame,
    matrix,
    package = "AcidTest"
)

## ANY (matrix) ====
object <- matrix
showHeader(object)

## Annotated ====
## This virtual class supports `metadata()` slot.
object <- DFrame
showHeader(object)
S4Vectors::metadata(object)[["packageVersion"]] <- package_version("0.0.1")
showHeader(object)
}
\seealso{
\code{\link[=show]{show()}}.
}
