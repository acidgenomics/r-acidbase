#' Parent directory recursion
#'
#' @export
#' @note Updated 2021-08-19.
#'
#' @details
#' Function always resolves directory path internally, using `realpath`.
#'
#' @param path `character`.
#'   Directory path(s).
#' @param n `logical(1)`.
#'   Number of levels to recursive.
#'   Defaults to the immediate parent, similar to `dirname`.
#'
#' @return `character`.
#'
#' @examples
#' parentDir(path = getwd())
parentDirectory <- function(path, n = 1L) {
    assert(
        allHaveAccess(path),
        isInt(n),
        isPositive(n),
        isTRUE(is.finite(n))
    )
    names <- names(path)
    x <- realpath(path)
    x <- dirname(path)
    n <- n - 1L
    if (isPositive(n)) {
        x <- vapply(
            X = path,
            n = n,
            FUN = function(x, n) {
                do.call(
                    what = file.path,
                    args = as.list(
                        append(
                            x = x,
                            values = rep("..", times = n)
                        )
                    )
                )
            },
            FUN.VALUE = character(1L),
            USE.NAMES = FALSE
        )
    }
    x <- realpath(x)
    names(x) <- names
    x
}



#' @rdname parentDirectory
#' @export
parentDir <- parentDirectory
