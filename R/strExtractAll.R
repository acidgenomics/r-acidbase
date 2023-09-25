## Extract all matches
## shopping_list <- c("apples x4", "bag of flour", "bag of sugar", "milk x2")
## stringr::str_extract_all(shopping_list, "[a-z]+")
##
## FIXME Need to fill with NA on match failure.



#' Extract all pattern occurances
#'
#' Uses [gregexpr()] and [regmatches()] internally.
#'
#' @export
#' @note Updated 2023-09-25.
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
