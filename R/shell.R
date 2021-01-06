#' Invoke a command in the system command-line shell
#'
#' @export
#' @note Updated 2021-01-06.
#'
#' @param command `character(1)`.
#' @param args `character`.
#' @param stdout,stderr `character(1)`, `logical(1)`, or `NULL`.
#'   Where output to `stdout` or `stderr` should be sent.
#'
#'   Possible values:
#'   - `""`: Output to the R console.
#'   - `FALSE` or `NULL`: Discard the output.
#'   - `TRUE`: Capture the output in a character vector.
#'   - `character(1)`: Capture the output in a defined file name.
#' @param ... Passthrough arguments to [`system2()`][base::system2].
#'
#' @seealso
#' - `system2`.
#'
#' @return
#' If `stdout = TRUE` or `stderr = TRUE`, a character vector giving the output
#' of the command, one line per character string. If the command could not be
#' run, an R error is generated. If command runs but gives a non-zero exit
#' status this will be reported with a warning and in the attribute "status" of
#' the result.
#'
#' In other cases, the return value is an invisible error code
#' (`0` for success). If the command could not be run for any reason, the value
#' is `127` and a warning is issued. If the command times out, a warning is
#' issued and the exit status is `124`.
#'
#' @examples
#' shell(command = "echo", args = c("hello", "world"))
shell <- function(
    command,
    args = "",
    stdout = "",
    stderr = "",
    ...
) {
    if (isTRUE(stderr)) stdout <- TRUE  # nocov
    tryCatch(
        expr = {
            out <- system2(
                command = command,
                args = args,
                stdout = stdout,
                stderr = stderr,
                ...
            )
        },
        warning = function(w) {
            stop(w)
        }
    )
    if (all(!isTRUE(stdout), !isTRUE(stderr))) {
        stopifnot(out == 0L)
    }
    invisible(out)
}
