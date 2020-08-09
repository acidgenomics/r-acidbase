## FIXME This needs to support `--days 2`.
## FIXME This needs to error if the user passes in extra stuff.
## FIXME Need to add Rscript unit tests for this.
## FIXME Improve working example to include functional script.
## FIXME NEED TO DEFINE REQUIREDFLAGS, REQUIREDARGS



#' Parse command line argument flags
#'
#' @export
#' @note Updated 2020-08-09.
#' @note Short flags, such as `-r`, are intentionally not supported.
#'
#' @param requiredFlags,optionalFlags `character` or `NULL`.
#'   Valid long flag names.
#'   For example, `aaa` for `--aaa`.
#' @param requiredArgs,optionalArgs `character` or `NULL`.
#'   Valid key-value pair argument names.
#'   For example, `aaa` for `--aaa=AAA` or `--aaa AAA`.
#'   Note that `--aaa AAA`-style arguments are not currently supported.
#' @param positional `logical(1)`.
#'   Error if required positional arguments (>= 1) are missing.
#'
#' @return `list`.
#'   Named list containing arguments, organized by type:
#'   - `requiredFlags`
#'   - `optionalFlags`
#'   - `requiredArgs`
#'   - `optionalArgs`
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
#'     ## Required flags:
#'     "--aaa", "--bbb",
#'     ## Optional flags:
#'     "--ccc", "--ddd",
#'     ## Required args:
#'     "--eee=EEE", "--fff=FFF",
#'     ## Optional args:
#'     "--ggg=GGG", "--hhh=HHH",
#'     ## Positional args:
#'     "III", "JJJ"
#' )
#' readLines(command)
#' out <- shell(command = command, args = args, stdout = TRUE)
#' print(out)
parseArgs <- function(
    requiredFlags = NULL,
    optionalFlags = NULL,
    requiredArgs = NULL,
    optionalArgs = NULL,
    positionalArgs = FALSE
) {
    stopifnot(
        !.hasLength(intersect(requiredFlags, optionalFlags)),
        !.hasLength(intersect(requiredFlags, requiredArgs)),
        !.hasLength(intersect(requiredFlags, optionalArgs)),
        !.hasLength(intersect(optionalFlags, requiredArgs)),
        !.hasLength(intersect(optionalFlags, optionalArgs)),
        !.hasLength(intersect(requiredArgs, optionalArgs))
    )
    cmdArgs <- commandArgs(trailingOnly = TRUE)
    out <- list(
        requiredFlags = NULL,
        optionalFlags = NULL,
        requiredArgs = NULL,
        optionalArgs = NULL,
        positionalArgs = NULL
    )
    if (!is.null(requiredFlags) || !is.null(optionalFlags)) {
        flagPattern <- "^--([^=[:space:]]+)$"
        flags <- grep(pattern = flagPattern, x = cmdArgs, value = TRUE)
        flagNames <- gsub(pattern = flagPattern, replacement = "\\1", x = flags)
        if (!is.null(requiredFlags)) {
            match <- match(x = requiredFlags, table = flagNames)
            if (any(is.na(match))) {
                fail <- requiredFlags[is.na(match)]
                stop(sprintf(
                    "Failed to match required flag: %s.",
                    toString(fail)
                ))
            }
            hits <- flags[match]
            names(hits) <- flagNames[match]
            out[["requiredFlags"]] <- hits
            flags <- setdiff(flags, hits)
            flagNames <- setdiff(flagNames, names(hits))
            cmdArgs <- setdiff(cmdArgs, hits)
        }
        if (!is.null(optionalFlags)) {
            match <- match(x = optionalFlags, table = flagNames)
            if (any(!is.na(match))) {
                hits <- flags[!is.na(match)]
                names(hits) <- flagNames[!is.na(match)]
                out[["optionalFlags"]] <- hits
                flags <- setdiff(flags, hits)
                flagNames <- setdiff(flagNames, names(hits))
                cmdArgs <- setdiff(cmdArgs, hits)
            }
        }
        stopifnot(!.hasLength(flags), !.hasLength(flagNames))
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
