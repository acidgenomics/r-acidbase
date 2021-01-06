#' @name headtail
#' @inherit AcidGenerics::headtail
#' @note Updated 2020-10-07.
#'
#' @inheritParams AcidRoxygen::params
#' @param n `integer(1)`.
#'   Positive integer denoting the number of first and last items to include.
#' @param ... Additional arguments.
#'
#' @examples
#' data(mtcars, package = "datasets")
#'
#' ## data.frame ====
#' headtail(mtcars)
NULL



## Updated 2020-10-07.
`headtail,atomic` <-  # nolint
    function(x, n = 2L) {
        assert(
            is.atomic(x),
            is.integer(n), isTRUE(n > 0L)
        )
        if (length(x) <= n * 2L) {
            out <- paste(x, collapse = " ")
        } else {
            out <- paste(
                c(head(x, n = n), "...", tail(x, n = n)),
                collapse = " "
            )
        }
        cat(out, sep = "\n")
        invisible(NULL)
    }



## Updated 2020-10-07.
`headtail,list` <-  # nolint
    `headtail,atomic`



#' @describeIn headtail Paste collapse to a `character(1)`.
#' @export
setMethod(
    f = "headtail",
    signature = signature("list"),
    definition = `headtail,list`
)



## Updated 2020-10-07.
`headtail,vector` <-  # nolint
    `headtail,atomic`



#' @rdname headtail
#' @export
setMethod(
    f = "headtail",
    signature = signature("vector"),
    definition = `headtail,vector`
)



## FIXME NOW SEEING THIS WEIRD COVR ERROR...
## Error in aggregate.data.frame(lhs, mf[-1L], FUN = FUN, ...) :
## no rows to aggregate
## >

## Updated 2020-10-07.
`headtail,matrix` <-  # nolint
    function(x, n = 2L) {
        ## FIXME THIS IS CAUSING COVR TO FREAK OUT.
        ## > assert(
        ## >     isTRUE(nrow(x) > 0L), isTRUE(ncol(x) > 0L),
        ## >     is.integer(n), isTRUE(n > 0L)
        ## > )
        if (nrow(x) <= n * 2L || ncol(x) <= n * 2L) {
            out <- x[
                head(rownames(x), n = n * 2L),
                head(colnames(x), n = n * 2L),
                drop = FALSE
                ]
            out <- as.data.frame(out)
        } else {
            ## Ensure that we're performing subset operation before coercion to
            ## data.frame, as this can blow up in memory for sparse matrices.
            square <- x[
                c(
                    head(rownames(x), n = n),
                    tail(rownames(x), n = n)
                ),
                c(
                    head(colnames(x), n = n),
                    tail(colnames(x), n = n)
                ),
                drop = FALSE
                ]
            ## Coerce to data.frame, for consistency.
            square <- as.data.frame(square)
            ## Sanitize all non-atomic columns to placeholder symbol.
            list <- lapply(
                X = square,
                FUN = function(x) {
                    if (is.factor(x)) {
                        as.character(x)  # nocov
                    } else if (is.atomic(x)) {
                        x
                    } else {
                        "<>"
                    }
                }
            )
            ## Now safe to coerce to atomic data.frame.
            square <- data.frame(
                list,
                row.names = rownames(square),
                check.rows = FALSE,
                check.names = FALSE,
                stringsAsFactors = FALSE
            )
            ## Check that we have square dimensions.
            assert(
                nrow(square) == n * 2L,
                ncol(square) == n * 2L
            )
            ## Split into quadrants, so we can add vertical separators.
            ## upper/lower, left/right.
            ul <- square[seq_len(n), seq_len(n), drop = FALSE]
            ur <- square[seq_len(n), seq_len(n) + n, drop = FALSE]
            ll <- square[seq_len(n) + n, seq_len(n), drop = FALSE]
            lr <- square[seq_len(n) + n, seq_len(n) + n, drop = FALSE]
            head <- data.frame(
                ul,
                "..." = rep("...", times = n),
                ur,
                check.rows = FALSE,
                check.names = FALSE,
                stringsAsFactors = FALSE
            )
            tail <- data.frame(
                ll,
                "..." = rep("...", times = n),
                lr,
                check.rows = FALSE,
                check.names = FALSE,
                stringsAsFactors = FALSE
            )
            out <- rbind(
                head,
                "..." = c(
                    rep("...", times = n),
                    "...",
                    rep("...", times = n)
                ),
                tail,
                stringsAsFactors = FALSE
            )
        }
        print(out)
        invisible(NULL)
    }



#' @describeIn headtail Show first and last rows.
#' @export
setMethod(
    f = "headtail",
    signature = signature("matrix"),
    definition = `headtail,matrix`
)



## Updated 2019-07-22.
`headtail,data.frame` <-  # nolint
    `headtail,matrix`



#' @describeIn headtail Same method as `matrix`.
#' @export
setMethod(
    f = "headtail",
    signature = signature("data.frame"),
    definition = `headtail,data.frame`
)
