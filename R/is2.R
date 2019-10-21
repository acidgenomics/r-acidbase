#' Is an object from a class?
#'
#' Alternate version of [`is()`][methods::is] that supports multiple checks in a
#' single call.
#'
#' If a function named `is.class` exists, call `is.class(x)`.
#' If not, call `is(x, class)`.
#'
#' Used internally by [isAll()][] and [isAny()][] checks.
#'
#' @note Updated 2019-10-04.
#' @noRd
#'
#' @inheritParams acidroxygen::params
#'
#' @seealso
#' - `assertive.base::is2()`.
#' - `methods::is()`.
#'
#' @return `logical`.
#'
#' @examples
#' ## TRUE ====
#' is2(seq_len(5L), class = "numeric")
#'
#' ## FALSE ====
#' is2(seq_len(5L), class = "character")
#' is2(matrix(seq_len(5L)), class = "character")
#' is2(seq_len(5L), class = c("character", "list", "numeric"))
#' is2(mean, class = c("function", "data.frame"))
is2 <- function(x, class, .xname = getNameInParent(x)) {
    if (!is.character(class) || identical(length(class), 0L)) {
        stop("'class' must be non-empty character.")
    }
    if (length(class) > 1L) {
        ok <- bapply(X = class, FUN = function(cl) .is2(x, cl, ""))
        return(setCause(
            x = ok,
            false = sprintf("%s is not '%s'", typeDescription(x), class)
        ))
    }
    ## Attempt to use `is.character(x)` first.
    ## Otherwise, fall back to `is(x, "character)`.
    ## Alternatively, can take a look at `inherits()` but it doesn't always
    ## return the same TRUE/FALSE as an `is()` call.
    ok <- tryCatch(
        expr = {
            isClass <- match.fun(paste0("is.", class))
            isClass(x)
        },
        error = function(e) {
            is(x, class)
        }
    )
    if (!isTRUE(ok)) {
        return(false(
            "'%s' is not of class '%s'; it has %s.",
            .xname, class, typeDescription(x)
        ))
    }
    TRUE
}