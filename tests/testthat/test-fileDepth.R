context("fileDepth")

test_that("fileDepth", {
    expect_identical(
        object = fileDepth(file.path("", "tmp")),
        expected = 1L
    )
})
