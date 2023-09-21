#' Extract components from a match
#'
#' @note Updated 2023-09-21
#' @noRd
#'
#' @return `matrix`.
#' Character matrix of match groups.
#'
#' @seealso
#' - [stringr::str_match()].
#' - https://stringr.tidyverse.org/articles/from-base.html
strMatch <- function(x, pattern) {
    # FIXME How to handle NA here?
    assert(isString(pattern))
    m <- regexec(pattern = pattern, text = x)
    l <- regmatches(x = x, m = m)
    mat <- do.call(what = rbind, args = l)
    mat
}
