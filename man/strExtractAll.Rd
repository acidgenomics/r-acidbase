% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/strExtractAll.R
\name{strExtractAll}
\alias{strExtractAll}
\title{Extract all pattern occurances}
\usage{
strExtractAll(x, pattern, fixed = FALSE)
}
\arguments{
\item{x}{\code{character}.
Character vector. \code{NA} values are allowed.}

\item{pattern}{\code{character(1)}.
Regular expression pattern.
Evalutes with \code{\link[=gregexpr]{gregexpr()}} internally.}

\item{fixed}{\code{logical(1)}.
If \code{TRUE}, \code{pattern} is a string to be matched as is.
Otherwise, will match by regular expression.}
}
\value{
\code{list}.
List of character vector extractions.
Returns \code{character(0L)} for match failure, \code{NA_character_} for \code{NA}.
}
\description{
Uses \code{\link[=gregexpr]{gregexpr()}} and \code{\link[=regmatches]{regmatches()}} internally.
}
\note{
Updated 2023-09-25.
}
\examples{
object <- strExtractAll(
    x = c("apples x4", "bag of flour", "bag of sugar", "milk x2", NA),
    pattern = "[a-z]+"
)
print(object)
}
\seealso{
\itemize{
\item \code{\link[=gregexpr]{gregexpr()}} , \code{\link[=regmatches]{regmatches()}}.
\item \code{\link[stringi:stri_extract]{stringi::stri_extract_all()}}.
\item \code{\link[stringr:str_extract]{stringr::str_extract_all()}}.
\item https://stringr.tidyverse.org/articles/from-base.html
}
}
