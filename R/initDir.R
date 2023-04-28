# FIXME Add parameterization support here.



#' Initialize directory
#'
#' Checks and creates a directory recursively automatically.
#'
#' Useful for setting up functions that require writes to a user-specified
#' directory.
#'
#' @export
#' @note Updated 2022-06-02.
#'
#' @param dir `character(1)`.
#' Directory path.
#'
#' @return `character(1)`.
#' Directory path.
#'
#' @examples
#' dir <- file.path(tempdir(), "testdir")
#' dir.exists(dir)
#' dir <- initDir(dir)
#' dir.exists(dir)
#' print(dir)
#' unlink2(dir)
initDir <- function(dir) {
    assert(isString(dir))
    if (!isADir(dir)) {
        dir.create(dir, recursive = TRUE, showWarnings = FALSE)
    }
    invisible(realpath(dir))
}
