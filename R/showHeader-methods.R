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
#' object <- matrix
#' showHeader(matrix)
NULL



`showHeader,ANY` <-
    function(object) {
        class <- class(object)[[1L]]
        out <- class
        ## FIXME ONLY FOR ANNOTATED CLASS.
        version <- as.character(metadata(object)[["version"]])
        if (hasLength(version)) {
            out <- paste(out, version)
        }
        length <- length(object)
        if (!is.null(length)) {
            out <- paste(out, "of length", length)
        }
        cat(out, "\n", sep = "")
    }



#' @rdname showHeader
#' @export
setMethod(
    f = "showHeader",
    signature = signature("ANY"),
    definition = `showHeader,ANY`
)
