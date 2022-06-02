test_that("tempdir2", {
    object <- tempdir2()
    expect_true(dir.exists(object))
})
