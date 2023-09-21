test_that("strPad", {
    x <- c("1", "10", "100")
    width <- max(nchar(x))
    expect_identical(
        object = strPad(x = x, width = width, side = "left", pad = "0"),
        expected = c("001", "010", "100")
    )
    expect_identical(
        object = strPad(x = x, width = width, side = "right", pad = "0"),
        expected = c("100", "100", "100")
    )
    expect_identical(
        object = strPad(x = x, width = width, side = "left", pad = " "),
        expected = c("  1", " 10", "100")
    )
    expect_identical(
        object = strPad(x = x, width = width, side = "right", pad = " "),
        expected = c("1  ", "10 ", "100")
    )
})
