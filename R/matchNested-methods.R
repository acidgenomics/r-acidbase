## FIXME Consider adding a decode step for DataFrame method.
## FIXME Can we also define a matrix method here?
## FIXME Consider allowing an override for not allowing duplicates.



#' @name matchNested
#' @inherit AcidGenerics::matchNested
#'
#' @note Updated 2023-03-02.
#'
#' @inheritParams AcidRoxygen::params
#' @param ... Additional arguments.
#'
#' @examples
#' ## list ====
#' ## FIXME
#'
#' ## matrix ====
#' ## FIXME?
#'
#' ## data.frame ====
#' ## FIXME
#'
#' ## DataFrame ====
#' ## FIXME
NULL



## Updated 2023-03-02.
`matchNested,data.frame` <- function(x, table) {
    lst <- apply(
        X = table,
        MARGIN = 1L,
        FUN = function(x) {
            x <- unlist(x, recursive = TRUE, use.names = FALSE)
            x <- na.omit(x)
            x <- unique(x)
            x
        },
        simplify = FALSE
    )
    idx <- rep(
        x = seq_along(lst),
        times = vapply(
            X = lst,
            FUN = length,
            FUN.VALUE = integer(1L)
        )
    )
    value <- unlist(x = lst, recursive = FALSE, use.names = FALSE)
    df <- data.frame("idx" = idx, "value" = value)
    df <- df[!duplicated(df[["value"]]), , drop = FALSE]
    idx <- match(x = x, table = df[["value"]])
    out <- df[["idx"]][idx]
    out
}



#' @rdname matchNested
#' @export
setMethod(
    f = "matchNested",
    signature = signature(
        x = "character",
        table = "data.frame"
    ),
    definition = `matchNested,data.frame`
)
