#' Capitalize
#'
#' @name capitalize
#' @note Updated 2019-10-21.
#'
#' @inheritParams params
#'
#' @return Modified object, with names capitalized.
#'
#' @examples
#' capitalize(c("hello", "world"))
capitalize <- function(x) {
    vapply(
        X = as.character(x),
        FUN = function(x) {
            if (is.na(x)) return(x)
            first <- substring(x, first = 1L, last = 1L)
            first <- toupper(first)
            tail <- substring(x, first = 2L)
            paste(first, tail, sep = "")
        },
        FUN.VALUE = character(1L),
        USE.NAMES = FALSE
    )
}