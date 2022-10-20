test_that("No modification", {
    expect_identical(
        object = truncateString("abc", n = 3L),
        expected = "abc"
    )
})

test_that("Add ellipsis", {
    expect_identical(
        object = truncateString("abcdefg", n = 6L),
        expected = "abc..."
    )
})
