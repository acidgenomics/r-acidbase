## FIXME These changes are for EggNOG package.
## FIXME Also support "packageVersion" here...
## FIXME Also include "release" if defined...



#' @name showHeader
#' @inherit AcidGenerics::showHeader
#' @note Updated 2021-02-04.
#'
#' @inheritParams AcidRoxygen::params
#' @param ... Additional arguments.
#'
#' @examples
#' data(DFrame, matrix, package = "AcidTest")
#'
#' ## ANY (matrix) ====
#' object <- matrix
#' showHeader(object)
#'
#' ## Annotated (DataFrame) ====
#' ## Annotated virtual class supports `metadata()` slot.
#' object <- DFrame
#' showHeader(object)
#' metadata(object)[["version"]] <- package_version("0.0.1")
#' showHeader(object)
NULL



## Updated 2021-02-04.
`showHeader,ANY` <-  # nolint
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
`showHeader,Annotated` <-  # nolint
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
