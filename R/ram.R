#' Return system random access memory (RAM) information
#'
#' @details
#' Requires the memuse package to be installed.
#'
#' @export
#' @note Updated 2023-05-10.
#'
#' @param type `character(1)`.
#' Type of RAM to return, either `"total"` or `"free"`.
#'
#' @param units `character(1)`.
#' Size format.
#'
#' @param digits `integer(1)`.
#' Number of significant digits to include.
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
ram <- function(
        type = c("total", "free"),
        units = "GB",
        digits = 0L
    ) {
    assert(
        requireNamespaces(c("memuse", "utils")),
        isString(units),
        isInt(digits)
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
        digits = digits
    )
    assert(isString(str))
    out <- strsplit(x = str, split = " ", fixed = TRUE)[[1L]][[1L]]
    out <- as.numeric(out)
    out
}
