## Compare with:
## - `stringi::stri_match`.
## - `stringr::str_match`.

test_that("All strings match pattern", {
    expect_identical(
        object = strMatch(
            x = c("a-b", "c-d", "e-f"),
            pattern = "^(.+)-(.+)$"
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
})


## Some matches.
x <- c("a-b", "c-d", "e_f", NA)
pattern <- "^(.+)-(.+)$"
mat <- stringi::stri_match(x, regex = pattern)
assert(
    identical(mat, stringr::str_match(x, pattern = pattern)),
    identical(mat, strMatch(x, pattern = pattern))
)

## Single match group.
x <- c("a_b", "c_d", NA)
pattern <- "^.+$"
mat <- stringi::stri_match(x, regex = pattern)
assert(
    identical(mat, stringr::str_match(x, pattern = pattern)),
    identical(mat, strMatch(x, pattern = pattern))
)

## No matches.
x <- c("a_b", "c_d", NA)
pattern <- "^(.+)-(.+)$"
mat <- stringi::stri_match(x, regex = pattern)
assert(
    identical(mat, stringr::str_match(x, pattern = pattern)),
    identical(mat, strMatch(x, pattern = pattern))
)
