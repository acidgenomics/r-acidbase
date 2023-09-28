#' Remove empty strings
#'
#' @export
#' @note Updated 2023-09-28.
#'
#' @param x `character`.
#' Character vector.
#'
#' @param naOk `logical(1)`.
#' Allow `NA` values to propagate.
#'
#' @param spacesOk `logical(1)`.
#' Consider spaces to be non-empty.
#'
#' @return `character`.
#' Modified vector, with empty strings removed.
#'
#' @seealso
#' - [stringi::stri_remove_empty()].
#'
#' @examples
#' x <- c("", "a", "b", " ", NA)
#' y <- strRemoveEmpty(x, naOk = TRUE, spacesOk = TRUE)
#' print(y)
#' y <- strRemoveEmpty(x, naOk = FALSE, spacesOk = FALSE)
#' print(y)
strRemoveEmpty <- function(x, naOk = TRUE, spacesOk = TRUE) {
    assert(
        is.character(x),
        isFlag(naOk),
        isFlag(spacesOk)
    )
    if (isFALSE(spacesOk)) {
        ok <- !grepl(pattern = "^\\s+$", x = x)
        x <- x[ok]
    }
    ok <- nchar(x) != 0L
    ok[is.na(ok)] <- naOk
    x <- x[ok]
    x
}
