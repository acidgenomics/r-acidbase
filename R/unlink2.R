#' Delete files and directories
#'
#' @export
#' @note Updated 2022-06-08.
#'
#' @details
#' This variant hardens file path handling, for better Windows compatibility.
#' Paths that do not exist on disk are silently ignored.
#'
#' @param x `character`.
#' Files or directories to be deleted.
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
    x <- x[file.exists(x)]
    if (!hasLength(x)) {
        return(invisible(0L))
    }
    x <- normalizePath(
        path = x,
        winslash = "\\",
        mustWork = FALSE
    )
    out <- unlink(x, recursive = TRUE)
    assert(!any(file.exists(x)))
    invisible(out)
}
