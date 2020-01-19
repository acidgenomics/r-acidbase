## extPattern ==================================================================
#' File extension pattern matching
#'
#' @name extPattern
#' @note Updated 2019-10-21.
#'
#' @examples
#' extPattern
#' compressExtPattern
NULL

#' @rdname extPattern
#' @name extPattern
#' @export
NULL

#' @rdname extPattern
#' @name compressExtPattern
#' @export
NULL

compressExtPattern <- "\\.(bz2|gz|xz|zip)"
extPattern <- paste0(
    "\\.([a-zA-Z0-9]+)",
    "(", compressExtPattern, ")?$"
)
compressExtPattern <- paste0(compressExtPattern, "$")



## formalsList =================================================================
#' List of global formals
#'
#' These can be overwritten using the `options` function.
#'
#' @export
#' @note Updated 2020-01-19
formalsList <- list(
    compress.remove = quote(
        getOption("acid.compress.remove", default = TRUE)
    ),
    decompress.remove = quote(
        getOption("acid.compress.remove", default = TRUE)
    ),
    export.compress = quote(
        getOption("acid.export.compress", default = FALSE)
    ),
    export.dir = quote(
        getOption("acid.export.dir", default = ".")
    ),
    export.ext = quote(
        getOption("acid.export.ext", default = "csv")
    ),
    export.sparse.ext = quote(
        getOption("acid.export.sparse.ext", default = "mtx")
    ),
    export.quiet = quote(
        getOption("acid.export.quiet", default = FALSE)
    ),
    import.metadata = quote(
        getOption("acid.import.metadata", default = FALSE)
    ),
    load.dir = quote(
        getOption("acid.load.dir", default = ".")
    ),
    overwrite = quote(
        getOption("acid.overwrite", default = TRUE)
    ),
    quiet = quote(
        getOption("acid.quiet", default = FALSE)
    ),
    save.compress = quote(
        getOption("acid.save.compress", default = TRUE)
    ),
    save.dir = quote(
        getOption("acid.save.dir", default = ".")
    ),
    save.ext = quote(
        getOption("acid.save.ext", default = "rds")
    )
)
