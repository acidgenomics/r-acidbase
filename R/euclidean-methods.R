#' @name euclidean
#' @inherit AcidGenerics::euclidean
#'
#' @note Updated 2022-11-21.
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



## Updated 2022-11-21.
`euclidean,numeric` <- # nolint
    function(x, y) {
        assert(
            isFALSE(anyNA(x)),
            isFALSE(anyNA(y))
        )
        sqrt(sum((x - y) ^ 2L))
    }



#' @rdname euclidean
#' @export
setMethod(
    f = "euclidean",
    signature = signature(
        x = "numeric",
        y = "numeric"
    ),
    definition = `euclidean,numeric`
)
