#' Minor version
#'
#' @export
#' @note Updated 2020-04-09.
#'
#' @inheritParams params
#'
#' @examples
#' minorVersion("1.0.0")
minorVersion <- function(x) {
    x <- strsplit(x, split = "\\.")[[1L]]
    x <- paste(x[seq_len(2L)], collapse = ".")
    x
}
