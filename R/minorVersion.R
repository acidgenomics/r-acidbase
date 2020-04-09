#' Minor version
#'
#' @export
#' @note Updated 2020-04-09.
#'
#' @inheritParams params
#'
#' @examples
#' minorVersion(c("1.0.0", "2.1"))
minorVersion <- function(x) {
    x <- as.character(x)
    x <- strsplit(x, split = "\\.")
    x <- vapply(
        X = x,
        FUN = function(x) {
            paste(x[seq_len(2L)], collapse = ".")
        },
        FUN.VALUE = character(1L),
        USE.NAMES = FALSE
    )
    x <- numeric_version(x)
    x
}
