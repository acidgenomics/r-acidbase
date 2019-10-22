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