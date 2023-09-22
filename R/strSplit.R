## FIXME Support splitting by regular expression.



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



## FIXME Try using a regex here, for better handling.

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
    ## FIXME This will perform infinite splits, but not stop at n...how to
    ## add that functionality?
    lst <- Map(
        x = x,
        m = m,
        n = n,
        FUN = function(x, m, n) {
            i <- 1L
            ml <- attr(m, "match.length")
            out <- substr(x = x, start = 1L, stop = m[[1L]] - 1L)
            while (i < length(m)) {
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
                    start = m[[3L]] + ml[[3L]],
                    stop = nchar(x)
                )
            )
            out
        }
    )

    ## FIXME Error if not enough splits.
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
