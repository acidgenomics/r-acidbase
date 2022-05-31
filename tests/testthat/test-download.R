## FIXME This test is failing on Windows.
test_that("Bioconductor release", {
    url <- "https://bioconductor.org/bioc-version"
    destfile <- "bioc-version.txt"
    unlink(destfile)
    expect_false(file.exists(destfile))
    out <- download(url = url, destfile = destfile, quiet = TRUE)
    expect_identical(destfile, out)
    expect_true(file.exists(destfile))
    unlink(destfile)
})
