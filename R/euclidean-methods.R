#' @name euclidean
#' @inherit AcidGenerics::euclidean
#'
#' @note Updated 2023-09-11.
#'
#' @inheritParams AcidRoxygen::params
#' @param ... Additional arguments.
#'
#' @seealso
#' - https://www.statology.org/euclidean-distance-in-r/
#'
#' @examples
#' ## numeric ====
#' x <- seq(from = 1L, to = 5L, by = 1L)
#' y <- seq(from = 6L, to = 10L, by = 1L)
#' euclidean(x = x, y = y)
NULL



## Updated 2023-09-11.
`euclidean,numeric` <- # nolint
    function(x, y) {
        assert(
            is.numeric(x),
            is.numeric(y),
            isFALSE(anyNA(x)),
            isFALSE(anyNA(y))
        )
        sqrt(sum((x - y)^2L))
    }



#' @rdname euclidean
#' @export
setMethod(
    f = "euclidean",
    signature = signature(x = "numeric"),
    definition = `euclidean,numeric`
)
