context("realpath")

test_that("realpath", {
    unlink(c("AAA", "BBB"), recursive = TRUE)
    dir.create("AAA")
    file.create("BBB")
    expect_identical(
        object = basename(realpath(c("AAA", "BBB"))),
        expected = c("AAA", "BBB")
    )
    unlink(c("AAA", "BBB"), recursive = TRUE)
    expect_error(realpath(c("AAA", "BBB")))
})
