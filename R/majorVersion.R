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
    strsplit(x, split = "\\.")[[1L]][[1L]]
}
