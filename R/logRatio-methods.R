#' Interconvert log ratio and fold change values
#'
#' @name logRatio
#' @note Updated 2021-10-14.
#'
#' @inheritParams AcidRoxygen::params
#' @param ... Additional arguments.
#'
#' @seealso
#' - `gtools::foldchange2logratio()`.
#' - `gtools::logratio2foldchange()`.
#'
#' @return `numeric`.
#'
#' @examples
#' ## Convert fold change to log ratio.
#' foldChangeToLogRatio(c(-8, -4, -2, 1, 2, 4, 8))
#'
#' ## Convert log ratio to fold change.
#' logRatioToFoldChange(seq(-3, 3, 1))
NULL



## Updated 2022-09-22.
`foldChangeToLogRatio,numeric` <- # nolint
    function(object, base = 2L) {
        assert(isInt(base), isPositive(base))
        base <- as.integer(base)
        object <- ifelse(
            test = object < 0L,
            yes = 1L / -object,
            no = object
        )
        object <- log(object, base)
        object
    }



## Updated 2022-09-22.
`logRatioToFoldChange,numeric` <- # nolint
    function(object, base = 2L) {
        assert(isInt(base), isPositive(base))
        base <- as.integer(base)
        object <- base^object
        object <- ifelse(
            test = object < 1L,
            yes = -1L / object,
            no = object
        )
        object
    }



#' @rdname logRatio
#' @export
setMethod(
    f = "foldChangeToLogRatio",
    signature = signature(object = "numeric"),
    definition = `foldChangeToLogRatio,numeric`
)



#' @rdname logRatio
#' @export
setMethod(
    f = "logRatioToFoldChange",
    signature = signature(object = "numeric"),
    definition = `logRatioToFoldChange,numeric`
)
