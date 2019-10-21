#' Truncate input to a specified width
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
#' x <- truncate(x, width = 10L)
#' nchar(x)
truncate <- function(x, width = getOption("width")) {
    x <- as.character(x)
    ifelse(
        test = nchar(x) > width,
        yes = paste0(substring(x, 1L, width - 3L), "..."),
        no = x
    )
}