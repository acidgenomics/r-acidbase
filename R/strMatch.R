#' Extract components from a match
#'
#' Uses [regexec()] and [regmatches()] from base R internally.
#'
#' @details
#' Expands with `NA` values for match failures, like stringi and stringr.
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
#' - [regexec()], [regmatches()], [regexpr()].
#' - [stringi::stri_match()].
#' - [stringr::str_match()].
#' - https://stringr.tidyverse.org/articles/from-base.html
#' - https://bookdown.org/rdpeng/rprogdatascience/regular-expressions.html
#' - https://stackoverflow.com/questions/19171715/
#' - https://d-rug.github.io/blog/2015/regex.fick
#'
#' @examples
#' x <- c("a-b", "c-d", "e_f", NA)
#' pattern <- "^(.+)-(.+)$"
#' mat <- strMatch(x = x, pattern = pattern)
#' print(mat)
strMatch <- function(x, pattern) {
    assert(is.character(x), isString(pattern))
    m <- regexec(pattern = pattern, text = x)
    l <- regmatches(x = x, m = m)
    mul <- unlist(m)
    ## Fill match failures with NA, similar to stringi and stringr.
    if (anyNA(mul) || any(mul == -1L)) {
        ## Capture length is only returned when Perl engine is enabled.
        re <- regexpr(pattern = pattern, text = x, perl = TRUE)
        capLen <- attr(re, "capture.length")
        if (is.null(capLen)) {
            naNum <- 1L
        } else {
            ## Need to add 1 here to include the input string.
            naNum <- ncol(capLen) + 1L
        }
        naIdx <- which(lengths(l) == 0L)
        l[naIdx] <- lapply(X = l[naIdx], FUN = rep, NA_character_, naNum)
    }
    mat <- do.call(what = rbind, args = l)
    mat
}