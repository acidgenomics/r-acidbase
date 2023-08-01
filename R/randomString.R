#' Generate a random string
#'
#' @export
#' @note Updated 2023-08-01.
#'
#' @param n `integer(1)`.
#' Number of characters to return. Length of string.
#'
#' @return `character(1)`.
#'
#' @seealso
#' - https://stackoverflow.com/questions/42734547/
#'
#' @examples
#' x <- randomString()
#' print(x)
randomString <- function(n = 10L) {
    x <- c(
        LETTERS, letters,
        seq(from = 0L, to = 9L, by = 1L)
    )
    x <- sample(x = x, size = n)
    x <- paste0(x, collapse = "")
    x
}
