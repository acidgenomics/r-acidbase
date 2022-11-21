#' @name zscore
#' @inherit AcidGenerics::zscore
#'
#' @note Updated 2022-11-17.
#'
#' @inheritParams AcidRoxygen::params
#' @param ... Additional arguments.
#'
#' @examples
#' data(matrix, package = "AcidTest")
#'
#' ## numeric ====
#' object <- matrix[1L, ]
#' zscore(object)
#'
#' ## matrix ====
#' object <- matrix
#' zscore(matrix, MARGIN = 1L)
NULL



## Alternative approach:
## > scale(object, center = TRUE, scale = TRUE)
## Updated 2022-11-17.
`zscore,numeric` <- # nolint
    function(object) {
        assert(
            requireNamespace("stats", quietly = TRUE),
            isFALSE(anyNA(object))
        )
        (object - mean(object)) / stats::sd(object)
    }



## Alternative approach:
## > t(scale(t(object), center = TRUE, scale = TRUE))
## Updated 2022-11-17.
`zscore,matrix` <- # nolint
    function(object, MARGIN = 1L) { # nolint
        assert(
            isFALSE(anyNA(object)),
            isInt(MARGIN),
            isInRange(MARGIN, lower = 1L, upper = 2L)
        )
        out <- apply(
            X = object,
            MARGIN = MARGIN,
            FUN = zscore,
            simplify = TRUE
        )
        out <- t(out)
        out
    }



#' @rdname zscore
#' @export
setMethod(
    f = "zscore",
    signature = signature(object = "matrix"),
    definition = `zscore,matrix`
)

#' @rdname zscore
#' @export
setMethod(
    f = "zscore",
    signature = signature(object = "numeric"),
    definition = `zscore,numeric`
)
