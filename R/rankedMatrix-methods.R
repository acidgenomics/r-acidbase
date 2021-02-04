#' @name rankedMatrix
#' @inherit AcidGenerics::rankedMatrix
#' @note Updated 2021-02-04.
#'
#' @inheritParams AcidRoxygen::params
#' @param method `character(1)`.
#'   Rank the values in `increasing`, `decreasing`, or `bidirectional` order.
#' @param ... Additional arguments.
#'
#' @examples
#' data(matrix_lfc, package = "AcidTest")
#' object <- matrix_lfc
#'
#' ## Increasing (negative to positive).
#' rankedMatrix(object, method = "increasing")
#'
#' ## Decreasing (positive to negative).
#' rankedMatrix(object, method = "decreasing")
#'
#' ## Bidirectional.
#' rankedMatrix(object, method = "bidirectional")
NULL



## Alternatively, can consider using `data.table::frank()` instead of
## `base::rank()`, for speed. This adds an additional dependency, so avoid at
## the moment.
## Updated 2021-02-04.
.rank <-
    function(x, decreasing, tiesMethod) {
        r <- x
        if (isTRUE(decreasing)) r <- -r
        rank(r, na.last = TRUE, ties.method = tiesMethod)
    }



## Updated 2021-02-04.
.rankMatrix <-  # nolint
    function(
        x,
        MARGIN,  # nolint
        decreasing,
        tiesMethod
    ) {
        apply(
            X = x,
            MARGIN = MARGIN,
            FUN = .rank,
            decreasing = decreasing,
            tiesMethod = tiesMethod
        )
    }



## Note that use of `which()` here will omit `NA` intentionally.
## Updated 2021-02-04.
.bidirRank <-  # nolint
    function(x, tiesMethod, removeZeros) {
        ## Set any zero values to NA.
        if (isTRUE(removeZeros)) {
            x[x == 0L] <- NA
        }
        up <- rank(x = x[which(x > 0L)], ties.method = tiesMethod)
        down <- -rank(x = -x[which(x < 0L)], ties.method = tiesMethod)
        y <- x
        y[names(up)] <- up
        y[names(down)] <- down
        y
    }



## Updated 2021-02-04.
.bidirRankMatrix <-  # nolint
    function(
        x,
        MARGIN,  # nolint
        tiesMethod,
        removeZeros = FALSE
    ) {
        apply(
            X = x,
            MARGIN = MARGIN,
            FUN = .bidirRank,
            tiesMethod = tiesMethod,
            removeZeros = removeZeros
        )
    }



## Updated 2021-02-04.
`rankedMatrix,matrix` <-  # nolint
    function(
        object,
        MARGIN = 2L,  # nolint
        method = c("increasing", "decreasing", "bidirectional"),
        tiesMethod
    ) {
        assert(
            hasLength(object),
            isInt(MARGIN)
        )
        method <- match.arg(method)
        tiesMethod <- match.arg(tiesMethod)
        if (method %in% c("decreasing", "increasing")) {
            mat <- .rankMatrix(
                x = object,
                MARGIN = MARGIN,
                decreasing = switch(
                    EXPR = method,
                    "decreasing" = TRUE,
                    "increasing" = FALSE
                ),
                tiesMethod = tiesMethod
            )
        } else if (method == "bidirectional") {
            mat <- .bidirRankMatrix(
                x = object,
                MARGIN = MARGIN,
                tiesMethod = tiesMethod
            )
        }
        mat
    }

formals(`rankedMatrix,matrix`)[["tiesMethod"]] <-
    formals(rank)[["ties.method"]]



#' @rdname rankedMatrix
#' @export
setMethod(
    f = "rankedMatrix",
    signature = signature("matrix"),
    definition = `rankedMatrix,matrix`
)
