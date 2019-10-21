#' Strip attributes
#'
#' @export
#' @note Updated 2019-10-21.
#'
#' @seealso `assertive.base::strip_attributes().
#'
#' @examples
#' x <- "AAA"
#' attr(x, which = "test") <- "BBB"
#' x
#' attributes(x)
#' x <- stripAttributes(x)
#' attributes(x)
#' x
stripAttributes <- function(x) {
    attributes(x) <- NULL
    x
}