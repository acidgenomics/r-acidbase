#' Concatenate strings to form a URL
#'
#' @export
#' @note Updated 2023-09-19.
#'
#' @details
#' Encoding is applied automatically via `utils::URLencode`.
#'
#' @param ... Character strings.
#' Intentionally does not support recycling here, unlike base `paste`.
#'
#' @param protocol `character(1)`.
#' Desired protocol to use. Defaults to "https" but "http", "ftp", and "s3"
#' (AWS S3) are also supported. Use `"none"` if you want to prepare a URL that
#' already contains a protocol in the first element of the dots.
#'
#' @return `character`.
#' URL path, containing forward slashes (`/`).
#'
#' @examples
#' ## HTTPS.
#' x <- pasteURL(
#'     "steinbaugh.com",
#'     "basejump",
#'     "reference",
#'     protocol = "https"
#' )
#' print(x)
#'
#' ## FTP.
#' x <- pasteURL(
#'     "ftp.ensembl.org",
#'     "pub",
#'     "release-94",
#'     "gtf",
#'     "homo_sapiens",
#'     "Homo_sapiens.GRCh38.94.gtf.gz",
#'     protocol = "ftp"
#' )
#' print(x)
#'
#' ## Automatic encoding support.
#' x <- pasteURL(
#'     "rest.ensembl.org",
#'     "info",
#'     "assembly",
#'     "Homo sapiens",
#'     protocol = "https"
#' )
#' print(x)
pasteURL <-
    function(...,
             protocol = c("none", "https", "http", "ftp", "rsync", "s3")) {
        dots <- list(...)
        assert(
            hasLength(dots),
            all(bapply(X = dots, FUN = isString)),
            msg = "Dots must only contain character strings."
        )
        assert(requireNamespaces("utils"))
        dots <- unlist(x = dots, recursive = FALSE, use.names = FALSE)
        protocol <- match.arg(protocol)
        ## This is useful for FTP servers.
        addTrailingSlash <-
            !identical(dots[[length(dots)]], "/") &&
            grepl(pattern = "/$", x = dots[[length(dots)]])
        dots <- gsub(pattern = "/$", replacement = "", x = dots)
        if (isTRUE(addTrailingSlash)) {
            dots <- append(x = dots, values = "")
        }
        url <- paste(dots, collapse = "/")
        if (!identical(protocol, "none")) {
            url <- paste0(protocol, "://", url)
        }
        url <- utils::URLencode(url)
        url
    }
