#' Parent directory recursion
#'
#' @export
#' @note Updated 2021-09-03.
#'
#' @details
#' Function always resolves directory path internally, using `realpath`.
#'
#' @param path `character`.
#'   Local file and/or directory paths.
#'   Also supports URLs.
#' @param n `logical(1)`.
#'   Number of levels to recursive.
#'   Defaults to the immediate parent, similar to `dirname`.
#' @param fsep `character(1)`.
#'   Path separator to use (e.g. `"/"`).
#'
#' @return `character`.
#'
#' @examples
#' parentDir(path = getwd())
parentDirectory <- function(
    path,
    n = 1L,
    fsep
) {
    assert(
        isCharacter(path),
        isInt(n),
        isPositive(n),
        isTRUE(is.finite(n)),
        isString(fsep)
    )
    names <- names(path)
    x <- strsplit(x = path, split = fsep, fixed = TRUE)
    x <- vapply(
        X = x,
        n = n,
        fsep = fsep,
        FUN = function(x, n, fsep) {
            x <- x[1L:(length(x) - n)]
            x <- do.call(
                what = file.path,
                args = append(x = x, values = list("fsep" = fsep))
            )
            x
        },
        FUN.VALUE = character(1L),
        USE.NAMES = FALSE
    )
    names(x) <- names
    x
}

formals(parentDirectory)[["fsep"]] <- formals(file.path)[["fsep"]]



#' @rdname parentDirectory
#' @export
parentDir <- parentDirectory
