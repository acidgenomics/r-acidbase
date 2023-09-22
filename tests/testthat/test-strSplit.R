test_that("Infinite, fixed", {
    expect_identical(
        object = strSplit(
            x = c(
                "TSPAN6_ENST00000373020",
                "TSPAN6_ENST00000494424",
                "TSPAN6_ENST00000496771",
                "TSPAN6_ENST00000612152",
                "TSPAN6_ENST00000614008"
            ),
            split = "_",
            fixed = TRUE
        ),
        expected = matrix(
            data = c(
                "TSPAN6", "ENST00000373020",
                "TSPAN6", "ENST00000494424",
                "TSPAN6", "ENST00000496771",
                "TSPAN6", "ENST00000612152",
                "TSPAN6", "ENST00000614008"
            ),
            ncol = 2L,
            byrow = TRUE
        )
    )
})

test_that("Infinite, regex", {
    expect_identical(
        object = strSplit(
            x = c(
                "TSPAN6_ENST00000373020",
                "TSPAN6__ENST00000494424",
                "TSPAN6___ENST00000496771",
                "TSPAN6____ENST00000612152",
                "TSPAN6_____ENST00000614008"
            ),
            split = "_+",
            fixed = FALSE
        ),
        expected = matrix(
            data = c(
                "TSPAN6", "ENST00000373020",
                "TSPAN6", "ENST00000494424",
                "TSPAN6", "ENST00000496771",
                "TSPAN6", "ENST00000612152",
                "TSPAN6", "ENST00000614008"
            ),
            ncol = 2L,
            byrow = TRUE
        )
    )
})

test_that("Fixed, finite", {
    expect_identical(
        object = strSplit(
            x = c(
                "aaaa : bbb : cc",
                "ddddd : e",
                "ff : gg : hh : ii"
            ),
            split = " : ",
            fixed = TRUE,
            n = 2L
        ),
        expected = matrix(
            data = c(
                "aaaa", "bbb : cc",
                "ddddd", "e",
                "ff", "gg : hh : ii"
            ),
            ncol = 2L,
            byrow = TRUE
        )
    )
})

test_that("Regex, finite", {
    expect_identical(
        object = strSplit(
            x = c(
                "aaaa:bbb::ccccc",
                "aa:::bb",
                "aaa::bbbb::::ccc:ddddd",
                "a:b"
            ),
            split = ":+",
            fixed = FALSE,
            n = 2L
        ),
        expected = matrix(
            data = c(
                "aaaa", "bbb::ccccc",
                "aa", "bb",
                "aaa", "bbbb::::ccc:ddddd",
                "a", "b"
            ),
            ncol = 2L,
            byrow = TRUE
        )
    )
})

test_that("Split mismatch", {
    expect_error(
        object = strSplit(
            x = c(
                "TSPAN6_ENST00000373020",
                "TSPAN6_AAA_ENST00000494424",
                "TSPAN6_ENST00000496771",
                "TSPAN6_ENST00000612152",
                "TSPAN6_BBB_ENST00000614008"
            ),
            split = "_"
        ),
        regexp = "Split mismatch detected: 2, 5."
    )
})

test_that("Invalid input", {
    expect_error(
        object = strSplit(c("aaa_bbb", "aaa_ccc", NA), split = "_"),
        regexp = "NA"
    )
    expect_error(
        object = strSplit("xxx", split = "_", fixed = TRUE),
        regexp = "allAreMatchingFixed"
    )
    expect_error(
        object = strSplit("xxx", split = "_+", fixed = TRUE),
        regexp = "allAreMatchingRegex"
    )
    expect_error(
        object = strSplit("a:b", split = ":", n = 1L),
        regexp = "isInRange"
    )
    expect_error(
        object = strSplit("", split = ""),
        regexp = "isCharacter"
    )
    expect_error(
        object = strSplit(NA_character_, split = NA_character_),
        regexp = "isCharacter"
    )
})
