#' Shorten (truncate) input to a specified width
#'
#' Automatically generate a substring and add trailing "..." if necessary.
#'
#' Note that return matches the desired width.
#'
#' @export
#' @note Updated 2019-10-21.
#'
#' @inheritParams params
#'
#' @seealso `assertive.base:::truncate()`.
#'
#' @examples
#' x <- "the quick brown fox"
#' x <- shorten(x, width = 10L)
#' nchar(x)
shorten <- function(x, width = getOption("width")) {
    stopifnot(.isInt(width), isTRUE(width > 3L))
    x <- as.character(x)
    ifelse(
        test = nchar(x) > width,
        yes = paste0(substring(x, 1L, width - 3L), "..."),
        no = x
    )
}