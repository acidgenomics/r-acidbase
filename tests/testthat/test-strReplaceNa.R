test_that("strReplaceNa", {
    expect_identical(
        object = strReplaceNa(c("a", "b", NA)),
        expected = c("a", "b", "NA")
    )
    expect_identical(
        object = strReplaceNa(character()),
        expected = character()
    )
    expect_identical(
        object = strReplaceNa(NA_character_),
        expected = "NA"
    )
    expect_error(
        object = strReplaceNa(NA),
        regexp = "is.character"
    )
})
