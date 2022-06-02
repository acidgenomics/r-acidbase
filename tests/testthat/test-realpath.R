test_that("realpath", {
    tempdir <- tempdir2()
    dir.create(file.path(tempdir, "AAA"))
    file.create(file.path(tempdir, "BBB"))
    path <- c(
        "aaa" = file.path(tempdir, "AAA"),
        "bbb" = file.path(tempdir, "BBB")
    )
    out <- realpath(path)
    expect_named(out)
    expect_identical(basename(out), basename(path))
    unlink2(tempdir)
    expect_error(realpath(path))
})
