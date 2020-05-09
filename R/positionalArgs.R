#' Positional command line arguments
#'
#' These arguments do not contain `--` prefixes.
#'
#' Intended for using inside Rscript files.
#'
#' @export
#' @note Updated 2020-05-09.
#'
#' @param required `logical(1)`.
#'  Error if no positional arguments are defined.
#'
#' @return `character`.
#'
#' @examples
#' ## $ Rscript test.Rscript "AAA" "BBB"
#' ## > positionalArgs()
#' ## c("AAA", "BBB")
positionalArgs <- function(required = TRUE) {
    x <- commandArgs(trailingOnly = TRUE)
    keep <- !grepl(pattern = "^--", x = x)
    x <- x[keep]
    if (isTRUE(required)) {
        if (length(x) == 0L) {
            stop("No positional arguments are defined.")
        }
    }
    x
}
