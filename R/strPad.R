#' Pad a string to minimum width
#'
#' @export
#' @note Updated 2023-09-21.
#'
#' @param x `character`.
#' Character vector that does not contain `NA` or empty strings.
#'
#' @param width `integer(1)`.
#' Padding width.
#'
#' @param side `character(1)`.
#' Apply padding to the left or right side.
#'
#' @param pad `character(1)`.
#' Single padding character.
#'
#' @return `character`.
#'
#' @seealso
#' - [stringr::str_pad()].
#' - [sprintf()].
#' - https://stringr.tidyverse.org/articles/from-base.html
#'
#' @examples
#' x <- c("1", "10", "100")
#' width <- max(nchar(x))
#' x <- strPad(x = x, width = width, side = "left", pad = "0")
#' print(x)
strPad <- function(x, width, side = c("left", "right"), pad = " ") {
    assert(
        isCharacter(x),
        isInt(width),
        isString(pad),
        nchar(pad) == 1L
    )
    side <- match.arg(side)
    diff <- width - nchar(x)
    y <- unlist(Map(
        f = function(pad, times) {
            x <- rep(x = pad, times = times)
            x <- paste(x, sep = "", collapse = "") # nolint
            x
        },
        times = diff,
        MoreArgs = list(pad = pad)
    ))
    out <- switch(
        EXPR = side,
        "left" = paste0(y, x),
        "right" = paste0(x, y)
    )
    names(out) <- names(x)
    out
}
