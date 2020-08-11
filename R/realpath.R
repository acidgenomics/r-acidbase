#' Express file paths in canonical form
#'
#' @export
#' @note Updated 2020-08-11.
#' @note Use `normalizePath()` instead for non-existing file paths.
#'
#' @param path `character`.
#'   File paths, which must exist on disk.
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
#' @examples
#' realpath(".")
realpath <- function(path) {
    path <- normalizePath(
        path = path,
        winslash = .Platform$file.sep,  # nolint
        mustWork = TRUE
    )
    ## nocov start
    hasAccess <- file.access(names = path, mode = 0L) == 0L
    if (!all(hasAccess)) {
        fail <- path[which(!hasAccess)]
        stop(sprintf(
            "Access failure: %s.",
            toString(fail, width = 200L)
        ))
    }
    ## nocov end
    path
}
