#' @name keepOnlyAtomicCols
#' @inherit AcidGenerics::keepOnlyAtomicCols
#' @note Updated 2023-09-08.
#'
#' @inheritParams AcidRoxygen::params
#' @param ... Additional arguments.
#'
#' @examples
#' print("FIXME")
NULL



## Updated 2023-09-08.
`keepOnlyAtomicCols,data.frame` <- # nolint
    function(object) {
        assert(hasDims(object))
        j <- bapply(
            X = object[1L, , drop = FALSE],
            FUN = is.atomic
        )
        assert(
            any(j),
            msg = "No atomic columns in object."
        )
        out <- object[, j, drop = FALSE]
        out
    }



## Updated 2023-09-08.
`keepOnlyAtomicCols,DFrame` <- # nolint
    `keepOnlyAtomicCols,data.frame`



#' @rdname keepOnlyAtomicCols
#' @export
setMethod(
    f = "keepOnlyAtomicCols",
    signature = signature(object = "DFrame"),
    definition = `keepOnlyAtomicCols,DFrame`
)

#' @rdname keepOnlyAtomicCols
#' @export
setMethod(
    f = "keepOnlyAtomicCols",
    signature = signature(object = "data.frame"),
    definition = `keepOnlyAtomicCols,data.frame`
)
