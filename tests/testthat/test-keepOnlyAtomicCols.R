test_that("DFrame", {
    object <- DataFrame(
        "a" = I(list(
            c(1L, 2L),
            c(3L, 4L),
            c(5L, 6L)
        )),
        "b" = c(TRUE, TRUE, FALSE),
        "c" = c("a", "b", "c"),
        row.names = c("x", "y", "z")
    )
    expect_identical(
        object = keepOnlyAtomicCols(object),
        expected = object[, c("b", "c")]
    )
})
