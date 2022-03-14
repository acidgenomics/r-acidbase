#' Simple class of object
#'
#' @details
#' Doesn't return `structure` information, including the parent package that
#' defines the class, which is common for S4 classes.
#'
#' Primarily intended for unit testing in other packages.
#'
#' @export
#' @note Updated 2021-08-04.
#'
#' @inheritParams AcidRoxygen::params
#'
#' @return `character(1)`.
#' Primary class of object, as a simple string.
#'
#' @examples
#' df <- data.frame()
#' simpleClass(df)
simpleClass <- function(x) {
    as.character(class(x))[[1L]]
}
