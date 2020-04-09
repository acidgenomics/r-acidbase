#' Major version
#'
#' @export
#' @note Updated 2020-04-09.
#'
#' @inheritParams params
#'
#' @examples
#' majorVersion("1.0.0")
majorVersion <- function(x) {
    x <- as.character(x)
    x <- strsplit(x = x, split = "\\.")
    x <- x[[1L]][[1L]]
    x <- numeric_version(x)
    x
}
