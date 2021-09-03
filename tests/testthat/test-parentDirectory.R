context("parentDirectory")

test_that("Nested structure check", {
    vec <- c("aaa", "bbb", "ccc", "ddd", "eee")
    path <- do.call(what = file.path, args = as.list(vec))
    unlink(path, recursive = TRUE)
    path <- initDir(path)
    for (n in seq(from = 1L, to = length(vec) - 1L)) {
        expect_identical(
            object = basename(parentDir(path, n = n)),
            expected =  vec[length(vec) - n]
        )
    }
    unlink(path, recursive = TRUE)
})

test_that("Names handling", {
    path <- c("aaa" = getwd(), "bbb" = "~")
    x <- parentDir(path, n = 3L)
    expect_is(x, "character")
    expect_identical(names(path), names(x))
})

test_that("URL", {
    url <- pasteURL(
        "r.acidgenomics.com",
        "packages",
        "acidbase",
        "reference",
        "parentDirectory.html",
        protocol = "https"
    )
    expect_identical(
        object = parentDir(url, n = 2L),
        expected = url <- pasteURL(
            "r.acidgenomics.com",
            "packages",
            "acidbase",
            protocol = "https"
        )
    )
})
