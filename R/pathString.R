## Modifier functions ==========================================================
#' System path string handlers
#'
#' @name modifyPathString
#' @note Updated 2021-08-23.
#'
#' @param x `character`.
#' Elements to add to the system path string defined in `var`.
#'
#' @param var `character(1)`.
#' System environment variable name.
#' Hands off to `Sys.getenv` and `Sys.setenv` internally.
#' Intended for use with `"PATH"`, `"FPATH"`, `"MANPATH"`, etc.
#'
#' @return Invisible `character(1)`.
#' Path string.
#'
#' @examples
#' x <- c("/usr/local/bin", "/usr/bin")
#' var <- "TESTPATH"
#' Sys.unsetenv(var)
#'
#' addToPathEnd(x = x, var = var)
#' Sys.getenv(var)
#'
#' removeFromPath(x = x, var = var)
#' Sys.getenv(var)
#'
#' addToPathStart(x = x, var = var)
#' Sys.getenv(var)
NULL



#' @describeIn modifyPathString
#' Note that input defined in `x` is reversed internally, so the first element
#' in the vector is added to the end of the path string.
#' @export
addToPathEnd <- function(x, var = "PATH") {
    assert(
        isCharacter(x),
        isString(var)
    )
    removeFromPath(x = x, var = var)
    y <- splitPathString(x = Sys.getenv(x = var))
    y <- append(x = y, values = rev(x))
    y <- collapseToPathString(y)
    y <- list(y)
    names(y) <- var
    do.call(what = Sys.setenv, args = y)
    invisible(Sys.getenv(x = var))
}



#' @rdname modifyPathString
#' @export
addToPathStart <- function(x, var = "PATH") {
    assert(
        isCharacter(x),
        isString(var)
    )
    removeFromPath(x = x, var = var)
    y <- splitPathString(x = Sys.getenv(x = var))
    y <- append(x = x, values = y)
    y <- collapseToPathString(y)
    y <- list(y)
    names(y) <- var
    do.call(what = Sys.setenv, args = y)
    invisible(Sys.getenv(x = var))
}



#' @rdname modifyPathString
#' @export
removeFromPath <- function(x, var = "PATH") {
    assert(
        isCharacter(x),
        isString(var)
    )
    y <- Sys.getenv(x = var)
    y <- splitPathString(y)
    keep <- !y %in% x
    y <- y[keep]
    if (hasLength(y)) {
        y <- collapseToPathString(y)
        y <- list(y)
        names(y) <- var
        do.call(what = Sys.setenv, args = y)
    } else {
        Sys.unsetenv(x = var)
    }
    invisible(Sys.getenv(x = var))
}



## Return functions ============================================================
#' Collapse the input to a `PATH` string.
#'
#' @export
#' @note Updated 2021-08-23.
#'
#' @param x `character`.
#' Elements to combine into a path string.
#'
#' @return `character(1)`.
#'
#' @examples
#' collapseToPathString(c("/usr/local/bin", "/usr/bin"))
collapseToPathString <- function(x) {
    assert(isCharacter(x))
    paste(x, sep = ":", collapse = ":")
}



#' Split path string environment variable
#'
#' @export
#' @note Updated 2021-08-18.
#'
#' @param x `character(1)`.
#' PATH string, containing elements separated with a colon (`":"`).
#' Defaults to system path string.
#'
#' @return `character`.
#' Discrete path elements in a vector.
#' Intentionally does not make elements unique.
#'
#' @seealso
#' - `Sys.getenv("PATH")`
#'
#' @examples
#' splitPathString()
splitPathString <- function(x = Sys.getenv("PATH")) {
    if (!isString(x)) {
        return(character())
    }
    x <- strsplit(x = x, split = ":", fixed = TRUE)[[1L]]
    assert(isCharacter(x))
    x
}



#' Unique path string
#'
#' @export
#' @note Updated 2021-08-23.
#'
#' @param x `character(1)`.
#' Path string, containing elements separated with a colon (`":"`).
#' Defaults to system path string.
#'
#' @return `character(1)`.
#'
#' @seealso
#' - `Sys.getenv("PATH")`
#'
#' @examples
#' uniquePathString()
uniquePathString <- function(x = Sys.getenv("PATH")) {
    x <- splitPathString(x)
    x <- unique(x)
    x <- collapseToPathString(x)
    x
}
