test_that("majorVersion", {
    x <- c("1.0.0", "2.1", "3")
    x <- numeric_version(x)
    expect_identical(
        object = majorVersion(x),
        expected = numeric_version(c("1", "2", "3"))
    )
    expect_error(
        object = majorMinorVersion(""),
        regexp = "isCharacter"
    )
    expect_error(
        object = majorMinorVersion(NA),
        regexp = "isCharacter"
    )
})
