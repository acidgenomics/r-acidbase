#' Print string
#'
#' Capture [`print()`][base::print] output as a `character` string.
#'
#' Useful for returning informative messages inside a function.
#'
#' @export
#' @note Updated 2021-02-23.
#'
#' @param x An object used to select a [`print()`][base::print] method.
#'
#' @param ... Passthrough arguments to [`print()`][base::print].
#'
#' @param max `integer(1)`.
#' Maximum length of vector.
#' Works internally by calling `head()` on the print capture, prior to
#' collapse using `paste()`.
# "   Supports `getOption(x = "max.print")` global variable.
#'
#' @return `character(1)`.
#'
#' @seealso `cat()`.
#'
#' @examples
#' printString(c("hello", "world"))
#' printString(datasets::mtcars, max = 2L)
printString <-
    function(x, ...,
             max = getOption(x = "max.print", default = 100L)) {
        assert(
            requireNamespace("utils", quietly = TRUE),
            isInt(max)
        )
        x <- utils::capture.output(print(x, ...))
        x <- head(x, n = max)
        x <- paste(x, collapse = "\n")
        x <- gsub("^[\n]+|[\n]+$", "", x)
        x
    }
