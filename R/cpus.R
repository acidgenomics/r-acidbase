#' Detect the number of CPU cores
#'
#' @export
#' @note Updated 2023-05-16.
#'
#' @seealso
#' - parallel::detectCores
#' - ps::ps_cpu_count
#'
#' @examples
#' cpus()
cpus <- function() {
    assert(requireNamespaces("parallel"))
    n <- parallel::detectCores(all.tests = FALSE, logical = TRUE)
    assert(is.integer(n))
    n
}
