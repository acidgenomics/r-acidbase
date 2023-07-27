#' Concatenate strings to form a URL
#'
#' @export
#' @note Updated 2023-07-27.
#'
#' @inheritParams base::paste
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
        dots <- unlist(list(...))
        assert(
            requireNamespaces("utils"),
            isCharacter(dots)
        )
        protocol <- match.arg(protocol)
        dots <- gsub(pattern = "/$", replacement = "", x = dots)
        url <- paste(dots, collapse = "/")
        if (!identical(protocol, "none")) {
            url <- paste0(protocol, "://", url)
        }
        url <- utils::URLencode(url)
        url
    }
