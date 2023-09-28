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
#' - [tools::R_user_dir()].
#' - BiocFileCache package.
#'
#' @examples
#' dir <- cacheDir(pkg = "AcidBase")
#' print(dir)
cacheDir <- function(pkg) {
    assert(requireNamespaces("tools"))
    dir <- tools::R_user_dir(package = pkg, which = "cache")
    dir <- initDir(dir)
    dir
}
