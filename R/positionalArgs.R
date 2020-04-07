#' Positional arguments
#'
#' These arguments do not contain `--` prefixes.
#'
#' @note Updated 2020-02-20.
#' @noRd
positionalArgs <- function() {
    trailingArgs <- commandArgs(trailingOnly = TRUE)
    keep <- !grepl(pattern = "^--", x = trailingArgs)
    trailingArgs[keep]
}
