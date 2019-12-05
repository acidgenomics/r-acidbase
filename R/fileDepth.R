#' File depth
#'
#' This function is parameterized, and works on multiple files and/or
#' directories.
#'
#' File path(s) do not have to exist on disk, similar to the approach employed
#' by [`file.path()`][base::file.path].
#'
#' Note that "/" will return 0 here (zero indexed).
#'
#' @export
#' @note Updated 2019-09-05.
#' a <- tempdir()
#' b <- tempfile()
#' fileDepth(a, b)
fileDepth <- function(..., fsep = .Platform[["file.sep"]]) {
    x <- unlist(list(...))
    x <- normalizePath(x, winslash = fsep, mustWork = FALSE)
    vapply(
        X = x,
        FUN = function(x) {
            x <- strsplit(x = x, split = fsep, fixed = TRUE)
            x <- unlist(x)
            x <- length(x)
            x <- x - 1L
            x
        },
        FUN.VALUE = integer(1L),
        USE.NAMES = FALSE
    )
}
