#' Compress or decompress a file
#'
#' Compress or decompress using gzip, bzip2, or xz compression.
#'
#' @name compress
#' @export
#' @note For ZIP files, refer to `zip` and `unzip` in the utils package.
#' @note Updated 2020-01-19.
#'
#' @param remove `logical(1)`.
#'   Remove the input file once the output file is fully created and the
#'   connection is closed.
#'
#' @seealso
#' - `help("connections")`
#' - `R.utils::compressFile`, `R.utils::decompressFile`.
#' - `utils::zip`, `utils::unzip`.
#' - `utils::tar`, `utils::untar`.
#' - `memCompress`, `memDecompress`.
#'
#' @examples
#' con <- file("test.txt")
#' writeLines(c("hello","world"), con)
#' close(con)
NULL



## Modified version of:
## > getS3method(f = "compressFile", class = "default")

#' @rdname compress
#' @export
compress <- function(
    file,
    ext = c("gz", "bz2", "xz", "zip"),
    remove,
    overwrite
) {
    stopifnot(
        .isString(file),
        isTRUE(file.exists(file)),
        .isFlag(remove),
        .isFlag(overwrite)
    )
    ext <- match.arg(ext)
    destfile <- sprintf("%s.%s", file, ext)
    stopifnot(!identical(file, destfile))
    whatFun <- switch(
        EXPR = ext,
        bz2 = "bzfile",
        gz = "gzfile",
        xz = "xzfile",
        zip = "zip"
    )
    FUN <- get(
        x = whatFun,
        envir = asNamespace("base"),
        mode = "function",
        inherits = FALSE
    )
    stopifnot(is.function(FUN))
    if (isTRUE(file.exists(destfile))) {
        if (isTRUE(overwrite)) {
            message(sprintf("Overwriting file: '%s'.", destfile))
            file.remove(destfile)
        } else {
            stop(sprintf("File exists: '%s'.", destfile))
        }
    }
    ## For ZIP files, hand off to `utils::zip()` and early return.
    if (identical(ext, "zip")) {
        FUN(zipfile = destfile, files = file)
        return(invisible(destfile))
    }
    inn <- file(description = file, open = "rb")
    on.exit(if (!is.null(inn)) close(inn))
    outComplete <- FALSE
    out <- FUN(description = destfile, open = "wb")
    on.exit({
        if (!is.null(out)) close(out)
        if (!isTRUE(outComplete)) file.remove(destfile)
    }, add = TRUE)
    nbytes <- 0
    repeat {
        bfr <- readBin(
            con = inn,
            what = raw(0L),
            size = 1L,
            ## See 'BFR.SIZE' argument in `R.utils::compressFile`.
            n = 1e+07
        )
        n <- length(bfr)
        if (n == 0L) break
        nbytes <- nbytes + n
        writeBin(bfr, con = out, size = 1L)
        bfr <- NULL
    }
    outComplete <- TRUE
    close(out)
    out <- NULL
    attr(destfile, "bytes") <- nbytes
    if (isTRUE(remove)) {
        close(inn)
        inn <- NULL
        file.remove(file)
    }
    invisible(destfile)
}

formals(compress)[c("remove", "overwrite")] <-
    formalsList[c(
        "compress.remove",
        "overwrite"
    )]



## Modified version of:
## > getS3method(f = "decompressFile", class = "default")

#' @rdname compress
#' @export
decompress <- function (
    file,
    remove,
    overwrite
) {
    stopifnot(
        .isString(file),
        isTRUE(file.exists(file)),
        isTRUE(grepl(pattern = compressExtPattern, x = file)),
        .isFlag(remove),
        .isFlag(overwrite)
    )
    ext <- substring(
        text = file,
        first = regexpr(
            pattern = compressExtPattern,
            text = file,
            ignore.case = TRUE
        ) + 1L
    )
    whatFun <- switch(
        EXPR = ext,
        bz2 = "bzfile",
        gz = "gzfile",
        xz = "xzfile",
        zip = "unzip"
    )
    FUN <- get(
        x = whatFun,
        envir = asNamespace("base"),
        mode = "function",
        inherits = FALSE
    )
    stopifnot(is.function(FUN))
    destfile <- gsub(
        pattern = sprintf("[.]%s$", ext),
        replacement = "",
        x = file,
        ignore.case = TRUE
    )
    stopifnot(!identical(file, destfile))
    if (isTRUE(file.exists(destfile))) {
        if (isTRUE(overwrite)) {
            file.remove(destfile)
        }
        else {
            stop(sprintf("File exists: '%s'.", destfile))
        }
    }
    ## For ZIP files, hand off to `utils::unzip()` and early return.
    if (identical(ext, "zip")) {
        destfile <- FUN(
            zipfile = file,
            files = NULL,
            list = FALSE,
            overwrite = overwrite,
            junkpaths = FALSE,
            exdir = ".",
            unzip = "internal",
            setTimes = FALSE
        )
        if (length(destfile) > 1L) {
            message(sprintf("'%s' contains multiple files.", basename(file)))
        }
        destfile <- realpath(destfile)
        return(invisible(destfile))
    }
    inn <- FUN(file, open = "rb")
    on.exit(if (!is.null(inn)) close(inn))
    outComplete <- FALSE
    out <- file(destfile, open = "wb")
    on.exit({
        if (!is.null(out)) close(out)
        if (!outComplete) file.remove(destfile)
    }, add = TRUE)
    nbytes <- 0
    repeat {
        bfr <- readBin(
            inn,
            what = raw(0L),
            size = 1L,
            ## See 'BFR.SIZE' argument in `R.utils::decompressFile`.
            n = 1e+07
        )
        n <- length(bfr)
        if (n == 0L) break
        nbytes <- nbytes + n
        writeBin(bfr, con = out, size = 1L)
        bfr <- NULL
    }
    outComplete <- TRUE
    close(out)
    out <- NULL
    attr(destfile, "bytes") <- nbytes
    if (remove) {
        close(inn)
        inn <- NULL
        file.remove(file)
    }
    invisible(destfile)
}

formals(decompress)[c("remove", "overwrite")] <-
    formalsList[c(
        "decompress.remove",
        "overwrite"
    )]
