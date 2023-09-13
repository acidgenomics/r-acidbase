test_that("character", {
    expect_identical(
        object = strsplit2(
            x = c(
                "TSPAN6_ENST00000373020",
                "TSPAN6_ENST00000494424",
                "TSPAN6_ENST00000496771",
                "TSPAN6_ENST00000612152",
                "TSPAN6_ENST00000614008"
            ),
            split = "_"
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

test_that("Size mismatch", {
    expect_error(
        object = strsplit2(
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
        object = strsplit2("xxx", split = "_"),
        regexp = "allAreMatchingFixed"
    )
    expect_error(
        object = strsplit2("xxx", split = "xx"),
        regexp = "nchar"
    )
    expect_error(
        object = strsplit2(c("aaa_bbb", "aaa_ccc", NA), split = "_"),
        regexp = "NA"
    )
})
