#' Header for object show method
#'
#' @name showHeader
#' @note Updated 2021-02-04.
#'
#' @inheritParams AcidRoxygen::params
#' @param ... Additional arguments.
#'
#' @return Console output, via [`cat()`][base::cat].
#'
#' @seealso [show()].
#'
#' @examples
#' data(matrix, package = "AcidTest")
#'
#' ## matrix ====
#' object <- matrix
#' showHeader(matrix)
NULL



## Updated 2021-02-04.
`showHeader,ANY` <-
    function(object) {
        class <- class(object)[[1L]]
        x <- class
        length <- length(object)
        if (!is.null(length)) {
            x <- paste(x, "of length", length)
        }
        cat(x, "\n", sep = "")
    }



#' @rdname showHeader
#' @export
setMethod(
    f = "showHeader",
    signature = signature("ANY"),
    definition = `showHeader,ANY`
)



## Updated 2021-02-04.
`showHeader,Annotated` <-
    function(object) {
        class <- class(object)[[1L]]
        x <- class
        version <- as.character(metadata(object)[["version"]])
        if (hasLength(version)) {
            x <- paste(x, version)
        }
        length <- length(object)
        if (!is.null(length)) {
            x <- paste(x, "of length", length)
        }
        cat(x, "\n", sep = "")
    }



#' @rdname showHeader
#' @export
setMethod(
    f = "showHeader",
    signature = signature("Annotated"),
    definition = `showHeader,Annotated`
)
