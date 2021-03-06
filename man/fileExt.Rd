% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fileExt.R
\name{fileExt}
\alias{fileExt}
\title{File extension}
\usage{
fileExt(path)
}
\arguments{
\item{path}{\code{character}.
File path(s).
This function is vectorized and supports multiple files.}
}
\value{
\code{character}.
Character vector of same length as \code{path} input, with file extension removed.
Returns \code{NA} if no extension is detected.
}
\description{
File extension
}
\note{
This function intentionally doesn't check whether a file exists.

Updated 2020-01-18.
}
\examples{
fileExt(c("dir/foo.txt", "dir/bar.tar.gz", "dir/"))
}
\seealso{
\itemize{
\item \code{tools::file_ext()}. Note that this returns \code{character()} instead of \code{NA}
on extension match failure.
}
}
