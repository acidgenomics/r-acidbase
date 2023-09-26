test_that("character", {
    expect_identical(
        object = dupes(c("ccc", "aaa", "bbb", "ccc", "bbb")),
        expected = c("ccc", "bbb")
    )
    expect_identical(
        object = dupes(c(NA_character_, NA_character_, "aaa", "aaa")),
        expected = c(NA_character_, "aaa")
    )
    expect_identical(
        object = dupes(c("a", "b", "c")),
        expected = character()
    )
    expect_identical(
        object = dupes(character()),
        expected = character()
    )
})

test_that("numeric", {
    expect_identical(
        object = dupes(seq(from = 1L, to = 3L)),
        expected = integer()
    )
    expect_identical(
        object = dupes(c(3L, 2L, 3L, 2L, 1L)),
        expected = c(3L, 2L)
    )
})

test_that("logical", {
    expect_identical(
        object = dupes(c(TRUE, FALSE, FALSE)),
        expected = FALSE
    )
    expect_identical(
        object = dupes(c(NA, NA)),
        expected = NA
    )

})

test_that("NULL", {
    expect_identical(
        object = dupes(NULL),
        expected = NULL
    )
})
