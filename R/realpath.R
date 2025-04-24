#' Express file paths in canonical form
#'
#' @export
#' @note Updated 2022-05-31.
#'
#' @details
#' Use `normalizePath()` instead for non-existing file paths.
#'
#' @param path `character`.
#' File paths, which must exist on disk.
#'
#' @seealso
#' Standard path modifiers:
#' - `normalizePath()`.
#' - `file.path()`.
#'
#' Checking for existence, access:
#' - `file.access()`.
#' - `file.exists()`.
#' - `goalie::hasAccess()`.
#' - `goalie::allHaveAccess()`.
#'
#' @return `character`.
#' Absolute (real) file path.
#'
#' @examples
#' realpath(".")
realpath <- function(path) {
    assert(isCharacter(path))
    out <- .normalizePath(path = path, mustWork = TRUE)
    names(out) <- names(path)
    out
}


## Updated 2022-05-31.
.normalizePath <-
    function(path, mustWork) {
        normalizePath(
            path = path,
            winslash = .Platform[["file.sep"]],
            mustWork = mustWork
        )
    }
