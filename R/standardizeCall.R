#' Standardize call
#'
#' This function adds matching support for S4 methods with formals that aren't
#' identical to the generic, and use a nested `.local` call.
#'
#' @export
#' @note Updated 2020-01-09.
#'
#' @inheritParams base::sys.call
#' @inheritParams acidroxygen::params
#' @param defaults `logical(1)`.
#'   Include default arguments in the call.
#' @param expandDots `logical(1)`.
#'   Should arguments matching `...` in the call be included or left as a
#'   `...` argument?
#'
#' @return
#' - `call`: Matched call.
#' - `list`: Verbose list that includes additional information about how the
#'   call was standardized. Recommended for debugging purposes only.
#'
#' @seealso
#' - `match.call()`.
#' - `sys.call()`.
#' - `sys.parent()`.
#' - `pryr::standardise_call()`.
#' - `stackoverflow::match.call.defaults()`.
#'
#' @examples
#' aaa <- "AAA"
#' bbb <- "BBB"
#'
#' ## Standard function.
#' testing <- function(a, b) {
#'     standardizeCall()
#' }
#' testing(aaa, bbb)
#'
#' ## Inside S4 method.
#' setGeneric(
#'     name = "testing",
#'     def = function(a, b, ...) {
#'         standardGeneric("testing")
#'     }
#' )
#'
#' setMethod(
#'     f = "testing",
#'     signature = signature("character"),
#'     definition = function(a, b, ...) {
#'         standardizeCall()
#'     }
#' )
#' testing(aaa, bbb)
standardizeCall <- function(
    which = sys.parent(n = 1L),
    defaults = TRUE,
    expandDots = TRUE,
    return = c("call", "list"),
    verbose = getOption("verbose", default = FALSE)
) {
    stopifnot(
        .isInt(which),
        isTRUE(which >= 0L),
        isTRUE(which < length(sys.calls())),
        .isFlag(defaults),
        .isFlag(expandDots),
        .isFlag(verbose)
    )
    return <- match.arg(return)
    ## Don't allow a `which` value less than 1.
    if (which < 1L) {
        which <- 1L  # nocov
    }
    ## Determine where the call is in the stack that we want to standardize.
    ## Note that this differs for S4 methods containing a nested `.local`.
    .local <- .isLocalCall(sys.call(which = which))
    if (isTRUE(.local) && which > 1L) {
        which <- which - 1L
    }
    ## Local the parameters we need to sanitize call.
    definition <- sys.function(which = which)
    call <- sys.call(which = which)
    envir <- sys.frame(which = which)
    list <- list(
        sys.status = sys.status(),
        sys.nframe = sys.nframe(),
        sys.parent = sys.parent(),
        .local = .local,
        which = which,
        definition = definition,
        call = call,
        envir = envir
    )
    ## Extract the definition from `.local`, if necessary.
    if (isTRUE(.local)) {
        stopifnot(!isTRUE(.isLocalCall(call)))
        ## Update definition.
        if (is(definition, "MethodDefinition")) {
            ## Pull the ".local()" function out, which has the formals we need
            ## to match against in `match.call` below.
            definition <- .extractLocal(definition)
            list[["definition"]] <- definition
        }
    }
    if (isTRUE(verbose)) {
        print(list)  # nocov
    }
    ## Now ready to match the call.
    call <- match.call(
        definition = definition,
        call = call,
        expand.dots = expandDots,
        envir = envir
    )
    ## Expand the call to include default arguments, if desired.
    ## Inspired by `stackoverflow::match.call.defaults()`.
    if (isTRUE(defaults)) {
        formals <- formals(definition)
        if (isTRUE(expandDots) && "..." %in% names(formals)) {
            formals[["..."]] <- NULL
        }
        for (i in setdiff(names(formals), names(call))) {
            call[i] <- list(formals[[i]])
        }
        call <- match.call(
            definition = definition,
            call = call,
            expand.dots = TRUE,
            envir = envir
        )
    }
    list[["match.call"]] <- call
    if (isTRUE(verbose)) {
        print(list(match.call = call))  # nocov
    }
    stopifnot(is.call(call))
    switch(EXPR = return, call = call, list = list)
}
