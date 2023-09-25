test_that("First match", {
    expect_identical(
        object = strExtract(
            x = c(
                "apples x10",
                "bag of flour",
                "bag of sugar",
                "milk x200 300",
                NA_character_
            ),
            pattern = "\\d+"
        ),
        expected = c(
            "10",
            NA_character_,
            NA_character_,
            "200",
            NA_character_
        )
    )
    expect_identical(
        object = strExtract(
            x = c(
                "apples x4",
                "bag of flour",
                "bag of sugar",
                "milk x2",
                NA_character_
            ),
            pattern = "[a-z]+"
        ),
        expected = c(
            "apples",
            "bag",
            "bag",
            "milk",
            NA_character_
        )
    )
})
