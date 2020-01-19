#' File depth
#'
#' @export
#' @note This function intentionally doesn't check whether a file exists.
#' @note Updated 2019-09-05.
#'
#' @param path `character`.
#'   File path(s).
#'   This function is vectorized and supports multiple files.
#' @param fsep `character(1)`.
#'   Platform-specific file path separator (e.g. "/" on Unix).
#'
#' @return `integer`.
#' Unnamed vector denoting file path depth.
#' Note that "/" will return 0 here (zero indexed).
#'
#' @examples
#' a <- tempdir()
#' b <- tempfile()
#' fileDepth(c(a, b))
fileDepth <- function(path, fsep = .Platform[["file.sep"]]) {
    path <- normalizePath(path, winslash = fsep, mustWork = FALSE)
    vapply(
        X = path,
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
