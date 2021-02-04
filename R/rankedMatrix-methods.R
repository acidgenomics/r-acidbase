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
#' lfc <- matrix_lfc
#'
#' ## Increasing (negative to positive).
#' rankedMatrix(lfc, method = "increasing")
#'
#' ## Decreasing (positive to negative).
#' rankedMatrix(lfc, method = "decreasing")
#'
#' ## Bidirectional.
#' rankedMatrix(lfc, method = "bidirectional")
NULL



## Alternatively, can consider using `data.table::frank()` instead of
## `base::rank()`, for speed. This adds an additional dependency, so avoid at
## the moment.
## Updated 2021-02-04.
.rank <-
    function(x, decreasing = FALSE) {
        assert(
            is.numeric(x),
            isFlag(decreasing),
            isFlag(decreasing)
        )
        r <- x
        if (isTRUE(decreasing)) r <- -r
        rank(r, na.last = TRUE, ties.method = "average")
    }



## Note that use of `which()` here will omit `NA` intentionally.
## Updated 2021-02-04.
.bidirRank <-  # nolint
    function(x, removeZeros = FALSE) {
        assert(
            is.numeric(x),
            isFlag(removeZeros)
        )
        ties <- "average"
        ## Set any zero values to NA.
        if (isTRUE(removeZeros)) {
            x[x == 0L] <- NA
        }
        up <- rank(x = x[which(x > 0L)], ties.method = ties)
        down <- -rank(x = -x[which(x < 0L)], ties.method = ties)
        y <- x
        y[names(up)] <- up
        y[names(down)] <- down
        y
    }



## Updated 2021-02-04.
.rankMatrix <-  # nolint
    function(
        x,
        MARGIN = 2L,  # nolint
        decreasing = FALSE
    ) {
        assert(
            is.matrix(x),
            isFlag(decreasing),
            isInt(MARGIN)
        )
        apply(
            X = x,
            MARGIN = MARGIN,
            FUN = .rank,
            decreasing = decreasing
        )
    }



## Updated 2021-02-04.
.bidirRankMatrix <-  # nolint
    function(
        x,
        MARGIN = 2L,  # nolint
        removeZeros = FALSE
    ) {
        assert(
            is.matrix(x),
            isInt(MARGIN),
            isFlag(removeZeros)
        )
        apply(
            X = x,
            MARGIN = MARGIN,
            FUN = .bidirRank,
            removeZeros = removeZeros
        )
    }



## Updated 2021-02-04.
`rankedMatrix,matrix` <-
    function(
        object,
        MARGIN = 2L,  # nolint
        method = c("increasing", "decreasing", "bidirectional")
    ) {
        assert(
            hasLength(object),
            isInt(MARGIN)
        )
        method <- match.arg(method)
        if (method %in% c("decreasing", "increasing")) {
            mat <- .rankMatrix(
                x = object,
                MARGIN = MARGIN,
                decreasing = switch(
                    EXPR = method,
                    "decreasing" = TRUE,
                    "increasing" = FALSE
                )
            )
        } else if (method == "bidirectional") {
            mat <- .bidirRankMatrix(
                x = object,
                MARGIN = MARGIN,
                removeZeros = FALSE
            )
        }
        mat
    }



#' @rdname rankedMatrix
#' @export
setMethod(
    f = "rankedMatrix",
    signature = signature("matrix"),
    definition = `rankedMatrix,matrix`
)
