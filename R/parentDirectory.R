#' Parent directory recursion
#'
#' @export
#' @note Updated 2021-08-19.
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
        allAreDirs(path),
        isInt(n)
    )
    out <- realpath(file.path(path, rep(x = "..", times = n)))
    names(out) <- names(path)
    out
}



#' @rdname parentDirectory
#' @export
parentDir <- parentDirectory
