test_that("strRemoveEmpty", {
    x <- c("", "a", "b", " ", NA_character_)
    expect_identical(
        object = strRemoveEmpty(x, naOk = TRUE),
        expected = c("a", "b", " ", NA_character_)
    )
    expect_identical(
        object = strRemoveEmpty(x, naOk = FALSE),
        expected = c("a", "b", " ")
    )
})
