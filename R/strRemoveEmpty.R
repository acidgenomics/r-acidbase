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
#' @return `character`.
#' Modified vector, with empty strings removed.
#'
#' @seealso
#' - [stringi::stri_remove_empty()].
#'
#' @examples
#' x <- c("", "a", "b", NA)
#' y <- strRemoveEmpty(x, naOk = TRUE)
#' print(y)
#' y <- strRemoveEmpty(x, naOk = FALSE)
#' print(y)
strRemoveEmpty <- function(x, naOk = TRUE) {
    assert(
        is.character(x),
        isFlag(naOk)
    )
    ok <- nchar(x) != 0L
    ok[is.na(ok)] <- naOk
    y <- x[ok]
    y
}
