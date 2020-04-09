context("majorVersion")

test_that("majorVersion", {
    x <- c("1.0.0", "2.1")
    x <- package_version(x)
    expect_identical(
        object = majorVersion(x),
        expected = numeric_version(c("1", "2"))
    )
})
