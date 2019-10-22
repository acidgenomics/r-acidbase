#' Express file paths in canonical form
#'
#' @export
#' @inherit base::normalizePath
#' @note Updated 2019-10-22.
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
#' normalizePath(".")
realpath <- function(path) {
    hasAccess <- file.access(names = path, mode = 0L) == 0L
    if (!all(hasAccess)) {
        fail <- deparse(basename(path[which(!hasAccess)]))
        stop("Access failure: ", toString(fail, width = 200L))
    }
    normalizePath(
        path = path,
        winslash = .Platform$file.sep,  # nolint
        mustWork = TRUE
    )
}
