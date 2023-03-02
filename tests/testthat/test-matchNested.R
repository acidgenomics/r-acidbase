## FIXME Add coverage here.

test_that("list", {
    table <- list(
        c("a", "aa", "aaa"),
        list(c("b", "bb", "bbb")),
        list(list(c("c", "cc", "ccc")))
    )
    expect_identical(
        object = matchNested(x = "a", table = table),
        expected = 1L
    )
})

test_that("data.frame", {
    table <- data.frame(
        "V1" = c("a", "aa", "aaa"),
        "V2" = c("b", "bb", "bbb")
    )
    expect_identical(
        object = matchNested(x = "aaa", table = table),
        expected = 3L
    )
})

test_that("DataFrame", {
    table <- DataFrame(
        "V1" = c("a", "aa", "aaa"),
        "V2" = c("b", "bb", "bbb")
    )
    expect_identical(
        object = matchNested(x = "aaa", table = table),
        expected = 3L
    )
})
