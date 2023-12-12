## FIXME Make this a generic and allow dispatch on data.frame, DFrame.



#' Filter a nested data frame by a matching pattern across all columns.
#'
#' @export
#' @note Updated 2023-12-12.
#'
#' @inheritParams AcidRoxygen::params
#'
#' @param pattern `character(1)`.
#' Pattern to match rowwise, across all columns.
#'
#' @param ignoreCase `logical(1)`.
#' Ignore case in pattern match.
#'
#' @param fixed `logical(1)`.
#' Perform a fixed instead of regular expression match.
#'
#' @seealso
#' - https://github.com/Bioconductor/IRanges/issues/51
filterNested <- function(object, pattern, ignoreCase = FALSE) {
    assert(
        validObject(object),
        isString(pattern),
        isFlag(ignoreCase)
    )
    lst <- apply(
        X = object,
        MARGIN = 1L,
        FUN = function(x) {
            x <- unlist(x = x, recursive = TRUE, use.names = FALSE)
            x <- as.character(x)
            x <- na.omit(x)
            x <- unique(x)
            x
        }
    )
    names(lst) <- NULL
    cl <- CharacterList(lst)
    ## CharacterList method for `grepl` doesn't currently support `fixed`
    ## argument correctly, so disabling.
    ## https://github.com/Bioconductor/IRanges/issues/51
    ll <- grepl(
        pattern = pattern,
        x = cl,
        ignore.case = ignoreCase,
        fixed = FALSE
    )
    assert(is(ll, "LogicalList"))
    i <- any(ll)
    assert(
        any(i),
        msg = sprintf("Failed to match pattern: {.var %s}.", pattern)
    )
    out <- object[i, , drop = FALSE]
    out
}
