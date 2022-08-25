#' Require package namespaces
#'
#' @details
#' This function intentionally does not attach packages, unlike `library`,
#' `require`, or `attachNamespace` functions.
#'
#' Intended for use inside package functions that relying upon optional
#' dependencies defined via `Suggests` instead of `Imports` or `Depends` in
#' `DESCRIPTION` file.
#'
#' Unlike `requireNamespace`, this variant always errors on namespace failure.
#'
#' @note Updated 2022-08-25.
#' @export
#'
#' @param packages `character`.
#' Package names to load.
#'
#' @seealso
#' - `requireNamespace`
#' - `attachNamespace`
#' - `loadNamespace`
#'
#' @examples
#' requireNamespaces(c("base", "utils"))
requireNamespaces <- function(packages) {
    ok <- vapply(
        X = packages,
        FUN = requireNamespace,
        FUN.VALUE = logical(1L),
        USE.NAMES = TRUE,
        quietly = TRUE
    )
    if (!isTRUE(all(ok))) {
        fail <- names(ok)[!ok]
        .abort(sprintf(
            fmt = "%s not installed: %s.",
            ngettext(
                n = length(fail),
                msg1 = "Package",
                msg2 = "Packages"
            ),
            .toInlineString(x = fail, class = "pkg")
        ))
    }
    ## Returning boolean flag here, for use inside `assert()` / `assert()`.
    invisible(TRUE)
}
