#' Missing or NULL class union
#'
#' @export
#' @note Updated 2021-02-04.
#'
#' @return `missingOrNULL`.
#'
#' @examples
#' showClass("missingOrNULL")
setClassUnion(name = "missingOrNULL", members = c("missing", "NULL"))
