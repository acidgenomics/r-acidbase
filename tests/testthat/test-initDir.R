context("initDir")

test_that("initDir", {
    dir <- "XXX"
    unlink(dir, recursive = TRUE)
    x <- initDir(dir)
    ## Existing directory should not generate warning.
    x <- initDir(dir)
    expect_identical(basename(x), dir)
    expect_true(dir.exists(x))
    unlink(dir, recursive = TRUE)
})
