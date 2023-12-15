test_that("character", {
    x <- c("c", "b", "a")
    table <- c("a", "b", "c", "a", "b", "c")
    expect_identical(
        object = matchAll(x = x, table = table, simplify = FALSE),
        expected = list(
            c(3L, 6L),
            c(2L, 5L),
            c(1L, 4L)
        )
    )
    expect_identical(
        object = matchAll(x = x, table = table, simplify = TRUE),
        expected = c(3L, 6L, 2L, 5L, 1L, 4L)
    )
})

test_that("numeric", {
    x <- c(0.01, 0.10, 1.00)
    table <- c(0.01, 0.01, 0.10, 0.10, 1.00, 1.00)
    expect_identical(
        object = matchAll(x = x, table = table, simplify = FALSE),
        expected = list(
            c(1L, 2L),
            c(3L, 4L),
            c(5L, 6L)
        )
    )
    expect_identical(
        object = matchAll(x = x, table = table, simplify = TRUE),
        expected = c(1L, 2L, 3L, 4L, 5L, 6L)
    )
})

test_that("Invalid input", {
    expect_error(
        object = matchAll(x = "a", table = "b"),
        regexp = "Failed to match"
    )
    expect_error(
        object = matchAll(
            x = c("a", NA_character_),
            table = c("a", "b")
        ),
        regexp = "anyNA"
    )
    expect_error(
        object = matchAll(
            x = c("a", "a"),
            table = c("a", "b")
        ),
        regexp = "hasNoDuplicates"
    )
})
