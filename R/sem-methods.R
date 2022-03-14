#' @name sem
#' @inherit AcidGenerics::sem
#' @note Updated 2021-10-12.
#'
#' @inheritParams AcidRoxygen::params
#' @param ... Additional arguments.
#'
#' @details
#' Alternatively, can use: `sd(x) / sqrt(length(x))`.
#'
#' @seealso
#' - https://stackoverflow.com/questions/2676554/
#'
#' @examples
#' x <- seq(from = 1L, to = 10L, by = 1L)
#' x <- sem(x)
#' x
NULL



## Necessary for dplyr mutate calls.
## Updated 2021-02-02.
`sem,AsIs` <- # nolint
    function(x) {
        sem(as.numeric(x)) # nocov
    }



## Updated 2021-10-12.
`sem,numeric` <- # nolint
    function(x) {
        sqrt(var(x) / length(x))
    }



#' @rdname sem
#' @export
setMethod(
    f = "sem",
    signature = signature(x = "AsIs"),
    definition = `sem,AsIs`
)

#' @rdname sem
#' @export
setMethod(
    f = "sem",
    signature = signature(x = "numeric"),
    definition = `sem,numeric`
)
