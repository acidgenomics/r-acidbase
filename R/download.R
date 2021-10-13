#' Download a file from the Internet
#'
#' @export
#' @note Updated 2021-08-13.
#'
#' @details
#' Unlike [utils::download.file()], intentionally errors on any download
#' failure. Automatically sets a long time out internally via
#' `options(timeout = 9999L)`, to avoid download issues related to `timeout`
#' configuration in `Rprofile`.
#'
#' @param url `character(1)`.
#'   URL.
#' @param destfile `character(1)`.
#'   Destination file.
#' @param quiet `logical(1)`.
#'   Suppress status messages.
#' @param ... Passthrough arguments to [utils::download.file()].
#'
#' @return `character(1)`.
#'   Destination file path.
#'   Note that this differs from `download.file`, which returns a status code
#'   (e.g. `0` for success) instead.
#'
#' @examples
#' url <- "https://bioconductor.org/bioc-version"
#' destfile <- "bioc-version.txt"
#' out <- download(url = url, destfile = destfile, quiet = TRUE)
#' print(out)
#' file.remove(out)
download <-
    function(
        url,
        destfile,
        quiet = FALSE,
        ...
    ) {
        assert(
            isString(url),
            isString(destfile),
            isFlag(quiet)
        )
        destfile <- normalizePath(destfile, mustWork = FALSE)
        if (!isADir(dirname(destfile))) {
            dir.create(path = dirname(destfile), recursive = TRUE)  # nocov
        }
        timeout <- getOption(x = "timeout")
        if (is.numeric(timeout)) {
            options("timeout" = 99999L)
        }
        if (isFALSE(quiet)) {
            ## nocov start
            alert(sprintf(
                "Downloading {.url %s} to {.file %s}.",
                url, destfile
            ))
            ## nocov end
        }
        ## Ensure that warnings are converted to errors here.
        status <- tryCatch(
            expr = download.file(
                url = url,
                destfile = destfile,
                quiet = quiet,
                ...
            ),
            warning = function(w) {
                abort(w)  # nocov
            }
        )
        if (!identical(status, 0L)) {
            ## nocov start
            abort(sprintf(
                "Failed to download {.url %s} to {.file %s} successfully.",
                url, destfile
            ))
            ## nocov end
        }
        if (is.numeric(timeout)) {
            options("timeout" = timeout)
        }
        invisible(destfile)
    }
