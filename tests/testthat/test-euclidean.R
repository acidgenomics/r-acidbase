test_that("euclidean", {
    x <- seq(from = 1L, to = 5L, by = 1L)
    y <- seq(from = 6L, to = 10L, by = 1L)
    expect_identical(
        object = signif(euclidean(x = x, y = y), digits = 6L),
        expected = 11.1803
    )
})
