test_that("All strings match", {
    expect_identical(
        object = strMatch(
            x = c("a-b", "c-d", "e-f"),
            pattern = "^(.+)-(.+)$",
            fixed = FALSE
        ),
        expected = matrix(
            data = c(
                "a-b", "a", "b",
                "c-d", "c", "d",
                "e-f", "e", "f"
            ),
            nrow = 3L,
            ncol = 3L,
            byrow = TRUE
        )
    )
    expect_identical(
        object = strMatch(
            x = c("a", "aa", "aaa"),
            pattern = "a",
            fixed = TRUE
        ),
        expected = matrix(
            data = rep("a", 3L),
            nrow = 3L,
            ncol = 1L,
            byrow = TRUE
        )
    )
})

test_that("Some strings match", {
    expect_identical(
        object = strMatch(
            x = c("a-b", "c-d", "e_f", NA_character_),
            pattern = "^(.+)-(.+)$",
            fixed = FALSE
        ),
        expected = matrix(
            data = c(
                "a-b", "a", "b",
                "c-d", "c", "d",
                rep(NA_character_, 6L)
            ),
            nrow = 4L,
            ncol = 3L,
            byrow = TRUE
        )
    )
    expect_identical(
        object = strMatch(
            x = c("a", "b", "c"),
            pattern = "a",
            fixed = TRUE
        ),
        expected = matrix(
            data = c("a", NA_character_, NA_character_),
            nrow = 3L,
            ncol = 1L,
            byrow = TRUE
        )
    )
})

test_that("No strings match", {
    expect_identical(
        object = strMatch(
            x = c("a_b", "c_d", NA_character_),
            pattern = "^(.+)-(.+)$",
            fixed = FALSE
        ),
        expected = matrix(
            data = rep(NA_character_, 9L),
            nrow = 3L,
            ncol = 3L,
            byrow = TRUE
        )
    )
    expect_identical(
        object = strMatch(
            x = c("a", "b", "c"),
            pattern = "d",
            fixed = TRUE
        ),
        expected = matrix(
            data = rep(NA_character_, 3L),
            nrow = 3L,
            ncol = 1L,
            byrow = TRUE
        )
    )
})

test_that("Single regex with no capture groups", {
    expect_identical(
        object = strMatch(
            x = c("a_b", "c_d", NA_character_),
            pattern = "^.+$",
            fixed = FALSE
        ),
        expected = matrix(
            data = c("a_b", "c_d", NA_character_),
            nrow = 3L,
            ncol = 1L,
            byrow = TRUE
        )
    )
})
