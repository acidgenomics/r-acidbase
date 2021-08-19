context("parentDirectory")

test_that("parentDirectory", {
    path <- c(getwd(), "~")
    x <- parentDir(path, n = 3L)
    expect_is(x, "character")
})
