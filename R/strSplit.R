#' Split the elements of a character vector into a matrix
#'
#' @export
#' @note Updated 2023-09-13.
#'
#' @inheritParams AcidRoxygen::params
#'
#' @param split `character(1)`.
#' Single fixed character that defines the split.
#' Regular expressions are intentionally not supported to keep this simple.
#'
#' @return `matrix`.
#' Character matrix split into columns.
#'
#' @seealso
#' - [stringi::stri_split_fixed()].
#' - [stringr::str_split_fixed()].
#' - [strsplit()].
#'
#' @examples
#' x <- c(
#'     "TSPAN6_ENST00000373020",
#'     "TSPAN6_ENST00000494424",
#'     "TSPAN6_ENST00000496771",
#'     "TSPAN6_ENST00000612152",
#'     "TSPAN6_ENST00000614008"
#' )
#' x <- strSplit(x = x, split = "_")
#' print(x)
strSplit <- function(x, split) {
    assert(
        isCharacter(x),
        isString(split),
        nchar(split) == 1L,
        allAreMatchingFixed(x = x, pattern = split)
    )
    x <- strsplit(x = x, split = split, fixed = TRUE)
    ## FIXME Replace with `lengths()` here.
    n <- vapply(
        X = x,
        FUN = length,
        FUN.VALUE = integer(1L)
    )
    assert(
        length(unique(n)) == 1L,
        msg = sprintf(
            "Split mismatch detected: %s.",
            toString(which(n != n[[1L]]))
        )
    )
    x <- unlist(x = x, recursive = FALSE, use.names = FALSE)
    x <- matrix(data = x, ncol = n[[1L]], byrow = TRUE)
    x
}
