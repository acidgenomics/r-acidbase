#' Truncate a string with ellipsis, if necessary
#'
#' @export
#' @note Updated 2022-10-20.
#'
#' @param x `character(1)`.
#' Character string.
#'
#' @param n `integer(1)`.
#' Maximum number of characters.
#' Function will truncate with `"..."`, when applicable.
#'
#' @seealso
#' - https://stackoverflow.com/questions/46759358/
#'
#' @examples
#' truncateString("abcdefgi", n = 6L)
truncateString <- function(x, n = 200L) {
    assert(
        isString(x),
        isInt(n)
    )
    ifelse(
        test = nchar(x) > n,
        yes = paste0(
            substring(
                text = x,
                first = 1L,
                last = n - 3L
            ),
            "..."
        ),
        no = x
    )
}
