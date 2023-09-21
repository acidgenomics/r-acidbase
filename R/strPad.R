## FIXME Don't use sprintf for this, too limited.

#' Pad a string to minimum width
#'
#' @export
#' @note Updated 2023-09-21.
#'
#' @param x `character`.
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
#' @examples
#' x <- c("1", "10", "100")
#' width <- max(nchar(x))
#' strPad(x = x, width = width, side = "left", pad = "0")
#'
#' @seealso
#' - [stringr::str_pad()].
#' - [sprintf()].
#' - https://stringr.tidyverse.org/articles/from-base.html
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
            paste0(rep(x = pad, times = times), collapse = "")
        },
        times = diff,
        MoreArgs = list(pad = pad)
    ))
    out <- switch(
        EXPR = side,
        "left" = {
            paste0(y, x)
        },
        "right" = {
            paste0(x, y)
        }
    )
    names(out) <- names(x)
    out
}
