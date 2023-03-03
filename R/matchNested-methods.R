## NOTE Consider allowing an override for not allowing duplicates in the table.



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
#' x <- c("aaa", "bbb", "ccc")
#' table <- list(
#'     c("a", "aa", "aaa"),
#'     list(c("b", "bb", "bbb")),
#'     list(list(c("c", "cc", "ccc")))
#' )
#' matchNested(x = x, table = table)
#'
#' ## data.frame ====
#' x <- c("aaa", "bbb", "ccc", "ddd")
#' table <- data.frame(
#'     "V1" = c("a", "aa", "aaa"),
#'     "V2" = I(list(
#'         c("b", "bb", "bbb"),
#'         c("c", "cc", "ccc"),
#'         c("d", "dd", "ddd")
#'     ))
#' )
#' matchNested(x = x, table = table)
#'
#' ## DataFrame ====
#' x <- c("aaa", "bbb", "ccc", "ddd")
#' table <- S4Vectors::DataFrame(
#'     "V1" = c("a", "aa", "aaa"),
#'     "V2" = I(list(
#'         c("b", "bb", "bbb"),
#'         c("c", "cc", "ccc"),
#'         c("d", "dd", "ddd")
#'     ))
#' )
#' matchNested(x = x, table = table)
NULL



## Updated 2023-03-02.
`matchNested,list` <- # nolint
    function(x, table) {
        lst <- lapply(
            X = table,
            FUN = function(x) {
                x <- unlist(x, recursive = TRUE, use.names = FALSE)
                x <- na.omit(x)
                x <- unique(x)
                x
            }
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



## Updated 2023-03-02.
`matchNested,data.frame` <- # nolint
    function(x, table) {
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



## Updated 2023-03-02.
`matchNested,DataFrame` <- # nolint
    `matchNested,data.frame`



#' @rdname matchNested
#' @export
setMethod(
    f = "matchNested",
    signature = signature(
        x = "character",
        table = "DataFrame"
    ),
    definition = `matchNested,DataFrame`
)

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

#' @rdname matchNested
#' @export
setMethod(
    f = "matchNested",
    signature = signature(
        x = "character",
        table = "list"
    ),
    definition = `matchNested,list`
)
