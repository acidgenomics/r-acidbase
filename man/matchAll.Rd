% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AllGenerics.R, R/matchAll-methods.R
\name{matchAll}
\alias{matchAll}
\alias{matchAll,character,character-method}
\alias{matchAll,factor,factor-method}
\alias{matchAll,numeric,numeric-method}
\title{Match all positions of an argument}
\usage{
matchAll(x, table, ...)

\S4method{matchAll}{character,character}(x, table, simplify = FALSE)

\S4method{matchAll}{factor,factor}(x, table, simplify = FALSE)

\S4method{matchAll}{numeric,numeric}(x, table, simplify = FALSE)
}
\arguments{
\item{x}{The values to be matched.}

\item{table}{The values to be matched against.}

\item{simplify}{\code{logical(1)}.
Unlist match list into a positional vector.}

\item{...}{Additional arguments.}
}
\value{
\code{list}.
A list of positional vectors corresponding to values defined in \code{table} the
same size as \code{x}.
}
\description{
Match all positions of an argument
}
\details{
\code{matchAll()} behaves like base \code{match()}, but is intended to return a list
of all position matches of the argument defined in \code{x}.
}
\note{
Updated 2023-12-15.
}
\examples{
## character ====
x <- c("c", "b", "a")
table <- c("a", "b", "c", "a", "b", "c")
i <- matchAll(x = x, table = table, simplify = FALSE)
print(i)
i <- matchAll(x = x, table = table, simplify = TRUE)
print(i)
}
