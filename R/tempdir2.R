#' Unique temporary directory
#'
#' @export
#' @note Updated 2022-06-02.
#'
#' @return `character(1L)`.
#' Temporary directory path.
#'
#' @examples
#' x <- tempdir2()
#' print(x)
tempdir2 <- function() {
    user <- Sys.info()[["user"]]
    timestamp <- as.numeric(Sys.time())
    rand <- paste0(letters[sample(x = 26L, size = 10L)], collapse = "")
    bn <- paste(user, timestamp, rand, sep = "-")
    path <- file.path(tempdir(), bn)
    assert(!dir.exists(path))
    out <- initDir(path)
    out
}
