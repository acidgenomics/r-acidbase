## FIXME How to recursively NA fill here?



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
#' ## FIXME
#'
#' ## Fixed match.
#' ## FIXME
strMatchAll <- function(x, pattern, fixed = FALSE) {
    assert(
        is.character(x),
        isString(pattern),
        isFlag(fixed)
    )
    m <- gregexec(pattern = pattern, text = x, fixed = fixed)
    l <- regmatches(x = x, m = m)
    ## Fill match failures with NA, similar to stringi and stringr.
    re <- gregexpr(pattern = pattern, text = x, perl = TRUE)



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
