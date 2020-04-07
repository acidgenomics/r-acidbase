#' Positional command line arguments
#'
#' These arguments do not contain `--` prefixes.
#'
#' Intended for using inside Rscript files.
#'
#' @export
#' @note Updated 2020-04-07.
#'
#' @examples
#' positionalArgs()
positionalArgs <- function() {
    x <- commandArgs(trailingOnly = TRUE)
    keep <- !grepl(pattern = "^--", x = x)
    x <- x[keep]
    x
}
