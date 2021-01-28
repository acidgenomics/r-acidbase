#' Get the class contained in a specificed class definition
#'
#' Determine which class is contained (extended) in the requested class
#' definition.
#'
#' @export
#' @note Updated 2021-01-28.
#'
#' @param class `character(1)`.
#'   Class name.
#' @param package `character(1)`.
#'   Package name.
#'
#' @return `character(1)`.
#'   Name of extended class.
#'
#' @seealso
#' - [methods::getClass()].
#' - help("classRepresentation-class", "methods")
#'
#' @examples
#' x <- classContains(class = "data.frame", package = "methods")
#' print(x)
classContains <- function(class, package) {
    assert(
        isString(class),
        isString(package)
    )
    args <- list(
        "Class" = class,
        "package" = package,
        "inherits" = FALSE
    )
    x <- do.call(what = getClassDef, args = args)
    assert(is(x, "classRepresentation"))
    x <- attributes(x)
    x <- names(x[["contains"]])[[1L]]
    assert(isString(x))
    x
}
