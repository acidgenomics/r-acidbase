#' Parse command line argument flags
#'
#' @export
#' @note Updated 2020-08-09.
#'
#' @param requiredArgs,optionalArgs `character` or `NULL`.
#'   Valid key-value pair argument names.
#'   For example, `aaa` for `--aaa=AAA` or `--aaa AAA`.
#'   Note that `--aaa AAA`-style arguments (note lack of `=`) are not currently
#'   supported.
#' @param flags `character` or `NULL`.
#'   Valid long flag names.
#'   For example, `aaa` for `--aaa`.
#'   Short flags, such as `-r`, are intentionally not supported.
#' @param positionalArgs `logical(1)`.
#'   Require positional arguments to be defined.
#'
#' @return `list`.
#'   Named list containing arguments, organized by type:
#'   - `requiredArgs`
#'   - `optionalArgs`
#'   - `flags`
#'   - `positionalArgs`
#'
#' @seealso
#' - argparse Python package.
#' - argparser R package.
#' - optparse R package.
#'
#' @examples
#' command <- system.file("scripts", "parse-args", package = "acidbase")
#' args <- c(
#'     ## Required args:
#'     "--aaa=AAA", "--bbb=BBB",
#'     ## Optional args:
#'     "--ccc=CCC", "--ddd=DDD",
#'     ## Flags:
#'     "--eee", "--fff",
#'     ## Positional args:
#'     "GGG", "HHH"
#' )
#' readLines(command)
#' out <- shell(command = command, args = args, stdout = TRUE)
#' print(out)
parseArgs <- function(
    requiredArgs = NULL,
    optionalArgs = NULL,
    flags = NULL,
    positionalArgs = FALSE
) {
    stopifnot(
        !.hasLength(intersect(requiredArgs, optionalArgs)),
        !.hasLength(intersect(requiredArgs, flags)),
        !.hasLength(intersect(optionalArgs, flags))
    )
    cmdArgs <- commandArgs(trailingOnly = TRUE)
    out <- list(
        requiredArgs = NULL,
        optionalArgs = NULL,
        flags = NULL,
        positionalArgs = NULL
    )
    if (!is.null(flags)) {
        optionalFlags <- flags
        flagPattern <- "^--([^=[:space:]]+)$"
        flags <- grep(pattern = flagPattern, x = cmdArgs, value = TRUE)
        flagNames <- gsub(pattern = flagPattern, replacement = "\\1", x = flags)
        match <- match(x = optionalFlags, table = flagNames)
        if (any(!is.na(match))) {
            hits <- flags[!is.na(match)]
            names(hits) <- flagNames[!is.na(match)]
            out[["flags"]] <- hits
            flags <- setdiff(flags, hits)
            flagNames <- setdiff(flagNames, names(hits))
            cmdArgs <- setdiff(cmdArgs, hits)
        }
        if (hasLength(flagNames)) {
            stop(sprintf(
                "Invalid flags: %s.",
                toString(flagNames, width = 200L)
            ))
        }
    }
    if (!is.null(requiredArgs) || !is.null(optionalArgs)) {
        argPattern <- "^--([^=[:space:]]+)=([^[:space:]]+)$"
        args <- grep(pattern = argPattern, x = cmdArgs, value = TRUE)
        argNames <- gsub(pattern = argPattern, replacement = "\\1", x = args)
        if (!is.null(requiredArgs)) {
            match <- match(x = requiredArgs, table = argNames)
            if (any(is.na(match))) {
                fail <- requiredArgs[is.na(match)]
                stop(sprintf(
                    "Failed to match required arg: %s.",
                    toString(fail)
                ))
            }
            hits <- args[match]
            names(hits) <- argNames[match]
            out[["requiredArgs"]] <- hits
            args <- setdiff(args, hits)
            argNames <- setdiff(argNames, names(hits))
            cmdArgs <- setdiff(cmdArgs, hits)
        }
        if (!is.null(optionalArgs)) {
            match <- match(x = optionalArgs, table = argNames)
            if (any(!is.na(match))) {
                hits <- args[!is.na(match)]
                names(hits) <- argNames[!is.na(match)]
                out[["optionalArgs"]] <- hits
                args <- setdiff(args, hits)
                argNames <- setdiff(argNames, names(hits))
                cmdArgs <- setdiff(cmdArgs, hits)
            }
        }
        stopifnot(!.hasLength(args), !.hasLength(argNames))
    }
    if (isTRUE(positionalArgs)) {
        if(
            !.hasLength(cmdArgs) ||
            any(grepl(pattern = "^--", x = cmdArgs))
        ) {
            stop("Positional arguments are required but missing.")
        }
        out[["positionalArgs"]] <- cmdArgs
    } else {
        if (.hasLength(cmdArgs)) {
            stop(sprintf(
                "Positional arguments are defined but not allowed: %s.",
                toString(cmdArgs, width = 200L)
            ))
        }
    }
    out
}
