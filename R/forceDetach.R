## nocov start



#' Force detach packages
#'
#' Force detach unwanted packages loaded into the current environment.
#'
#' @details
#' Bioconductor ensembldb will attach unwanted packages into the NAMESPACE,
#' which can conflict with tidyverse packages (e.g. dplyr).
#'
#' @export
#' @note Updated 2022-05-20.
#'
#' @param keep `character`.
#' Package names to keep attached in environment.
#'
#' @return Invisible `logical(1)`.
#'
#' @examples
#' ## > forceDetach()
forceDetach <- function(keep = .packages()) {
    for (pkg in setdiff(x = .packages(), y = keep)) {
        suppressWarnings({
            detach(
                name = paste0("package:", pkg),
                unload = TRUE,
                force = TRUE,
                character.only = TRUE
            )
        })
    }
    assert(identical(x = .packages(), y = keep))
    invisible(TRUE)
}



## nocov end
