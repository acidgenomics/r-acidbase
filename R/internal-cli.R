## Updated 2023-09-21.
.abort <- function(x) {
    if (isInstalled("AcidCLI")) {
        AcidCLI::abort(x, call = FALSE)
    } else {
        stop(x, call. = FALSE)
    }
}

## Updated 2023-09-21.
.alert <- function(x) {
    if (isInstalled("AcidCLI")) {
        AcidCLI::alert(x)
    } else {
        message(x)
    }
}

## Updated 2023-09-21.
.alertWarning <- function(x) {
    if (isInstalled("AcidCLI")) {
        AcidCLI::alertWarning(x)
    } else {
        message(x)
    }
}

## Updated 2023-09-21.
.toInlineString <- function(x, ...) {
    if (isInstalled("AcidCLI")) {
        AcidCLI::toInlineString(x, ...)
    } else {
        toString(x)
    }
}
