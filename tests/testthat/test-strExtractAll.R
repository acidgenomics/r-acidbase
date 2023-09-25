test_that("Extract all matches", {
    expect_identical(
        object = strExtractAll(
            x = c(
                "aaa aa a",
                "aa a",
                "a",
                "b",
                "b bb",
                "b bb bbb",
                "b aa",
                NA_character_
            ),
            pattern = "a",
            fixed = TRUE
        ),
        expected = list(
            rep("a", 6L),
            rep("a", 3L),
            "a",
            character(),
            character(),
            character(),
            rep("a", 2L),
            NA_character_
        )
    )
    expect_identical(
        object = strExtractAll(
            x = c(
                "aaa aa a",
                "aa a",
                "a",
                "b",
                "b bb",
                "b bb bbb",
                "b aa",
                NA_character_
            ),
            pattern = "a+",
            fixed = FALSE
        ),
        expected = list(
            c("aaa", "aa", "a"),
            c("aa", "a"),
            "a",
            character(),
            character(),
            character(),
            "aa",
            NA_character_
        )
    )
    expect_identical(
        object = strExtractAll(
            x = c(
                "apples x4",
                "bag of flour",
                "bag of sugar",
                "milk x2",
                NA_character_
            ),
            pattern = "[a-z]+"
        ),
        expected = list(
            c("apples", "x"),
            c("bag", "of", "flour"),
            c("bag", "of", "sugar"),
            c("milk", "x"),
            NA_character_
        )
    )
    expect_identical(
        object = strExtractAll(
            x = c(
                "apples x4",
                "bag of flour",
                "bag of sugar",
                "milk x20",
                NA_character_
            ),
            pattern = "\\d+"
        ),
        expected = list(
            "4",
            character(),
            character(),
            "20",
            NA_character_
        )
    )
})
