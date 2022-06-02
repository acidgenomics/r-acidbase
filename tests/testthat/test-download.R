test_that("Bioconductor release", {
    url <- "https://bioconductor.org/bioc-version"
    destfile <- file.path(tempdir2(), "bioc-version.txt")
    out <- download(url = url, destfile = destfile, quiet = TRUE)
    expect_identical(destfile, out)
    expect_true(file.exists(destfile))
    unlink2(destfile)
})
