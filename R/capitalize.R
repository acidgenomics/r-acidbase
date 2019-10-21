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
#' x <- c("the quick brown fox", "using AIC for model selection")
#' capitalize(x)
#' sentenceCase(x)
NULL



#' @describeIn capitalize Capitalize the first letter of all words.
#' @export
capitalize <- function(x) {
    vapply(
        X = as.character(x),
        FUN = function(x) {
            x <- strsplit(x, " ")[[1L]]
            paste(
                toupper(substring(x, 1L, 1L)),
                substring(x, 2L),
                sep = "",
                collapse = " "
            )
        },
        FUN.VALUE = character(1L),
        USE.NAMES = FALSE
    )
}



#' @describeIn capitalize Only capitalize the first letter in the sentence.
#' @export
sentenceCase <- function(x) {
    vapply(
        X = as.character(x),
        FUN = function(x) {
            if (is.na(x)) return(x)
            first <- substring(x, first = 1L, last = 1L)
            first <- toupper(first)
            tail <- tolower(substring(x, first = 2L))
            paste(first, tail, sep = "")
        },
        FUN.VALUE = character(1L),
        USE.NAMES = FALSE
    )
}