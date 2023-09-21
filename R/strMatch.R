#' Extract components from a match
#'
#' Uses [regexec()] and [regmatches()] from base R internally.
#'
#' @export
#' @note Updated 2023-09-21.
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
    n <- length(regexpr(pattern = pattern, text = x))
    m <- regexec(pattern = pattern, text = x)
    l <- regmatches(x = x, m = m)
    naIdx <- which(lengths(l) == 0L)
    l[naIdx] <- lapply(X = l[naIdx], FUN = rep, NA_character_, n)
    mat <- do.call(what = rbind, args = l)
    mat
}
