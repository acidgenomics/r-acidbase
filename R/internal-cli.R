.abort <- function(x) {
    if (isTRUE(requireNamespace("AcidCLI", quietly = TRUE))) {
        AcidCLI::abort(x)
    } else {
        stop(x)
    }
}

.alert <- function(x) {
    if (isTRUE(requireNamespace("AcidCLI", quietly = TRUE))) {
        AcidCLI::alert(x)
    } else {
        message(x)
    }
}

.alertWarning <- function(x) {
    if (isTRUE(requireNamespace("AcidCLI", quietly = TRUE))) {
        AcidCLI::alertWarning(x)
    } else {
        message(x)
    }
}

.toInlineString <- function(x, ...) {
    if (isTRUE(requireNamespace("AcidCLI", quietly = TRUE))) {
        AcidCLI::toInlineString(x, ...)
    } else {
        toString(x)
    }
}
