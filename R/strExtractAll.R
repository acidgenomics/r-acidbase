#' Extract all pattern occurances
#'
#' Uses [gregexpr()] and [regmatches()] internally.
#'
#' @export
#' @note Updated 2023-09-25.
#'
#' @param x `character`.
#' Character vector. `NA` values are allowed.
#'
#' @param pattern `character(1)`.
#' Regular expression pattern.
#' Evalutes with [gregexpr()] internally.
#'
#' @param fixed `logical(1)`.
#' If `TRUE`, `pattern` is a string to be matched as is.
#' Otherwise, will match by regular expression.
#'
#' @return `list`.
#' List of character vector extractions.
#'
#' @seealso
#' - [stringi::stri_extract_all].
#' - [stringr::str_extract_all].
#' - https://stringr.tidyverse.org/articles/from-base.html
#'
#' @examples
#' object <- strExtractAll(
#'     x = c("apples x4", "bag of flour", "bag of sugar", "milk x2", NA),
#'     pattern = "[a-z]+"
#' )
#' print(object)
strExtractAll <- function(x, pattern, fixed = FALSE) {
    assert(
        is.character(x),
        isString(pattern),
        isFlag(fixed)
    )
    m <- gregexpr(pattern = pattern, text = x, fixed = fixed)
    l <- regmatches(x = x, m = m)
    l[is.na(x)] <- NA_character_
    l
}
