data(
    matrix,
    package = "AcidTest",
    envir = environment()
)

test_that("numeric", {
    x <- seq(from = 1L, to = 5L, by = 1L)
    y <- seq(from = 6L, to = 10L, by = 1L)
    expect_identical(
        object = signif(euclidean(x = x, y = y), digits = 6L),
        expected = 11.1803
    )
})

test_that("matrix", {
    expect_identical(
        object = signif(zscore(matrix), digits = 6L),
        expected = matrix(
            data = rep(
                c(-1.16190, -0.387298, 0.387298, 1.16190),
                times = 4L
            ),
            nrow = 4L,
            ncol = 4L,
            byrow = TRUE,
            dimnames = dimnames(matrix)
        )
    )
})
