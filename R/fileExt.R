#' File extension
#'
#' @export
#' @note This function intentionally doesn't check whether a file exists.
#' @note Updated 2022-05-02.
#'
#' @param path `character`.
#' File path(s).
#' This function is vectorized and supports multiple files.
#'
#' @param pattern `character(1)`.
#' File extension pattern.
#'
#' @return `character`.
#' Character vector of same length as `path` input, with file extension removed.
#' Returns `NA` if no extension is detected.
#'
#' @seealso
#' `tools::file_ext()`. Note that this returns `character()` instead of `NA`
#' on extension match failure.
#'
#' @examples
#' fileExt(c("dir/foo.txt", "dir/bar.tar.gz", "dir/"))
fileExt <-
    function(path, pattern = goalie::extPattern) {
        assert(
            isCharacter(path),
            isString(pattern)
        )
        ## Note that `regexpr()` returns `-1L` on match failure.
        pos <- regexpr(
            pattern = pattern,
            text = path,
            ignore.case = TRUE
        )
        ifelse(
            test = pos > -1L,
            yes = substring(text = path, first = pos + 1L),
            no = NA_character_
        )
    }
