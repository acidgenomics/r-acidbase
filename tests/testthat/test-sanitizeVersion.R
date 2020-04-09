context("sanitizeVersion")

test_that("sanitizeVersion", {
    x <- c("2.7.15rc1", "1.10.0-patch1", "1.0.2k-fips")
    y <- c("2.7.15", "1.10.0", "1.0.2")
    expect_identical(
        object = sanitizeVersion(x),
        expected = numeric_version(y)
    )
})
