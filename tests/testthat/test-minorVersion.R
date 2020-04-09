context("minorVersion")

test_that("minorVersion", {
    x <- c("1.0.0", "2.1")
    x <- package_version(x)
    expect_identical(
        object = minorVersion(x),
        expected = numeric_version(c("1.0", "2.1"))
    )
})
