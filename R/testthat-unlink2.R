test_that("unlink2", {
    object <- tempdir2()
    expect_true(dir.exists(object))
    unlink2(object)
    expect_false(dir.exists(object))
})
