#' Extract dots from function
#'
#' @export
#' @note This function uses non-standard evaluation.
#' @note Updated 2020-01-28.
#'
#' @param ... Objects as dots.
#'
#' @param character `logical(1)`.
#' Return dots (`...`) as `character`.
#'
#' @return
#' - `character = FALSE`: `list`. Objects as `name` class. Return with `eval`.
#' - `character = TRUE`: `character`. Names of the dots.
#'
#' @seealso
#' `help("dotsMethods", "methods")`.
#'
#' - [rlang](https://rlang.r-lib.org/).
#' - [tidyverse](https://www.tidyverse.org/).
#'
#' @examples
#' dots(a, b, c, character = FALSE)
#' dots(a, b, c, character = TRUE)
dots <- function(..., character = FALSE) {
    ## Alternatively, can use `rlang::eval_bare()` here.
    dots <- eval(substitute(alist(...)))
    assert(
        is.list(dots),
        hasLength(dots),
        hasNoDuplicates(dots)
    )
    ## Provide an informative error message when a user attempts to accidentally
    ## use standard evaluation with quotation.
    if (!all(bapply(dots, is.symbol))) {
        abort(paste(
            "This function uses non-standard evaluation (NSE).",
            "Dot arguments must be unquoted."
        ))
    }
    ## Convert names (symbols) to character.
    names <- vapply(dots, as.character, character(1L))
    assert(hasNoDuplicates(names))
    if (isTRUE(character)) {
        names
    } else {
        dots
    }
}
