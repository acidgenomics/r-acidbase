context("majorVersion")

test_that("majorVersion", {
    x <- package_version("1.0.0")
    expect_identical(
        object = majorVersion(x),
        expected = numeric_version("1")
    )
})
