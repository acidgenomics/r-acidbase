test_that("character", {
    expect_identical(
        object = dupes(c("ccc", "aaa", "bbb", "ccc", "bbb")),
        expected = c("ccc", "bbb")
    )
    expect_identical(
        object = notDupes(c("ccc", "aaa", "bbb", "ccc", "bbb")),
        expected = "aaa"
    )
    expect_identical(
        object = dupes(c(NA_character_, NA_character_, "aaa", "aaa")),
        expected = c(NA_character_, "aaa")
    )
    expect_identical(
        object = notDupes(c(NA_character_, NA_character_, "aaa", "aaa")),
        expected = character()
    )
    expect_identical(
        object = dupes(c("a", "b", "c")),
        expected = character()
    )
    expect_identical(
        object = notDupes(c("a", "b", "c")),
        expected = c("a", "b", "c")
    )
    expect_identical(
        object = dupes(character()),
        expected = character()
    )
    expect_identical(
        object = notDupes(character()),
        expected = character()
    )
})

test_that("numeric", {
    expect_identical(
        object = dupes(seq(from = 1L, to = 3L)),
        expected = integer()
    )
    expect_identical(
        object = notDupes(seq(from = 1L, to = 3L)),
        expected = seq(from = 1L, to = 3L)
    )
    expect_identical(
        object = dupes(c(3L, 2L, 3L, 2L, 1L)),
        expected = c(3L, 2L)
    )
    expect_identical(
        object = notDupes(c(3L, 2L, 3L, 2L, 1L)),
        expected = 1L
    )
})

test_that("logical", {
    expect_false(dupes(c(TRUE, FALSE, FALSE)))
    expect_true(notDupes(c(TRUE, FALSE, FALSE)))
    expect_identical(dupes(c(NA, NA)), NA)
    expect_identical(notDupes(c(NA, NA)), logical())
})

test_that("NULL", {
    expect_null(dupes(NULL))
    expect_null(notDupes(NULL))
})
