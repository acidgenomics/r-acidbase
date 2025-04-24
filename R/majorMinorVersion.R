#' Major and minor version
#'
#' @export
#' @note Updated 2023-01-30.
#'
#' @inheritParams params
#'
#' @return `numeric_version`.
#'
#' @examples
#' majorMinorVersion(c("1.0.0", "2.1"))
majorMinorVersion <- function(x) {
    x <- as.character(x)
    assert(isCharacter(x))
    x <- strsplit(x = x, split = ".", fixed = TRUE)
    x <- vapply(
        X = x,
        FUN = function(x) {
            if (identical(length(x), 1L)) {
                return(x)
            }
            x <- paste(x[seq_len(2L)], collapse = ".")
            x
        },
        FUN.VALUE = character(1L),
        USE.NAMES = FALSE
    )
    x <- numeric_version(x)
    x
}


#' @rdname majorMinorVersion
#' @export
minorVersion <- function(x) {
    .Deprecated("majorMinorVersion")
    majorMinorVersion(x)
}
