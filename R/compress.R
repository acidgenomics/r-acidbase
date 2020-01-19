#' Compress or decompress a file
#'
#' Compress or decompress using gzip, bzip2, or xz compression.
#'
#' @name compress
#' @export
#' @note For ZIP files, refer to `zip` and `unzip` in the utils package.
#' @note Updated 2020-01-19.
#'
#' @inheritParams acidroxygen::params
#' @param ext `character(1)`.
#'   Compression file format extension.
#'   Uses [`match.arg()`][base::match.arg] internally and defaults to the first
#'   argument in the `character` vector.
#'
#'   Supported formats:
#'   - `gz`: gzip compression;
#'     calls [`gzfile()`][base::gzfile] internally.
#'   - `bz`: bzip2 (lzma) compression;
#'     calls [`bzfile()`][base::bzfile] internally.
#'   - `xz`: xz compression;
#'     calls [`xzfile()`][base::xzfile] internally.
#'   - `zip`: zip compression;
#'     calls [`zip()`][utils::zip] or [`unzip()`][utils::unzip] internally.
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
#' ## Create an example text file.
#' file <- "test.txt"
#' writeLines(text = c("hello","world"), con = file)
#' readLines(con = file)
#'
#' ## Apply gzip compression.
#' gzfile <- compress(file = file, ext = "gz", remove = TRUE, overwrite = TRUE)
#' gzfile
#' readLines(con = gzfile)
#' ## When `remove = TRUE`, the original input file will be removed.
#' file.exists(file)
#'
#' ## Decompress the gzipped file.
#' file <- decompress(file = gzfile, remove = TRUE, overwrite = TRUE)
#' file
#'
#' unlink(file)
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
        .isFlag(remove),
        .isFlag(overwrite)
    )
    file <- realpath(file)
    ext <- match.arg(ext)
    destfile <- sprintf("%s.%s", file, ext)
    stopifnot(!identical(file, destfile))
    if (isTRUE(file.exists(destfile))) {
        if (isTRUE(overwrite)) {
            message(sprintf("Overwriting file: '%s'.", destfile))
            file.remove(destfile)
        } else {
            stop(sprintf("File exists: '%s'.", destfile))
        }
    }
    whatFun <- switch(
        EXPR = ext,
        bz2 = "bzfile",
        gz = "gzfile",
        xz = "xzfile"
    )
    ## For ZIP files, hand off to `utils::zip()` and early return.
    if (identical(ext, "zip")) {
        zip(zipfile = destfile, files = file)
        if (isTRUE(remove)) {
            file.remove(file)
        }
        return(invisible(destfile))
    }
    FUN <- get(
        x = whatFun,
        envir = asNamespace("base"),
        mode = "function",
        inherits = FALSE
    )
    stopifnot(is.function(FUN))
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
decompress <- function(
    file,
    remove,
    overwrite
) {
    stopifnot(
        .isString(file),
        .isFlag(remove),
        .isFlag(overwrite)
    )
    file <- realpath(file)
    stopifnot(isTRUE(grepl(pattern = compressExtPattern, x = file)))
    ext <- substring(
        text = file,
        first = regexpr(
            pattern = compressExtPattern,
            text = file,
            ignore.case = TRUE
        ) + 1L
    )
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
        destfile <- unzip(
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
        if (isTRUE(remove)) {
            file.remove(file)
        }
        destfile <- realpath(destfile)
        return(invisible(destfile))
    }
    whatFun <- switch(
        EXPR = ext,
        bz2 = "bzfile",
        gz = "gzfile",
        xz = "xzfile"
    )
    FUN <- get(
        x = whatFun,
        envir = asNamespace("base"),
        mode = "function",
        inherits = FALSE
    )
    stopifnot(is.function(FUN))
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
