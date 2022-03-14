#' Express file paths in canonical form
#'
#' @export
#' @note Updated 2020-08-19.
#' @note Use `normalizePath()` instead for non-existing file paths.
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
#' @examples
#' realpath(".")
realpath <- function(path) {
    assert(isCharacter(path))
    out <- normalizePath(
        path = path,
        winslash = .Platform$file.sep, # nolint
        mustWork = TRUE
    )
    names(out) <- names(path)
    out
}
