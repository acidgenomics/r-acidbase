context("dots")

test_that("NSE input", {
    expect_identical(
        object = dots(a, b, c),
        expected = list(
            as.name("a"),
            as.name("b"),
            as.name("c")
        )
    )
    expect_identical(
        object = dots(a, b, c, character = TRUE),
        expected = c("a", "b", "c")
    )
})

test_that("Invalid input", {
    expect_error(
        object = dots(a, a, b, c),
        regexp = "hasNoDuplicates"
    )
    expect_error(
        object = dots(),
        regexp = "hasLength"
    )
    expect_error(dots("a"), "NSE")
})
