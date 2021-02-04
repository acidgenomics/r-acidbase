#' Coerce to list
#'
#' @name coerceToList
#' @note Don't attempt to defined methods for `as.list`.
#' @note Updated 2021-02-04.
#'
#' @inheritParams AcidRoxygen::params
#' @param ... Additional arguments.
#'
#' @seealso
#' Refer to the S4Vectors package for details.
#' - `help(topic = "Annotated-class", package = "S4Vectors")`
#' - `help(topic = "List-class", package = "S4Vectors")`
#' - `showClass("Annnotated")`.
#' - `showClass("List")`.
#' - `methods::coerce`.
#'
#' @return `list`.
#'
#' @examples
#' data(DFrame, package = "AcidTest")
#'
#' ## Annotated (DataFrame) ====
#' object <- DFrame
#' is(object, "Annotated")
#' object <- coerceToList(object)
#' class(object)
#' names(object)
NULL



## Updated 2019-10-22.
`coerceToList,Annotated` <-  # nolint
    function(object) {
        out <- lapply(slotNames(object), function(slot) {
            if (.hasSlot(object, slot)) {
                slot(object, slot)
            } else {
                NULL  # nocov
            }
        })
        names(out) <- slotNames(object)
        out
    }



#' @rdname coerceToList
#' @export
setMethod(
    f = "coerceToList",
    signature = signature("Annotated"),
    definition = `coerceToList,Annotated`
)
