#' File depth
#'
#' @export
#' @note Updated 2022-05-31.
#'
#' @details
#' This function intentionally doesn't check whether a file exists.
#'
#' @param path `character`.
#' File path(s).
#' This function is vectorized and supports multiple files.
#'
#' @return `integer`.
#' Unnamed vector denoting file path depth.
#' Note that "/" will return 0 here (zero indexed).
#'
#' @examples
#' a <- tempdir()
#' b <- tempfile()
#' fileDepth(c(a, b))
fileDepth <- function(path) {
    vapply(
        X = .normalizePath(path = path, mustWork = FALSE),
        FUN = function(x, fsep) {
            x <- strsplit(x = x, split = fsep, fixed = TRUE)
            x <- unlist(x)
            x <- length(x)
            x <- x - 1L
            x
        },
        fsep = .Platform[["file.sep"]],
        FUN.VALUE = integer(1L),
        USE.NAMES = FALSE
    )
}
