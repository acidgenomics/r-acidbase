test_that("majorMinorVersion", {
    x <- numeric_version(c("1.0.0", "2.1", "3"))
    expect_identical(
        object = majorMinorVersion(x),
        expected = numeric_version(c("1.0", "2.1", "3"))
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
