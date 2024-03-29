% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AllGenerics.R, R/headtail-methods.R
\name{headtail}
\alias{headtail}
\alias{headtail,data.frame-method}
\alias{headtail,list-method}
\alias{headtail,matrix-method}
\alias{headtail,vector-method}
\title{Return the first and last parts of an object}
\usage{
headtail(x, ...)

\S4method{headtail}{data.frame}(x, n = 2L)

\S4method{headtail}{list}(x, n = 2L)

\S4method{headtail}{matrix}(x, n = 2L)

\S4method{headtail}{vector}(x, n = 2L)
}
\arguments{
\item{x}{Object.}

\item{n}{\code{integer(1)}.
Positive integer denoting the number of first and last items to include.}

\item{...}{Additional arguments.}
}
\value{
\code{character}.
}
\description{
Applies to both rows and columns, enabling quick inspection during
interactive use.
}
\details{
Inspired by the print method for \code{DataFrame} class.
}
\section{Functions}{
\itemize{
\item \code{headtail(data.frame)}: Same method as \code{matrix}.

\item \code{headtail(list)}: Paste collapse to a \code{character(1)}.

\item \code{headtail(matrix)}: Show first and last rows.

}}
\note{
Updated 2023-09-20.
}
\examples{
data(mtcars, package = "datasets")

## atomic ====
headtail(LETTERS)

## data.frame ====
headtail(mtcars)
}
\seealso{
\itemize{
\item \code{utils::head()}, \code{utils::tail()}.
\item \code{cat()}.
}
}
