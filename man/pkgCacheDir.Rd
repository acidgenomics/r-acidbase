% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pkgCacheDir.R
\name{pkgCacheDir}
\alias{pkgCacheDir}
\title{Create a local cache directory for a package}
\usage{
pkgCacheDir(pkg)
}
\arguments{
\item{pkg}{\code{character(1)}.
Package name.}
}
\value{
\code{character(1)}.
Directory path.
}
\description{
Create a local cache directory for a package
}
\details{
Requires the tools package to be installed.
}
\note{
Updated 2023-09-28.
}
\examples{
dir <- pkgCacheDir(pkg = "AcidBase")
print(dir)
}
\seealso{
\itemize{
\item \code{tools::R_user_dir()}.
\item \code{rappdirs::user_cache_dir()}.
\item \code{Sys.getenv("R_USER_CACHE_DIR")}.
\item \code{Sys.getenv("XDG_CACHE_HOME")}.
\item BiocFileCache package.
}
}
