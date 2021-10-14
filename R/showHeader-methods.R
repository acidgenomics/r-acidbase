#' @name showHeader
#' @inherit AcidGenerics::showHeader
#' @note Updated 2021-10-14.
#'
#' @inheritParams AcidRoxygen::params
#' @param ... Additional arguments.
#'
#' @examples
#' data(
#'     DataFrame,
#'     matrix,
#'     package = "AcidTest"
#' )
#'
#' ## ANY (matrix) ====
#' object <- matrix
#' showHeader(object)
#'
#' ## Annotated ====
#' ## This virtual class supports `metadata()` slot.
#' object <- DataFrame
#' showHeader(object)
#' metadata(object)[["packageVersion"]] <- package_version("0.0.1")
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



## Updated 2021-02-23.
`showHeader,Annotated` <-  # nolint
    function(object) {
        class <- class(object)[[1L]]
        x <- class
        versionKey <- "packageVersion"
        ## Provide support for legacy objects with "version" metadata instead
        ## of the now preferred "packageVersion" approach.
        if (isSubset("version", names(metadata(object)))) {
            versionKey <- "version"
        }
        version <- as.character(metadata(object)[[versionKey]])
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
    signature = signature(object = "ANY"),
    definition = `showHeader,ANY`
)

#' @rdname showHeader
#' @export
setMethod(
    f = "showHeader",
    signature = signature(object = "Annotated"),
    definition = `showHeader,Annotated`
)
