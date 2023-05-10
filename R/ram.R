#' Return system random access memory (RAM) information
#'
#' @export
#' @note Updated 2023-05-10.
#'
#' @return `numeric(1)`.
#'
#' @seealso
#' - memuse package.
#' - https://stackoverflow.com/questions/29787452/
#' - `help("object.size")`
#'
#' @examples
#' ram(type = "total", units = "GB")
#' ram(type = "free", units = "GB")
ram <- function(type = c("total", "free"), units = "GB") {
    assert(
        requireNamespaces(c("memuse", "utils")),
        isString(units)
    )
    type <- match.arg(type)
    key <- switch(
        EXPR = type,
        "total" = "totalram",
        "free" = "freeram"
    )
    sysinfo <- memuse::Sys.meminfo()
    assert(is(sysinfo, "sysinfo"))
    memuse <- sysinfo[[key]]
    assert(is(memuse, "memuse"))
    bytes <- memuse::mu.size(memuse, as.is = FALSE)
    assert(is.numeric(bytes))
    bytes <- structure(bytes, class = "object_size")
    str <- format(
        x = bytes,
        units = units,
        standard = "auto",
        digits = 0L
    )
    assert(isString(str))
    out <- strsplit(x = str, split = " ", fixed = TRUE)[[1L]][[1L]]
    out <- as.numeric(out)
    out
}
