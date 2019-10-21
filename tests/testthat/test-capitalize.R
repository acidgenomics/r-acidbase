context("capitalize")

test_that("capitalize", {
    expect_identical(capitalize("foo bar"), "Foo bar")
})
