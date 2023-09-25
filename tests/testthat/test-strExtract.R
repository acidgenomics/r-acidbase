test_that("First match", {
    expect_identical(
        object = strExtract(
            x = c(
                "apples x10",
                "bag of flour",
                "bag of sugar",
                "milk x200 300",
                NA
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
})


stringr::str_extract(
    c("apples x4", "bag of flour", "bag of sugar", "milk x2", NA),
    "[a-z]+"
)
# [1] "apples" "bag"    "bag"    "milk"   NA
stringr::str_extract(
    c("apples x4", "bag of flour", "bag of sugar", "milk x200 300", NA),
    "\\d+"
)
# "4" NA  NA  "2" NA



