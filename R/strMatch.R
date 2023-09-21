## FIXME Need to fill with NA on match failure.
## FIXME Need to fill failure with NA.


#' Extract components from a match
#'
#' Uses [regexec()] and [regmatches()] from base R internally.
#'
#' @note Updated 2023-09-21
#' @noRd
#'
#' @param x `character`.
#'
#' @param pattern `character(1)`.
#' Regular expression pattern.
#' Evalutes with [regexec()] internally.
#'
#' @return `matrix`.
#' Character matrix of match groups.
#'
#' @seealso
#' - [regexec()], [regmatches()].
#' - [stringr::str_match()].
#' - https://stringr.tidyverse.org/articles/from-base.html
#' - https://stackoverflow.com/questions/19171715/
#'
#' @examples
#' x <- c("a-b", "c-d", "e_f", NA)
#' pattern <- "^(.+)-(.+)$"
#' mat <- strMatch(x = x, pattern = pattern)
#' print(mat)
strMatch <- function(x, pattern) {
    assert(
        is.character(x),
        isString(pattern)
    )
    m <- regexec(pattern = pattern, text = x)

    ## FIXME This doesn't detect the number of match groups correctly.
    n <- max(vapply(X = m, FUN = length, FUN.VALUE = integer(1L)))

    l <- regmatches(x = x, m = m)
    naIdx <- which(lengths(l) == 0L)
    l[naIdx] <- lapply(X = l[naIdx], FUN = rep, NA_character_, n)
    mat <- do.call(what = rbind, args = l)
    mat
}
