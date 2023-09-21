#' Split the elements of a character vector into a matrix
#'
#' @export
#' @note Updated 2023-09-21.
#'
#' @param x `character`.
#' Character vector that does not contain `NA` or empty strings.
#'
#' @param split `character(1)`.
#' String that defines the split boundary. The number of characters (`nchar`)
#' can be greater than 1 here. Regular expressions are intentionally not
#' supported to keep this simple.
#'
#' @param n `Inf` or `integer(1)`.
#' Maximum number of strings to return. If `Inf`, return all strings defined
#' by split boundary. When set, function will split up to this number.
#'
#' @return `matrix`.
#' Character matrix split into columns.
#'
#' @seealso
#' - [strsplit()].
#' - [stringi::stri_split_fixed()].
#' - [stringr::str_split_fixed()].
#'
#' @examples
#' x <- c(
#'     "TSPAN6_ENST00000373020",
#'     "TSPAN6_ENST00000494424",
#'     "TSPAN6_ENST00000496771",
#'     "TSPAN6_ENST00000612152",
#'     "TSPAN6_ENST00000614008"
#' )
#' x <- strSplit(x = x, split = "_")
#' print(x)
strSplit <- function(x, split, n = Inf) {
    assert(
        isCharacter(x),
        isString(split),
        allAreMatchingFixed(x = x, pattern = split),
        isInt(n),
        isInRange(n, lower = 2L, upper = Inf)
    )
    x <- strsplit(x = x, split = split, fixed = TRUE)
    n2 <- lengths(x)
    assert(
        length(unique(n2)) == 1L,
        msg = sprintf(
            "Split mismatch detected: %s.",
            toString(which(n2 != n2[[1L]]))
        )
    )
    n2 <- n2[[1L]]
    if (is.finite(n)) {
        assert(
            n <= n2,
            msg = sprintf(
                paste(
                    "Too many splits defined by {.var %s}:",
                    "{.val %d}; max {.val %d}."
                ),
                "n", n, n2
            )
        )
        ## Rejoin to "n" splits.
        x <- lapply(
            X = x,
            n = n,
            n2 = n2,
            split = split,
            FUN = function(x, n, n2, split) {
                i <- x[seq(from = 1L, to = n - 1L, by = 1L)]
                j <- paste0(
                    x[[n]], split,
                    x[seq(from = n + 1L, to = n2, by = 1L)],
                    collapse = ""
                )
                c(i, j)
            }
        )
    }
    x <- unlist(x = x, recursive = FALSE, use.names = FALSE)
    x <- matrix(data = x, ncol = n2, byrow = TRUE)
    x
}
