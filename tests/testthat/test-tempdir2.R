test_that("tempdir2", {
    object <- tempdir2()
    expect_type(object, "character")
    expect_true(dir.exists(object))
})
