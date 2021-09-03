#' Parent directory recursion
#'
#' @export
#' @note Updated 2021-09-03.
#'
#' @details
#' Function always resolves directory path internally, using `realpath`.
#'
#' @param path `character`.
#'   Local file and/or directory paths.
#'   Also supports URLs.
#' @param n `logical(1)`.
#'   Number of levels to recursive.
#'   Defaults to the immediate parent, similar to `dirname`.
#'
#' @return `character`.
#'
#' @examples
#' dir <- getwd()
#' url <- pasteURL(
#'     "r.acidgenomics.com",
#'     "packages",
#'     "acidbase",
#'     "reference",
#'     "parentDirectory.html",
#'     protocol = "https"
#' )
#' path <- c(dir, url)
#' parentDir(path = path)
parentDirectory <- function(
    path,
    n = 1L
) {
    assert(
        isCharacter(path),
        isInt(n),
        isPositive(n),
        isTRUE(is.finite(n))
    )
    names <- names(path)
    fileParent <- function(path, n) {
        x <- realpath(path)
        x <- dirname(x)
        n <- n - 1L
        if (isPositive(n)) {
            x <- vapply(
                X = x,
                n = n,
                FUN = function(x, n) {
                    do.call(
                        what = file.path,
                        args = as.list(
                            append(
                                x = x,
                                values = rep("..", times = n)
                            )
                        )
                    )
                },
                FUN.VALUE = character(1L),
                USE.NAMES = FALSE
            )
            x <- realpath(x)
        }
        x
    }
    urlParent <- function(path, n) {
        x <- path
        assert(isTRUE(grepl(pattern = "://", x = x, fixed = TRUE)))
        x <- strsplit(x = x, split = "/", fixed = TRUE)[[1L]]
        protocol <- sub(pattern = ":$", replacement = "", x = x[[1L]])
        x <- x[3L:length(x)]
        assert(
            n <= length(x),
            msg = sprintf(
                "Invalid parent (%s = %d) for '%s'.",
                "n", n, path
            )
        )
        x <- x[1L:(length(x) - n)]
        do.call(
            what = pasteURL,
            args = append(
                x = x,
                values = list("protocol" = protocol)
            )
        )
    }
    x <- vapply(
        X = path,
        n = n,
        FUN = function(path, n) {
            ifelse(
                test = isAURL(path),
                yes = urlParent(path = path, n = n),
                no = fileParent(path = path, n = n)
            )
        },
        FUN.VALUE = character(1L),
        USE.NAMES = FALSE
    )
    names(x) <- names
    x
}



#' @rdname parentDirectory
#' @export
parentDir <- parentDirectory
