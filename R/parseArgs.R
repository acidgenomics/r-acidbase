#' Parse command line argument flags
#'
#' @export
#' @note Updated 2020-04-07.
#'
#' @param positional `logical(1)`.
#'   Error if required positional arguments are missing.
#' @param validArgs `character` or `NULL`.
#'   Valid key-value pair argument names.
#'   For example, `aaa` for `--aaa=AAA`.
#' @param validFlags `character` or `NULL`.
#'   Valid flag names.
#'   For example, `aaa` for `--aaa`.
#'
#' @return `character`.
#'   Arguments.
#'
#' @seealso
#' - argparse Python package
#' - argparser R package
#' - optparse R package
#'
#' @examples
#' parseArgs()
#'
#' ## $ Rscript test.Rscript --a="A" --b
#' ## > parseArgs(positional = FALSE, validArgs = "a", validFlags = "b")
parseArgs <- function(
    positional = FALSE,
    validArgs = NULL,
    validFlags = NULL
) {
    if (isTRUE(positional)) {
        posArgs <- positionalArgs()
        if (!.hasLength(posArgs)) {
            stop("Required positional arguments are missing.")
        }
    }
    args <- commandArgs(trailingOnly = TRUE)
    keep <- grepl(pattern = "^--", x = args)
    x <- args[keep]
    ## Check for valid arguments.
    if (!is.null(validArgs) || !is.null(validFlags)) {
        ## Get the argument names (`--a="XXX"` to "a").
        pattern <- "^--([-a-z0-9]+)=.+$"
        keep <- grepl(pattern = pattern, x = x)
        args <- x[keep]
        argNames <- gsub(pattern = pattern, replacement = "\\1", x = args)
        stopifnot(!any(duplicated(argNames)))
        ## Get the flag names (`--a` to "a").
        keep <- grepl(pattern = "^--[-a-z0-9]+$", x = x)
        flags <- x[keep]
        flagNames <- gsub(pattern = "^--", replacement = "", x = flags)
        stopifnot(
            !any(duplicated(flagNames)),
            !.hasLength(intersect(argNames, flagNames)),
            !.hasLength(intersect(argNames, validFlags)),
            !.hasLength(intersect(flagNames, validArgs))
        )
    }
    ## Check for valid arguments.
    if (!is.null(validArgs)) {
        if (!all(argNames %in% validArgs)) {
            invalid <- setdiff(argNames, validArgs)
            stop(sprintf(
                fmt = "Invalid %s: '%s'.",
                ngettext(
                    n = length(invalid),
                    msg1 = "arg",
                    msg2 = "args"
                ),
                toString(invalid)
            ))
        }
    }
    ## Check for valid flags.
    if (!is.null(validFlags)) {
        if (!all(flagNames %in% validFlags)) {
            invalid <- setdiff(flagNames, validFlags)
            stop(sprintf(
                fmt = "Invalid %s: '%s'.",
                ngettext(
                    n = length(invalid),
                    msg1 = "flag",
                    msg2 = "flags"
                ),
                toString(invalid)
            ))
        }
    }
    ## Return arguments.
    x
}
