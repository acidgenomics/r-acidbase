#' Create a local cache directory for a package
#'
#' @export
#' @note Updated 2023-09-28.
#'
#' @details
#' Requires the tools package to be installed.
#'
#' @param pkg `character(1)`.
#' Package name.
#'
#' @return `character(1)`.
#' Directory path.
#'
#' @seealso
#' - `tools::R_user_dir()`.
#' - `rappdirs::user_cache_dir()`.
#' - `Sys.getenv("R_USER_CACHE_DIR")`.
#' - `Sys.getenv("XDG_CACHE_HOME")`.
#' - BiocFileCache package.
#'
#' @examples
#' dir <- pkgCacheDir(pkg = "AcidBase")
#' print(dir)
pkgCacheDir <- function(pkg) {
    assert(
        requireNamespaces("tools"),
        isString(pkg)
    )
    dir <- tools::R_user_dir(package = pkg, which = "cache")
    dir <- initDir(dir)
    dir
}
