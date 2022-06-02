test_that("initDir", {
    x <- file.path(tempdir2(), "XXX")
    expect_false(dir.exists(x))
    y <- initDir(x)
    ## Existing directory should not generate warning.
    y <- initDir(y)
    expect_true(dir.exists(x))
    expect_true(dir.exists(y))
    expect_identical(realpath(x), realpath(y))
    unlink2(x)
})
