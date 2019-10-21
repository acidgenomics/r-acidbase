## isAny
## hasNoDuplicates
## isInt
## hasNames
## hasLength
## isString



## Updated 2019-10-21.
.isCharacter <- function(x) {
    ok <- is.character(x)
    if (!isTRUE(ok)) return(FALSE)
    ok <- all(nzchar(x))
    if (!isTRUE(ok)) return(FALSE)
    TRUE
}



## Updated 2019-10-21.
.isFlag <- function(x) {
    ok <- .isScalar(x)
    if (!isTRUE(ok)) return(FALSE)
    ok <- is.logical(x)
    if (!isTRUE(ok)) return(FALSE)
    TRUE
}



## Updated 2019-10-21.
.isInt <- function(x) {
    ok <- .isScalar(x)
    if (!isTRUE(ok)) return(FALSE)
    ok <- is.integer(x)
    if (!isTRUE(ok)) return(FALSE)
    TRUE
}



## Detect `.local()` inside an S4 method.
## Updated 2019-10-21.
.isLocalCall <- function(call) {
    stopifnot(is.call(call))
    identical(call[[1L]], as.symbol(".local"))
}



## Updated 2019-10-21.
.isScalar <- function(x) {
    ok <- is.atomic(x)
    if (!isTRUE(ok)) return(FALSE)
    ok <- identical(length(x), 1L)
    if (!isTRUE(ok)) return(FALSE)
    TRUE
}