context("sem")

test_that("numeric", {
    x <- seq(from = 1L, to = 10L, by = 1L)
    x <- sem(x)
    expect_identical(
        object = round(x, digits = 6L),
        expected = 0.957427
    )
})
