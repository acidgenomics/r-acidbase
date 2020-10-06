#' Force detach packages
#'
#' Force detach unwanted packages loaded into the current environment.
#'
#' @details
#' Bioconductor ensembldb will attach unwanted packages into the NAMESPACE,
#' which can conflict with tidyverse packages (e.g. dplyr).
#'
#' @export
#' @note Updated 2020-10-06.
#'
#' @param keep `character`.
#'   Package names to keep attached in environment.
#'
#' @examples
#' ## > forceDetach()
forceDetach <- function(keep = .packages()) {
    detach <- setdiff(.packages(), keep)
    if (length(detach) > 0L) {
        invisible(lapply(
            X = detach,
            FUN = function(name) {
                if (name %in% .packages()) {
                    suppressWarnings({
                        detach(
                            name = paste0("package:", name),
                            unload = TRUE,
                            force = TRUE,
                            character.only = TRUE
                        )
                    })
                }
            }
        ))
    }
    stopifnot(identical(.packages(), keep))
}
