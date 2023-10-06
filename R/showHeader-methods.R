#' @name showHeader
#' @inherit AcidGenerics::showHeader
#' @note Updated 2023-10-06.
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



## Updated 2023-09-21.
`showHeader,ANY` <- # nolint
    function(object) {
        class <- class(object)[[1L]]
        x <- class
        length <- length(object)
        if (!is.null(length)) {
            x <- paste(x, "of length", length)
        }
        cat(x, "\n", sep = "")
        invisible(NULL)
    }



## Updated 2023-10-06.
`showHeader,Annotated` <- # nolint
    function(object) {
        class <- class(object)[[1L]]
        x <- class
        versionKey <- "packageVersion"
        if (isSubset("version", names(metadata(object)))) {
            versionKey <- "version"
        }
        version <- as.character(metadata(object)[[versionKey]])
        if (hasLength(version)) {
            x <- paste(x, version)
        }
        if (hasDims(object)) {
            if (is(object, "DFrameList")) {
                d <- apply(
                    X = dims(object),
                    MARGIN = 2L,
                    FUN = paste0,
                    collapse = ":",
                    simplify = TRUE
                )
                if (hasLength(d, n = 2L)) {
                    y <- sprintf(
                        "with %s rows and %s columns",
                        d[[1L]], d[[2L]]
                    )
                    x <- paste(x, y)
                }
            } else {
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
            }
        } else {
            ## e.g. List.
            ln <- length(object)
            if (!is.null(ln)) {
                x <- paste(x, "of length", ln)
            }
        }
        cat(x, "\n", sep = "")
        invisible(NULL)
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
