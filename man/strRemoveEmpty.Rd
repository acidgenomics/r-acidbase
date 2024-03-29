% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/strRemoveEmpty.R
\name{strRemoveEmpty}
\alias{strRemoveEmpty}
\title{Remove empty strings}
\usage{
strRemoveEmpty(x, naOk = TRUE, spacesOk = TRUE)
}
\arguments{
\item{x}{\code{character}.
Character vector.}

\item{naOk}{\code{logical(1)}.
Allow \code{NA} values to propagate.}

\item{spacesOk}{\code{logical(1)}.
Consider spaces to be non-empty.}
}
\value{
\code{character}.
Modified vector, with empty strings removed.
}
\description{
Remove empty strings
}
\note{
Updated 2023-09-28.
}
\examples{
x <- c("", "a", "b", " ", NA)
y <- strRemoveEmpty(x, naOk = TRUE, spacesOk = TRUE)
print(y)
y <- strRemoveEmpty(x, naOk = FALSE, spacesOk = FALSE)
print(y)
}
\seealso{
\itemize{
\item \code{\link[stringi:stri_remove_empty]{stringi::stri_remove_empty()}}.
}
}
