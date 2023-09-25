#' Extract components from a match
#'
#' Uses [gregexec()] and [regmatches()] from base R internally.
#'
#' @details
#' Expands with `NA` values for match failures, like stringi and stringr.
#'
#' @export
#' @note Updated 2023-09-25.
#'
#' @param x `character`.
#' Character vector. `NA` values are allowed.
#'
#' @param pattern `character(1)`.
#' Regular expression pattern.
#' Evalutes with [gregexec()] internally.
#'
#' @param fixed `logical(1)`.
#' If `TRUE`, `pattern` is a string to be matched as is.
#' Otherwise, will match by regular expression.
#'
#' @return `list`.
#' List of character matrix of match groups.
#'
#' @seealso
#' - [gregexec()], [regmatches()], [gregexpr()].
#' - [stringi::stri_match_all()].
#' - [stringr::str_match_all()].
#'
#' @examples
#' ## Regex match.
#' object <- strMatchAll(
#'     x = c("a-b", "c-d", "e_f", NA),
#'     pattern = "^(.+)-(.+)$",
#'     fixed = FALSE
#' )
#' print(object)
#'
#' ## Fixed match.
#' object <- strMatchAll(
#'     x = c("a", "aa", "b", "bb"),
#'     pattern = "a",
#'     fixed = TRUE
#' )
#' print(object)
strMatchAll <- function(x, pattern, fixed = FALSE) {
    assert(
        is.character(x),
        isString(pattern),
        isFlag(fixed)
    )
    m <- gregexec(pattern = pattern, text = x, fixed = fixed)
    l <- regmatches(x = x, m = m)
    l <- lapply(X = l, FUN = t)
    mul <- unlist(m, recursive = TRUE, use.names = FALSE)
    if (anyNA(mul) || any(mul == -1L)) {
        naNum <- .captureGroups(pattern) + 1L
        naMat <- matrix(
            data = rep(NA_character_, naNum),
            nrow = 1L,
            ncol = naNum
        )
        re <- gregexpr(pattern = pattern, text = x, perl = TRUE)
        l <- Map(
            f = function(l, re, naMat) {
                ml <- attr(re, "match.length")
                if (all(is.na(ml) | ml == -1L)) {
                    out <- naMat
                } else {
                    out <- l
                }
                out
            },
            l = l,
            re = re,
            MoreArgs = list("naMat" = naMat),
            USE.NAMES = FALSE
        )
    }
    l
}
