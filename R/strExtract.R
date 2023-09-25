#' Extract first pattern occurance
#'
#' Uses [regexpr()] internally without [regmatches()].
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
#' Evalutes with [regexpr()] internally.
#'
#' @param fixed `logical(1)`.
#' If `TRUE`, `pattern` is a string to be matched as is.
#' Otherwise, will match by regular expression.
#'
#' @return `character`.
#' Character vector of matches. Failures return `NA`.
#'
#' @seealso
#' - [regexpr()], [regmatches()].
#' - [stringi::stri_extract_first()].
#' - [stringr::str_extract()].
#' - https://stringr.tidyverse.org/articles/from-base.html
#'
#' @examples
#' object <- strExtract(
#'     x = c("apples x10", "bag of flour", "bag of sugar", "milk x200", NA),
#'     pattern = "\\d+"
#' )
#' print(object)
strExtract <- function(x, pattern, fixed = FALSE) {
    assert(
        is.character(x),
        isString(pattern),
        isFlag(fixed)
    )
    m <- regexpr(pattern = pattern, text = x, fixed = fixed)
    ml <- attr(m, "match.length")
    lst <- Map(
        f = function(x, m, ml) {
            if (is.na(m) || m == -1L) {
                return(NA_character_)
            }
            substr(x = x, start = m, stop = m + ml - 1L)
        },
        x = x,
        m = m,
        ml = ml,
        USE.NAMES = FALSE
    )
    out <- unlist(x = lst, recursive = FALSE, use.names = FALSE)
    out
}
