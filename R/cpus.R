#' Detect the number of CPU cores
#'
#' @export
#' @note Updated 2023-05-11.
#'
#' @seealso
#' - parallel::detectCores
#' - ps::ps_cpu_count
#'
#' @examples
#' cpus()
cpus <- function() {
    ## Alternative approach:
    ## > ps::ps_cpu_count(logical = TRUE)
    assert(requireNamespaces("parallel"))
    n <- parallel::detectCores(all.tests = FALSE, logical = TRUE)
    assert(is.integer(n))
    n
}
