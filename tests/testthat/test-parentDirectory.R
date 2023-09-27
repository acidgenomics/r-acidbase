test_that("Nested structure check", {
    tempdir <- tempdir2()
    vec <- c("aaa", "bbb", "ccc", "ddd", "eee")
    path <- do.call(what = file.path, args = as.list(vec))
    path <- file.path(tempdir, path)
    path <- initDir(path)
    for (n in seq(from = 1L, to = length(vec) - 1L)) {
        expect_identical(
            object = basename(parentDir(path, n = n)),
            expected = vec[length(vec) - n]
        )
    }
    unlink2(tempdir)
})

test_that("Names handling", {
    path <- c("aaa" = getwd(), "bbb" = "~")
    x <- parentDir(path, n = 3L)
    expect_type(x, "character")
    expect_named(x)
})

test_that("URL", {
    url <- pasteUrl(
        "r.acidgenomics.com",
        "packages",
        "acidbase",
        "reference",
        "parentDirectory.html",
        protocol = "https"
    )
    expect_identical(
        object = parentDir(url, n = 2L),
        expected = url <- pasteUrl(
            "r.acidgenomics.com",
            "packages",
            "acidbase",
            protocol = "https"
        )
    )
})
