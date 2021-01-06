context("fileDepth")

test_that("fileDepth", {
    expect_identical(
        fileDepth(path = "/"),
        expected = 0L
    )
    ## Note that `/tmp` is symlinked to `/private/tmp` on macOS, so don't use
    ## that for testing here.
    expect_identical(
        object = fileDepth(path = file.path("", "dev")),
        expected = 1L
    )
})
