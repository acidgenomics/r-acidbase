## FIXME Need to improve code coverage for other classes:
## matrix, data.frame, Matrix, DataFrame.
## FIXME Need to provide edge cases to test code.
## FIXME Need to import array class here?

## This is a good data.frame example.
## > object <- as.data.frame(mtcars)[seq_len(4L), c("carb", "cyl", "gear")]
##
## This is a good matrix example.
## > object <- as.matrix(mtcars)[seq_len(4L), c("carb", "cyl", "gear")]



context("intersectionMatrix")

## FIXME Improve the checks here...
test_that("list", {
    object <- list(
        "a" = c("a", "b", "c", "d", "e", "f"),
        "b" = c("b", "c", "d", "e", "f", "g"),
        "c" = c("c", "d", "e", "f", "g", "h")
    )
    mat <- intersectionMatrix(object)
    expect_identical(
        object = dimnames(mat),
        expected = list(
            c("a", "b", "c", "d", "e", "f", "g", "h"),
            c("a", "b", "c")
        )
    )
    expect_identical(
        object = as.integer(rowSums(mat)),
        expected = c(1L, 2L, 3L, 3L, 3L, 3L, 2L, 1L)
    )
})

test_that("unnamed list", {
    ## FIXME This is returning rownames, which we don't want....
    object <- intersectionMatrix(
        object = list(
            seq(from = 1L, to = 3L),
            seq(from = 1L, to = 4L)
        )
    )
    ## FIXME Needs to be a logical matrix.
    expected <- matrix(
        data = c(
            TRUE, TRUE,
            TRUE, TRUE,
            TRUE, TRUE,
            FALSE, TRUE
        ),
        nrow = 4L,
        ncol = 2L,
        byrow = TRUE,
        dimnames = NULL
    )
})


## FIXME Need to check numeric matrix.
## FIXME Need to check character matrix.

## FIXME Need to check mismatched data frame.
## FIXME Need to check correct data frame
## FIXME Need to check Matrix.
## FIXME Need to check DataFrame.
