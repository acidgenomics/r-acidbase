context("capitalize")

test_that("Vectorized", {
    expect_identical(
        object = capitalize(c("foo bar", "aaa", NA_character_)),
        expected = c("Foo bar", "Aaa", NA_character_)
    )
})
