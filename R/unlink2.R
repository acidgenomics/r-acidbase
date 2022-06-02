#' Delete files and directories
#'
#' @export
#' @note Updated 2022-06-01.
#'
#' @details
#' This variant hardens file path handling, for better Windows compatibility.
#'
#' @param x `character`.
#' Files or directories to be deleted.
#' Unlink base `unlink`, these must exist on disk or the function will
#' intentionally error.
#'
#' @return `integer(1)`.
#' `0` for success, `1` for failure, invisibly.
#'
#' @examples
#' tempdir <- tempdir2()
#' x <- file.path(tempdir, "file.txt")
#' y <- file.path(tempdir, "directory")
#' invisible(file.create(x))
#' invisible(dir.create(y))
#' out <- unlink2(c(x, y))
#' print(out)
unlink2 <- function(x) {
    unlink(
        x = normalizePath(
            path = x,
            winslash = "\\",
            mustWork = TRUE
        ),
        recursive = TRUE
    )
}
