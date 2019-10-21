#' Type description
#'
#' @export
#' @note Updated 2019-10-21.
#'
#' @inheritParams params
#'
#' @examples
#' typeDescription(NULL)
#' typeDescription(TRUE)
#' typeDescription(character())
#' typeDescription(data.frame())
typeDescription <- function(x) {
    if (is.array(x)) {
        sprintf(
            fmt = "class '%s %s'",
            class(x[FALSE]),  # nolint
            toString(class(x))
        )
    } else if (is.function(x)) {
        sprintf(
            fmt = "class '%s %s'",
            typeof(x), toString(class(x))
        )
    } else if (isS4(x)) {
        sprintf("S4 class '%s'", toString(class(x)))
    } else {
        sprintf("class '%s'", toString(class(x)))
    }
}
