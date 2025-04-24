#' Extract duplicated values
#'
#' @export
#' @note Updated 2025-04-12.
#'
#' @param x `vector`.
#'
#' @return Modified object.
#' Only duplicated values are returned, made unique.
#' Returns empty vector of length 0 when no duplicates are detected.
#'
#' @seealso
#' - `goalie::isDuplicate()`.
#' - `duplicated()`.
#'
#' @examples
#' ## character ====
#' vec <- c("ccc", "aaa", "bbb", "ccc", "bbb")
#' x <- dupes(vec)
#' print(x)
#' x <- notDupes(vec)
#' print(x)
dupes <- function(x) {
    if (is.null(x)) {
        return(NULL)
    }
    assert(is.atomic(x))
    if (hasNoDuplicates(x)) {
        return(x[0L]) # nolint
    }
    idx <- isDuplicate(x)
    vals <- x[idx]
    out <- unique(vals)
    out
}


#' @export
#' @rdname dupes
notDupes <- function(x) {
    if (is.null(x)) {
        return(NULL)
    }
    assert(is.atomic(x))
    if (hasNoDuplicates(x)) {
        return(x)
    }
    idx <- !isDuplicate(x)
    vals <- x[idx]
    out <- unique(vals)
    out
}
