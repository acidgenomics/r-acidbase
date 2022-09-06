#' Invoke a command in the system command-line shell
#'
#' @export
#' @note Updated 2022-09-06.
#'
#' @param command `character(1)`.
#' Name of program to run.
#'
#' @param args `character`.
#' Arguments passed to `command`.
#'
#' @param env `character` or `NULL`.
#' Environment variables of the child process. If `NULL`, the parent environment
#' is inherited. To append new environment variables to the ones set in the
#' current process, specify `"current"` in env, without a name, and the appended
#' ones with names. The appended ones can overwrite the current ones.
#'
#' @param wd `character(1)`.
#' Working directory path inside process.
#'
#' @param print `logical(1)`.
#' Whether to print (echo) the commands to the console.
#'
#' @param stdoutFile,stderrFile `character(1)` or `NULL`.
#' File path to log stdout and/or stderr.
#' Disabled when set `NULL`.
#'
#' @param stderrToStdout `logical(1)`.
#' Whether to redirect standard error (stderr) to standard output (stdout).
#' Similar to `2>&1` in POSIX or `&>` in Bash.
#'
#' @param returnStdout `logical(1)`.
#' Whether to return stdout as a character vector, split by `"\n"`.
#'
#' @seealso
#' - `processx::run()`.
#' - `base::system2()`, our previously used legacy approach.
#'
#' @return Invisible `list`.
#' Contains named elements:
#' `"status"`, `"stdout"`, `"stderr"`, `"timeout"`.
#'
#' @examples
#' x <- shell(
#'     command = "printf",
#'     args = c("%s\n", "hello", "world"),
#'     print = TRUE
#' )
#' print(x)
shell <-
    function(command,
             args = character(),
             env = NULL,
             wd = getwd(),
             print = interactive(),
             stderrFile = NULL,
             stdoutFile = NULL,
             stderrToStdout = FALSE,
             returnStdout = FALSE) {
        assert(
            requireNamespace("processx", quietly = TRUE),
            isString(command),
            isSystemCommand(command),
            is.character(args),
            isCharacter(env, nullOK = TRUE),
            isADir(wd),
            isFlag(print),
            isString(stdoutFile, nullOK = TRUE),
            isString(stderrFile, nullOK = TRUE),
            isFlag(stderrToStdout),
            isFlag(returnStdout)
        )
        ## Ensure arguments are passed in unquoted, if necessary.
        args <- gsub(
            pattern = "^['\"](.+)['\"]$",
            replacement = "\\1",
            x = args
        )
        x <- processx::run(
            command = command,
            args = args,
            error_on_status = FALSE,
            wd = wd,
            echo_cmd = print,
            echo = print,
            spinner = print,
            timeout = Inf,
            stdout = ifelse(
                test = isString(stdoutFile),
                yes = .normalizePath(path = stdoutFile, mustWork = FALSE),
                no = "|"
            ),
            stderr = ifelse(
                test = isString(stderrFile),
                yes = .normalizePath(path = stderrFile, mustWork = FALSE),
                no = "|"
            ),
            stderr_to_stdout = stderrToStdout,
            env = env
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
            .abort(msg)
        }
        if (isTRUE(returnStdout)) {
            x <- strsplit(
                x = x[["stdout"]],
                split = "\n",
                fixed = TRUE
            )[[1L]]
        }
        invisible(x)
    }
