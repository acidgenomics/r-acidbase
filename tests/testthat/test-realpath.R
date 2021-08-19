context("realpath")

test_that("realpath", {
    unlink(c("AAA", "BBB"), recursive = TRUE)
    dir.create("AAA")
    file.create("BBB")
    path <- c("aaa" = "AAA", "bbb" = "BBB")
    out <- realpath(path)
    expect_identical(basename(out), unname(path))
    expect_identical(names(out), names(path))
    unlink(path, recursive = TRUE)
    expect_error(
        object = realpath(path),
        regexp = "allHaveAccess"
    )
})
