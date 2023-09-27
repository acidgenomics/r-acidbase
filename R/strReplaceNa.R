#' Replace `NA` with `"NA"`
#'
#' @export
#' @note Updated 2023-09-21.
#'
#' @param x `character`.
#'
#' @return `character`
#' Character vector with `NA` values converted to `"NA"`.
#'
#' @seealso
#' - [stringi::stri_replace_na].
#' - [stringr::str_replace_na].
#'
#' @examples
#' strReplaceNa(c("a", "b", NA))
strReplaceNa <- function(x) {
    assert(is.character(x))
    x[is.na(x)] <- "NA"
    x
}
