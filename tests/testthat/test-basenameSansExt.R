context("basenameSansExt")

test_that("basenameSansExt", {
    path <- c("dir/foo.txt", "bar.tar.gz", "DESCRIPTION")
    expect_identical(
        basenameSansExt(path),
        c("foo", "bar", "DESCRIPTION")
    )
})
