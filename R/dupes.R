#' Extract duplicated values
#'
#' @export
#' @note Updated 2023-09-26.
#'
#' @param x `vector`.
#'
#' @return Modified object.
#' Only duplicated values are returned, sorted and made unique.
#' Returns empty vector of length 0 when no duplicates are detected.
#'
#' @examples
#' ## character ====
#' x <- c("ccc", "aaa", "bbb", "ccc", "bbb")
#' x <- dupes(x)
#' print(x)
dupes <- function(x) {
    if (hasNoDuplicates(x)) {
        return(x[0L])
    }
    idx <- isDuplicate(x)
    vals <- x[idx]
    out <- sort(unique(vals))
    out
}
