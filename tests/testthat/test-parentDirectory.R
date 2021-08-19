context("parentDirectory")

test_that("parentDirectory", {
    path <- c("aaa" = getwd(), "bbb" = "~")
    x <- parentDir(path, n = 3L)
    expect_is(x, "character")
    expect_identical(names(path), names(x))
})
