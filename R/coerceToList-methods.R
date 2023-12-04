#' @name coerceToList
#' @inherit AcidGenerics::coerceToList
#' @note Updated 2021-10-14.
#'
#' @details
#' Don't attempt to defined methods for `as.list()`.
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
#' @examples
#' data(DFrame, package = "AcidTest")
#'
#' ## Annotated ====
#' object <- DFrame
#' is(object, "Annotated")
#' object <- coerceToList(object)
#' class(object)
#' names(object)
NULL



## Updated 2019-10-22.
`coerceToList,Annotated` <- # nolint
    function(object) {
        out <- lapply(slotNames(object), function(slot) {
            if (.hasSlot(object, slot)) {
                slot(object, slot)
            } else {
                NULL
            }
        })
        names(out) <- slotNames(object)
        out
    }



#' @rdname coerceToList
#' @export
setMethod(
    f = "coerceToList",
    signature = signature(object = "Annotated"),
    definition = `coerceToList,Annotated`
)
