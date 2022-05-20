test_that("data.frame", {
    x <- classContains(class = "data.frame", package = "methods")
    expect_identical(x, "list")
})
