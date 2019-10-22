#' Sentence case
#'
#' @export
#' @note Updated 2019-10-21.
#'
#' @inheritParams params
#'
#' @examples
#' x <- c("the quick Brown fox", "using AIC for model selection")
#' sentenceCase(x)
sentenceCase <- function(x) {
    vapply(
        X = as.character(x),
        FUN = function(x) {
            x <- strsplit(x, split = " ")[[1L]]
            ## Only capitalize the first letter of the first word.
            firstWord <- paste0(
                toupper(substring(x[[1L]], first = 1L, last = 1L)),
                substring(x[[1L]], first = 2L)
            )
            ## Loop across the other words and look for acronyms. Convert to
            ## lower case otherwise.
            otherWords <- vapply(
                X = tail(x, n = -1L),
                FUN = function(x) {
                    if (
                        !isTRUE(grepl("^[.A-Z0-9]+$", x)) &&
                        !isTRUE(grepl("[.a-z0-9][A-Z]", x)) &&
                        !isTRUE(grepl("[A-Z]{2}", x))
                    ) {
                        x <- tolower(x)
                    }
                    x
                },
                FUN.VALUE = character(1L),
                USE.NAMES = FALSE
            )
            paste(c(firstWord, otherWords), sep = "", collapse = " ")
        },
        FUN.VALUE = character(1L),
        USE.NAMES = FALSE
    )
}