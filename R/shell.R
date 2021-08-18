#' Invoke a command in the system command-line shell
#'
#' @export
#' @note Updated 2021-08-18.
#'
#' @param command `character(1)`.
#'   Name of program to run.
#' @param args `character`.
#'   Arguments passed to `command`.
#' @param print `logical(1)`.
#'   Whether to print (echo) the commands to the console.
#'
#' @seealso
#' - `processx::run()`.
#' - `base::system2()`, our previously used legacy approach.
#'
#' @return Invisible `list`.
#'   Contains named elements:
#'   `"status"`, `"stdout"`, `"stderr"`, `"timeout"`.
#'
#' @examples
#' x <- shell(
#'     command = "echo",
#'     args = c("hello", "world"),
#'     print = TRUE
#' )
#' print(x)
shell <- function(
    command,
    args = character(),
    print = interactive()
) {
    assert(
        isString(command),
        isSystemCommand(command),
        is.character(args),
        isFlag(print)
    )
    ## Ensure arguments are passed in unquoted, if necessary.
    args <- gsub(pattern = "^['\"](.+)['\"]$", replacement = "\\1", x = args)
    x <- run(
        command = command,
        args = args,
        error_on_status = FALSE,
        wd = getwd(),
        echo_cmd = print,
        echo = print,
        spinner = print,
        timeout = Inf,
        stdout = "|",
        stderr = "|"
    )
    assert(
        is.list(x),
        isSubset(c("status", "stdout", "stderr", "timeout"), names(x))
    )
    if (!identical(x[["status"]], 0L)) {
        msg <- c(
            "Shell command failure.",
            paste(
                "$", command,
                paste(args, collapse = " "),
                sep = " "
            )
        )
        stderr <- x[["stderr"]]
        if (isString(stderr)) {
            msg <- append(x = msg, values = stderr)
        }
        abort(msg)
    }
    invisible(x)
}
