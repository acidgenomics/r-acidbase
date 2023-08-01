#' Unique temporary directory
#'
#' @export
#' @note Updated 2023-08-01.
#'
#' @return `character(1L)`.
#' Temporary directory path.
#'
#' @seealso
#' - `randomString()`.
#'
#' @examples
#' x <- tempdir2()
#' print(x)
tempdir2 <- function() {
    rand <- randomString(n = 10L)
    timestamp <- as.numeric(Sys.time())
    bn <- paste(rand, timestamp, sep = "-")
    dir <- file.path(tempdir(), bn)
    assert(
        isFALSE(dir.exists(dir)),
        msg = sprintf(
            "Temporary directory already exists at {.dir %s}.",
            dir
        )
    )
    out <- initDir(dir)
    out
}
