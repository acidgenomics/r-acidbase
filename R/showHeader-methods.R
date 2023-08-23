#' @name showHeader
#' @inherit AcidGenerics::showHeader
#' @note Updated 2023-08-23.
#'
#' @inheritParams AcidRoxygen::params
#' @param ... Additional arguments.
#'
#' @examples
#' data(
#'     DFrame,
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
#' object <- DFrame
#' showHeader(object)
#' S4Vectors::metadata(object)[["packageVersion"]] <- package_version("0.0.1")
#' showHeader(object)
NULL



## Updated 2021-02-04.
`showHeader,ANY` <- # nolint
    function(object) {
        class <- class(object)[[1L]]
        x <- class
        length <- length(object)
        if (!is.null(length)) {
            x <- paste(x, "of length", length)
        }
        cat(x, "\n", sep = "")
    }



## Updated 2023-08-23.
`showHeader,Annotated` <- # nolint
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
        if (hasDims(object)) {
            ## e.g. DFrame.
            d <- dim(object)
            if (hasLength(d, n = 2L)) {
                y <- sprintf(
                    "with %d %s and %d %s",
                    d[[1L]],
                    ngettext(n = d[[1L]], msg1 = "row", msg2 = "rows"),
                    d[[2L]],
                    ngettext(n = d[[1L]], msg1 = "column", msg2 = "columns")
                )
                x <- paste(x, y)
            }
        } else {
            ## e.g. List.
            ln <- length(object)
            if (!is.null(ln)) {
                x <- paste(x, "of length", ln)
            }
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
