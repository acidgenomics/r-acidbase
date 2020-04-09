#' Major version
#'
#' @export
#' @note Updated 2020-04-09.
#'
#' @inheritParams params
#'
#' @return `numeric_version`.
#'
#' @examples
#' majorVersion(c("1.0.0", "2.1"))
majorVersion <- function(x) {
    x <- as.character(x)
    x <- strsplit(x = x, split = "\\.")
    x <- vapply(
        X = x,
        FUN = `[[`,
        FUN.VALUE = character(1L),
        USE.NAMES = FALSE,
        1L
    )
    x <- numeric_version(x)
    x
}
