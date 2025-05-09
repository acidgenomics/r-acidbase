#' Access the data inside an S4 method definition
#'
#' @name methodDefinition
#' @note Updated 2021-08-13.
#'
#' @inheritParams methods::selectMethod
#' @inheritParams methods::setMethod
#' @param package `character(1)`.
#' Package name.
#'
#' @return
#' - `methodFormals`: `list`. Extract the sealed formal arguments.
#' - `methodFunction`: `function`. Extract the sealed function.
#'
#' @seealso
#' - Modified version of John Chambers' code.
#' - `help(topic = "MethodDefinition-class", package = "methods")`.
#' - `methods::selectMethod()`.
#' - `methods::setMethod()`.
#'
#' @examples
#' ## Function ====
#' x <- methodFunction(
#'     f = "show",
#'     signature = "ANY",
#'     package = "methods"
#' )
#' class(x)
#' body(x)
#'
#' ## Formals ====
#' x <- methodFormals(
#'     f = "show",
#'     signature = "ANY",
#'     package = "methods"
#' )
#' class(x)
#' print(x)
NULL


#' @rdname methodDefinition
#' @export
## Updated 2021-08-13.
methodFunction <- function(f, signature, package) {
    assert(isString(package))
    envir <- asNamespace(package)
    ## Locate the S4 generic. We're opting to get either the `standardGeneric`
    ## or the `nonstandardGenericFunction` instead of requiring
    ## `standardGeneric` via `getGeneric` here, since it's more flexible with
    ## re-exported generic functions.
    args <- Filter(
        f = Negate(is.null),
        x = list(
            x = f,
            envir = envir,
            inherits = TRUE
        )
    )
    generic <- tryCatch(
        expr = do.call(what = get, args = args),
        error = function(e) {
            .abort(sprintf(
                "Failed to locate {.fun %s} generic in {.pkg %s} package.",
                f,
                package
            ))
        }
    )
    ## Assert that we're getting an S4 generic.
    assert(isS4(generic))
    args <- Filter(
        f = Negate(is.null),
        x = list(
            f = f,
            where = envir,
            getName = FALSE
        )
    )
    assert(do.call(what = isGeneric, args = args))
    ## Now select the method from the generic.
    definition <- selectMethod(
        f = generic,
        signature = signature,
        useInherited = TRUE,
        doCache = FALSE
    )
    assert(is(definition, "MethodDefinition"))
    ## S4 dispatch will nest `.local` function inside the method definition when
    ## the formals aren't identical to the generic. Otherwise it will be slotted
    ## in ".Data".
    if (isTRUE(.hasLocal(definition))) {
        fun <- .extractLocal(definition)
    } else {
        fun <- slot(definition, ".Data")
    }
    assert(is.function(fun))
    fun
}


#' @rdname methodDefinition
#' @export
## Updated 2019-07-29.
methodFormals <- function(f, signature, package) {
    def <- methodFunction(
        f = f,
        signature = signature,
        package = package
    )
    formals(def)
}


## Updated 2019-07-29.
.extractLocal <- function(definition) {
    assert(.hasLocal(definition))
    body <- body(definition)
    local <- eval(body[[2L]][[3L]])
    assert(is.function(local))
    local
}


## Updated 2019-07-29.
.hasLocal <- function(definition) {
    assert(
        is(definition, "MethodDefinition"),
        is(definition, "function")
    )
    body <- body(definition)
    if (!is(body, "{")) {
        return(FALSE)
    }
    if (!is(body[[2L]], "<-")) {
        return(FALSE)
    }
    if (!identical(body[[2L]][[2L]], as.name(".local"))) {
        return(FALSE)
    }
    TRUE
}
