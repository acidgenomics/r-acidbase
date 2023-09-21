test_that("strReplaceNA", {
    expect_identical(
        object = strReplaceNA(c("a", "b", NA)),
        expected = c("a", "b", "NA")
    )
    expect_identical(
        object = strReplaceNA(character()),
        expected = character()
    )
    expect_identical(
        object = strReplaceNA(NA_character_),
        expected = "NA"
    )
    expect_error(
        object = strReplaceNA(NA),
        regexp = "is.character"
    )
})
