#' Base name without the file extension
#'
#' @export
#' @note This function intentionally doesn't check whether a file exists.
#' @note Updated 2019-10-22.
#'
#' @param path `character`.
#' File path(s).
#' This function is vectorized and supports multiple files.
#'
#' @return `character`.
#' Character vector of same length as `path` input, with file extension removed.
#' Returns `NA` if no extension is detected.
#'
#' @seealso
#' - [`basename()`][base::basename].
#' - `tools::file_path_sans_ext()`.
#'
#' @examples
#' path <- c("dir/foo.txt", "bar.tar.gz", "DESCRIPTION")
#' basenameSansExt(path)
basenameSansExt <- function(path) {
    vapply(
        X = basename(path = path),
        FUN = function(x) {
            if (isTRUE(
                grepl(pattern = extPattern, x = x, ignore.case = TRUE)
            )) {
                x <- sub(pattern = extPattern, replacement = "", x = x)
            }
            x
        },
        FUN.VALUE = character(1L),
        USE.NAMES = FALSE
    )
}
