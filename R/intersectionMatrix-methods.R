#' @name intersectionMatrix
#' @inherit AcidGenerics::intersectionMatrix
#' @note Updated 2021-01-15.
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



## Updated 2020-08-18.
`intersectionMatrix,list` <-  # nolint
    function(object) {
        assert(
            hasLength(object),
            allAreAtomic(object),
            all(bapply(
                X = object,
                FUN = isAny,
                classes = c("character", "numeric")
            )),
            isString(unique(vapply(
                X = object,
                FUN = simpleClass,
                FUN.VALUE = character(1L)
            ))),
            msg = paste(
                "Invalid input.",
                "Must contain list of all 'character' or 'numeric' values."
            )
        )
        elements <- sort(unique(unlist(
            x = object,
            recursive = FALSE,
            use.names = FALSE
        )))
        mat <- vapply(
            X = object,
            FUN = function(x, elements) {
                elements %in% x
            },
            elements = elements,
            FUN.VALUE = logical(length(elements)),
            USE.NAMES = TRUE
        )
        rownames(mat) <- as.character(elements)
        mat
    }



## FIXME Should use array definition here instead?


## Updated 2021-08-13.
`intersectionMatrix,matrix` <-  # nolint
    function(object) {
        stop("FIXME Need to support this.")
    }



## Updated 2021-08-13.
`intersectionMatrix,data.frame` <-  # nolint
    function(object) {
        stop("FIXME Need to ensure that all columns are same class")
    }

## FIXME Harden against matrix
## FIXME Harden against data.frame
## FIXME Add DataFrame and Matrix methods.



#' @rdname intersectionMatrix
setMethod(
    f = "intersectionMatrix",
    signature = signature("list"),
    definition = `intersectionMatrix,list`
)
