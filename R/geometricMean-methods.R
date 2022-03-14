#' @name geometricMean
#' @inherit AcidGenerics::geometricMean
#'
#' @note This function should be fully zero- and `NA`-tolerant. This calculation
#' is not particularly useful if there are elements that are <= 0 and will
#' return `NaN`.
#' @note Updated 2021-10-14.
#'
#' @inheritParams AcidRoxygen::params
#' @inheritParams base::apply
#' @param ... Additional arguments.
#'
#' @seealso
#' - [Paul McMurdie's code](https://stackoverflow.com/a/25555105).
#' - `psych::geometric.mean()`.
#'
#' @return `numeric`.
#'
#' @examples
#' ## numeric ====
#' vec1 <- seq(1L, 5L, 1L)
#' print(vec1)
#' geometricMean(vec1)
#'
#' vec2 <- vec1^2L
#' print(vec2)
#' geometricMean(vec2)
#'
#' ## matrix ====
#' matrix <- matrix(
#'     data = c(vec1, vec2),
#'     ncol = 2L,
#'     byrow = FALSE
#' )
#' print(matrix)
#' geometricMean(matrix)
NULL



## Necessary for dplyr mutate calls.
## Updated 2021-02-02.
`geometricMean,AsIs` <- # nolint
    function(x) {
        geometricMean(as.numeric(x)) # nocov
    }



## Updated 2020-02-02.
`geometricMean,matrix` <- # nolint
    function(x, MARGIN = 2L) { # nolint
        apply(
            X = x,
            MARGIN = MARGIN,
            FUN = geometricMean
        )
    }



## Updated 2020-02-02.
`geometricMean,numeric` <- # nolint
    function(x,
             removeNA = TRUE,
             zeroPropagate = FALSE) {
        assert(
            isFlag(removeNA),
            isFlag(zeroPropagate)
        )
        ## Check for any negative numbers and return `NaN`.
        if (any(x < 0L, na.rm = TRUE)) {
            return(NaN)
        }
        if (isTRUE(zeroPropagate)) {
            if (any(x == 0L, na.rm = TRUE)) {
                return(0L)
            }
            exp(mean(log(x), na.rm = removeNA))
        } else {
            exp(
                sum(log(x[x > 0L]), na.rm = removeNA) /
                    length(x)
            )
        }
    }



#' @rdname geometricMean
#' @export
setMethod(
    f = "geometricMean",
    signature = signature(x = "AsIs"),
    definition = `geometricMean,AsIs`
)

#' @rdname geometricMean
#' @export
setMethod(
    f = "geometricMean",
    signature = signature(x = "matrix"),
    definition = `geometricMean,matrix`
)

#' @rdname geometricMean
#' @export
setMethod(
    f = "geometricMean",
    signature = signature(x = "numeric"),
    definition = `geometricMean,numeric`
)
