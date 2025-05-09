#' @name intersectionMatrix
#' @inherit AcidGenerics::intersectionMatrix
#' @note Updated 2021-08-13.
#'
#' @inheritParams AcidRoxygen::params
#' @param ... Additional arguments.
#'
#' @examples
#' object <- list(
#'     "aaa" = c("a", "b", "c", "d", "e", "f"),
#'     "bbb" = c("b", "c", "d", "e", "f", "g"),
#'     "ccc" = c("c", "d", "e", "f", "g", "h")
#' )
#' mat <- intersectionMatrix(object)
#' rowSums(mat)
NULL


## Updated 2023-04-26.
`intersectionMatrix,DFrame` <- # nolint
    function(object) {
        assert(allAreAtomic(object))
        object <- as.data.frame(object)
        intersectionMatrix(object)
    }


## Updated 2021-08-13.
`intersectionMatrix,data.frame` <- # nolint
    function(object) {
        assert(allAreAtomic(object))
        object <- as.list(object)
        intersectionMatrix(object)
    }


## Updated 2020-08-18.
`intersectionMatrix,list` <- # nolint
    function(object) {
        assert(
            hasLength(object),
            allAreAtomic(object),
            all(bapply(
                X = object,
                FUN = isAny,
                classes = c("character", "factor", "numeric")
            )),
            isString(unique(vapply(
                X = object,
                FUN = simpleClass,
                FUN.VALUE = character(1L)
            ))),
            msg = paste(
                "Invalid input.",
                "Must contain list of 'character', 'numeric', or 'factor'."
            )
        )
        elements <- sort(unique(unlist(
            x = object,
            recursive = FALSE,
            use.names = FALSE
        )))
        out <- vapply(
            X = object,
            FUN = function(x, elements) {
                elements %in% x
            },
            elements = elements,
            FUN.VALUE = logical(length(elements)),
            USE.NAMES = TRUE
        )
        rownames(out) <- as.character(elements)
        out
    }


## Recommended method for handling matrix to list column coercion:
## https://stackoverflow.com/questions/6819804/
## Can't use `as.list()` directly here.
## Updated 2021-08-13.
`intersectionMatrix,matrix` <- # nolint
    function(object) {
        assert(is.character(object) || is.numeric(object))
        object <- as.data.frame(object)
        intersectionMatrix(object)
    }


#' @rdname intersectionMatrix
#' @export
setMethod(
    f = "intersectionMatrix",
    signature = signature(object = "DFrame"),
    definition = `intersectionMatrix,DFrame`
)

#' @rdname intersectionMatrix
#' @export
setMethod(
    f = "intersectionMatrix",
    signature = signature(object = "data.frame"),
    definition = `intersectionMatrix,data.frame`
)

#' @rdname intersectionMatrix
#' @export
setMethod(
    f = "intersectionMatrix",
    signature = signature(object = "list"),
    definition = `intersectionMatrix,list`
)

#' @rdname intersectionMatrix
#' @export
setMethod(
    f = "intersectionMatrix",
    signature = signature(object = "matrix"),
    definition = `intersectionMatrix,matrix`
)
