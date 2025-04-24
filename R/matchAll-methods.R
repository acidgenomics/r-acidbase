#' @name matchAll
#' @inherit AcidGenerics::matchAll
#'
#' @note Updated 2023-12-15.
#'
#' @inheritParams AcidRoxygen::params
#' @param ... Additional arguments.
#'
#' @param simplify `logical(1)`.
#' Unlist match list into a positional vector.
#'
#' @examples
#' ## character ====
#' x <- c("c", "b", "a")
#' table <- c("a", "b", "c", "a", "b", "c")
#' i <- matchAll(x = x, table = table, simplify = FALSE)
#' print(i)
#' i <- matchAll(x = x, table = table, simplify = TRUE)
#' print(i)
NULL


## Updated 2023-12-15.
`matchAll,vector` <- # nolint
    function(x, table, simplify = FALSE) {
        assert(
            hasLength(x),
            !anyNA(x),
            hasNoDuplicates(x),
            hasLength(table),
            isFlag(simplify)
        )
        out <- lapply(
            X = x,
            FUN = function(x, table) {
                lgl <- table %in% x
                assert(
                    any(lgl),
                    msg = sprintf("Failed to match {.var %s}.", x)
                )
                which(lgl)
            },
            table = table
        )
        if (isTRUE(simplify)) {
            out <- unlist(x = out, recursive = FALSE, use.names = FALSE)
        }
        out
    }


`matchAll,character` <- # nolint
    `matchAll,vector`

`matchAll,factor` <- # nolint
    `matchAll,vector`

`matchAll,numeric` <- # nolint
    `matchAll,vector`


#' @rdname matchAll
#' @export
setMethod(
    f = "matchAll",
    signature = signature(
        x = "character",
        table = "character"
    ),
    definition = `matchAll,character`
)

#' @rdname matchAll
#' @export
setMethod(
    f = "matchAll",
    signature = signature(
        x = "factor",
        table = "factor"
    ),
    definition = `matchAll,factor`
)

#' @rdname matchAll
#' @export
setMethod(
    f = "matchAll",
    signature = signature(
        x = "numeric",
        table = "numeric"
    ),
    definition = `matchAll,numeric`
)
