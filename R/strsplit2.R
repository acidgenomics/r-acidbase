#' Split the elements of a character vector into a matrix
#'
#' @export
#' @note Updated 2023-09-13.
#'
#' @return `matrix`.
#'
#' @seealso
#' - stringi::stri_split_fixed
#' - stringr::str_split_fixed
#'
#' @examples
#' x <- c(
#'     "TSPAN6_ENST00000373020",
#'     "TSPAN6_ENST00000494424",
#'     "TSPAN6_ENST00000496771",
#'     "TSPAN6_ENST00000612152",
#'     "TSPAN6_ENST00000614008"
#' )
#' x <- strsplit2(x = x, split = "_")
#' print(x)
strsplit2 <- function(x, split) {
    assert(
        isCharacter(x),
        isString(split),
        identical(nchar(split), 1L),
        allAreMatchingFixed(x = x, pattern = split)
    )
    x <- strsplit(x = x, split = split, fixed = TRUE)
    ncol <- length(x[[1L]])
    x <- unlist(x, recursive = FALSE, use.names = FALSE)
    x <- matrix(data = x, ncol = ncol, byrow = TRUE)
}
