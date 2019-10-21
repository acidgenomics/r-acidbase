#' Capitalize
#'
#' Apply simple capitlization rules.
#'
#' For complex renaming, refer to syntactic package.
#'
#' @name capitalize
#' @note Updated 2019-10-21.
#'
#' @inheritParams params
#'
#' @return Modified object, with names capitalized.
#'
#' @seealso
#' - `toupper()`, `tolower()`.
#' - stringr package.
#' - `tools::toTitleCase()`. I generally avoid title case, since there's a poor
#'   general consensus on which works to keep lower case.
#'
#' @examples
#' x <- c("the quick Brown fox", "using AIC for model selection")
#' capitalize(x, strict = FALSE)
#' capitalize(x, strict = TRUE)
#' sentenceCase(x)
NULL



#' @describeIn capitalize Capitalize the first letter of all words.
#' @export
capitalize <- function(x, strict = FALSE) {
    vapply(
        X = strsplit(as.character(x), split = " "),
        FUN = function(x) {
            first <- toupper(substring(x, 1L, 1L))
            tail <- substring(x, 2L)
            if (isTRUE(strict)) {
                tail <- tolower(tail)
            }
            paste(first, tail, sep = "", collapse = " ")
        },
        FUN.VALUE = character(1L),
        USE.NAMES = FALSE
    )
}



#' @describeIn capitalize Only capitalize the first letter in the sentence.
#'   Note that this function attempts to preserve capitalization of acronyms.
#' @export
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
                    if (!isTRUE(grepl("^[.A-Z0-9]+$", x))) {
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