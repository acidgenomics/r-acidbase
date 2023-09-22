#' Split the elements of a character vector into a matrix
#'
#' @export
#' @note Updated 2023-09-22.
#'
#' @param x `character`.
#' Character vector that does not contain `NA` or empty strings.
#'
#' @param split `character(1)`.
#' String that defines the split boundary. The number of characters (`nchar`)
#' can be greater than 1 here. Regular expressions are intentionally not
#' supported to keep this simple.
#'
#' @param fixed `logical(1)`.
#' If `TRUE`, `pattern` is a string to be matched as is.
#' Otherwise, will match by regular expression.
#'
#' @param n `Inf` or `integer(1)`.
#' Maximum number of strings to return. If `Inf`, return all strings defined
#' by split boundary. When set, function will split up to this number.
#'
#' @return `matrix`.
#' Character matrix split into columns.
#'
#' @seealso
#' - Infinite splits: [strsplit()].
#' - Finite splits: [gregexpr()], [substr()].
#' - [stringi::stri_split_fixed()].
#' - [stringr::str_split_fixed()].
#'
#' @examples
#' ## Infinite number of fixed splits.
#' x <- c("a__b__c", "d__e__f", "g__h__i")
#' mat <- strSplit(x = x, split = "__", fixed = TRUE, n = Inf)
#' print(mat)
#'
#' ## Infinite number of regex splits.
#' x <- c("a_b_c_d", "e_f__g___h", "i__j__k__l")
#' mat <- strSplit(x = x, split = "_+", fixed = FALSE, n = Inf)
#' print(mat)
#'
#' ## Finite number of fixed splits.
#' x <- c("a__b__c", "d__e__f", "g__h__i")
#' mat <- strSplit(x = x, split = "__", fixed = TRUE, n = 2L)
#' print(mat)
#'
#' ## Finite number of regex splits.
#' x <- c("a_b_c_d", "e_f__g___h", "i__j__k__l")
#' mat <- strSplit(x = x, split = "_+", fixed = FALSE, n = 2L)
#' print(mat)
strSplit <- function(x, split, fixed = TRUE, n = Inf) {
    assert(
        isCharacter(x),
        isString(split),
        isFlag(fixed),
        ifelse(
            test = fixed,
            yes = allAreMatchingFixed,
            no = allAreMatchingRegex
        )(x = x, pattern = split),
        isInt(n),
        isInRange(n, lower = 2L, upper = Inf)
    )
    if (is.finite(n)) {
        x <- .strSplitFinite(x = x, split = split, n = n, fixed = fixed)
    } else {
        x <- .strSplitInfinite(x = x, split = split, fixed = fixed)
    }
    n2 <- lengths(x)
    assert(
        length(unique(n2)) == 1L,
        msg = sprintf(
            "Split mismatch detected: %s.",
            toString(which(n2 != n2[[1L]]))
        )
    )
    n2 <- n2[[1L]]
    x <- unlist(x = x, recursive = FALSE, use.names = FALSE)
    x <- matrix(data = x, ncol = n2, byrow = TRUE)
    x
}



#' Split a string into a finite number of capture groups
#'
#' @note Updated 2023-09-22.
#' @noRd
#'
#' @seealso
#' - [gregexec()].
#' - [gregexpr()].
.strSplitFinite <- function(x, split, n, fixed) {
    assert(
        is.character(x),
        isString(split),
        isInt(n),
        isInRange(n, lower = 2L, upper = Inf),
        isFlag(fixed)
    )
    m <- gregexpr(pattern = split, text = x, fixed = fixed)
    ln <- lengths(m)
    assert(
        all((ln + 1L) >= n),
        msg = sprintf(
            "Not enough to split: %s.",
            toString(which((ln + 1L) < n))
        )
    )
    Map(
        x = x,
        m = m,
        n = n,
        f = function(x, m, n) {
            ml <- attr(m, "match.length")
            nl <- seq_len(n)
            m <- m[nl]
            ml <- ml[nl]
            out <- substr(x = x, start = 1L, stop = m[[1L]] - 1L)
            i <- 1L
            while (i < (length(m) - 1L)) {
                out <- append(
                    x = out,
                    values = substr(
                        x = x,
                        start = m[[i]] + ml[[i]],
                        stop = m[[i + 1L]] - 1L
                    )
                )
                i <- i + 1L
            }
            out <- append(
                x = out,
                values = substr(
                    x = x,
                    start = m[[n - 1L]] + ml[[n - 1L]],
                    stop = nchar(x)
                )
            )
            out
        },
        USE.NAMES = FALSE
    )
}



#' Split a string into an finite number of capture groups
#'
#' @note Updated 2023-09-22.
#' @noRd
#'
#' @seealso
#' - [strsplit()].
.strSplitInfinite <- function(x, split, fixed) {
    assert(
        is.character(x),
        isString(split),
        isFlag(fixed)
    )
    strsplit(x = x, split = split, fixed = fixed)
}
