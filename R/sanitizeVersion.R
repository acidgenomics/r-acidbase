#' Sanitize version
#'
#' @export
#' @note Updated 2020-04-09.
#'
#' @inheritParams params
#'
#' @examples
#' x <- c("2.7.15rc1", "1.10.0-patch1", "1.0.2k-fips")
#' sanitizeVersion(x)
sanitizeVersion <- function(x) {
    x <- as.character(x)
    ## Strip anything following a space.
    x <- sub("[[:space:]].+$", "", x)
    ## Strip trailing "+" (e.g. "Python 2.7.15+").
    x <- sub("\\+$", "", x)
    ## Strip quotes (e.g. `java -version` returns '"12.0.1"').
    x <- gsub("\"", "", x)
    ## Strip hyphenated terminator.(e.g. `java -version` returns "1.8.0_212").
    x <- sub("(-|_).+$", "", x)
    x <- sub("\\.([0-9]+)[-a-z]+[0-9]+?$", ".\\1", x)
    ## Strip leading letter.
    x <- sub("^[a-z]+", "", x)
    ## Strip trailing letter.
    x <- sub("[a-z]+$", "", x)
    x <- numeric_version(x)
    x
}
