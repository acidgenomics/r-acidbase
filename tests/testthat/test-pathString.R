test_that("modifyPathString : unique", {
    x <- c("/usr/local/bin", "/usr/bin")
    var <- "TESTPATH"
    Sys.unsetenv(var)
    addToPathEnd(x = x, var = var)
    ## Note that we're expecting first element at end of path string here.
    expect_identical(
        object = Sys.getenv(var),
        expected = "/usr/bin:/usr/local/bin"
    )
    removeFromPath(x = x, var = var)
    expect_identical(
        object = Sys.getenv(var),
        expected = ""
    )
    addToPathStart(x = x, var = var)
    expect_identical(
        object = Sys.getenv(var),
        expected = "/usr/local/bin:/usr/bin"
    )
})

test_that("modifyPathString : extra and duplicate elements", {
    x <- c("/tmp", "/tmp", "/usr/sbin")
    var <- "TESTPATH"
    Sys.setenv("TESTPATH" = "/usr/local/bin:/usr/bin")
    addToPathEnd(x = x, var = var)
    expect_identical(
        object = Sys.getenv(var),
        expected = "/usr/local/bin:/usr/bin:/usr/sbin:/tmp:/tmp"
    )
    removeFromPath(x = x, var = var)
    expect_identical(
        object = Sys.getenv(var),
        expected = "/usr/local/bin:/usr/bin"
    )
    addToPathStart(x = x, var = var)
    expect_identical(
        object = Sys.getenv(var),
        expected = "/tmp:/tmp:/usr/sbin:/usr/local/bin:/usr/bin"
    )
    Sys.unsetenv(var)
})

test_that("uniquePathString", {
    expect_identical(
        object = uniquePathString("/usr/local/bin:/usr/bin:/tmp:/tmp"),
        expected = "/usr/local/bin:/usr/bin:/tmp"
    )
})
