test_that("list", {
    x <- c("bbb", "ccc", "aaa", "aaa", NA_character_)
    table <- list(
        c("a", "aa", "aaa"),
        list(c("b", "bb", "bbb")),
        list(list(c("c", "cc", "ccc")))
    )
    expect_identical(
        object = matchNested(x = x, table = table),
        expected = c(2L, 3L, 1L, 1L, NA_integer_)
    )
})

test_that("data.frame", {
    x <- c("bbb", "ddd", "ccc", "aaa", "aaa", NA_character_)
    table <- data.frame(
        "V1" = c("a", "aa", "aaa"),
        "V2" = I(list(
            c("b", "bb", "bbb"),
            c("c", "cc", "ccc"),
            c("d", "dd", "ddd")
        ))
    )
    expect_identical(
        object = matchNested(x = x, table = table),
        expected = c(1L, 3L, 2L, 3L, 3L, NA_integer_)
    )
})

test_that("DFrame", {
    x <- c("bbb", "ddd", "ccc", "aaa", "aaa", NA_character_)
    table <- S4Vectors::DataFrame(
        "V1" = c("a", "aa", "aaa"),
        "V2" = I(list(
            c("b", "bb", "bbb"),
            c("c", "cc", "ccc"),
            c("d", "dd", "ddd")
        ))
    )
    expect_identical(
        object = matchNested(x = x, table = table),
        expected = c(1L, 3L, 2L, 3L, 3L, NA_integer_)
    )
})
