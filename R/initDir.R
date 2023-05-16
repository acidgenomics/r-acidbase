#' Initialize directory
#'
#' Checks and creates a directory recursively automatically.
#'
#' Useful for setting up functions that require writes to a user-specified
#' directory.
#'
#' @export
#' @note Updated 2023-05-16.
#'
#' @param dir `character`.
#' Directory path(s).
#'
#' @return `character`.
#' Directory path(s).
#'
#' @examples
#' dir <- file.path(tempdir2(), c("aaa", "bbb"))
#' dir.exists(dir)
#' dir <- initDir(dir)
#' dir.exists(dir)
#' print(dir)
#' unlink2(dir)
initDir <- function(dir) {
    assert(isCharacter(dir))
    invisible(bapply(
        X = dir,
        FUN = function(dir) {
            if (isADir(dir)) {
                return(FALSE)
            }
            dir.create(path = dir, recursive = TRUE, showWarnings = FALSE)
        },
        USE.NAMES = FALSE
    ))
    assert(allAreDirs(dir))
    invisible(realpath(dir))
}
