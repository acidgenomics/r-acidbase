#' Extract components from first match
#'
#' Uses [regexec()] and [regmatches()] internally.
#'
#' @export
#' @note Updated 2023-09-25.
#'
#' @details
#' Expands with `NA` values for match failures, like stringi and stringr.
#'
#' @param x `character`.
#' Character vector. `NA` values are allowed.
#'
#' @param pattern `character(1)`.
#' Regular expression pattern.
#' Evalutes with [regexec()] internally.
#'
#' @param fixed `logical(1)`.
#' If `TRUE`, `pattern` is a string to be matched as is.
#' Otherwise, will match by regular expression.
#'
#' @return `matrix`.
#' Character matrix of match groups.
#'
#' @seealso
#' - [regexec()], [regmatches()], [regexpr()].
#' - [stringi::stri_match_first()].
#' - [stringr::str_match()].
#' - https://stringr.tidyverse.org/articles/from-base.html
#' - https://bookdown.org/rdpeng/rprogdatascience/regular-expressions.html
#' - https://stackoverflow.com/questions/19171715/
#' - https://d-rug.github.io/blog/2015/regex.fick
#'
#' @examples
#' ## Regex match.
#' object <- strMatch(
#'     x = c("a-b", "c-d", "e_f", NA),
#'     pattern = "^(.+)-(.+)$",
#'     fixed = FALSE
#' )
#' print(object)
#'
#' ## Fixed match.
#' object <- strMatch(
#'     x = c("a", "aa", "b", "bb"),
#'     pattern = "a",
#'     fixed = TRUE
#' )
#' print(object)
strMatch <- function(x, pattern, fixed = FALSE) {
    assert(
        is.character(x),
        isString(pattern),
        isFlag(fixed)
    )
    m <- regexec(pattern = pattern, text = x, fixed = fixed)
    l <- regmatches(x = x, m = m)
    ## Fill match failures with NA, similar to stringi and stringr.
    mul <- unlist(m, recursive = FALSE, use.names = FALSE)
    if (anyNA(mul) || any(mul == -1L)) {
        naNum <- .captureGroups(pattern) + 1L
        naIdx <- which(lengths(l) == 0L)
        l[naIdx] <- lapply(X = l[naIdx], FUN = rep, NA_character_, naNum)
    }
    mat <- do.call(what = rbind, args = l)
    mat
}



#' Get the number of expected capture groups in a regular expression
#'
#' @note Updated 2023-09-25.
#' @noRd
.captureGroups <- function(pattern) {
    assert(isString(pattern))
    re <- regexpr(pattern = pattern, text = "", perl = TRUE)
    cl <- attr(re, "capture.length")
    n <- length(cl)
    n
}
