#' Positional command line arguments
#'
#' These arguments do not contain `--` prefixes.
#'
#' Intended for using inside Rscript files.
#'
#' @export
#' @note Updated 2020-05-09.
#'
#' @examples
#' positionalArgs()
#'
#' ## $ Rscript test.Rscript "AAA" "BBB"
#' ## > positionalArgs()
#' ## c("AAA", "BBB")
positionalArgs <- function() {
    x <- commandArgs(trailingOnly = TRUE)
    keep <- !grepl(pattern = "^--", x = x)
    x <- x[keep]
    if (length(x) == 0L) {
        stop("No positional arguments are defined.")
    }
    x
}
