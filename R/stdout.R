#' Split stdout string into a character vector
#'
#' @export
#' @note Updated 2022-05-02.
#'
#' @inheritParams AcidRoxygen::params
#'
#' @return `character`.
#'
#' @seealso [shell()].
#'
#' @examples
#' x <- shell(
#'     command = "printf",
#'     args = c("%s\n", "aaa", "bbb"),
#'     print = FALSE
#' )
#' print(x)
#' y <- stdout(x)
#' print(y)
stdout <- function(x) {
    assert(
        is.list(x),
        isSubset("stdout", names(x))
    )
    out <- strsplit(x = x[["stdout"]], split = "\n", fixed = TRUE)[[1L]]
    out
}
