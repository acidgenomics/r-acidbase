test_that("modifyPathString : unique", {
    x <- c(
        file.path("", "usr", "local", "bin"),
        file.path("", "usr", "bin")
    )
    var <- "TESTPATH"
    Sys.unsetenv(var)
    addToPathEnd(x = x, var = var)
    ## Note that we're expecting first element at end of path string here.
    expect_identical(
        object = Sys.getenv(var),
        expected = paste(
            file.path("", "usr", "bin"),
            file.path("", "usr", "local", "bin"),
            sep = ":"
        )
    )
    removeFromPath(x = x, var = var)
    expect_identical(
        object = Sys.getenv(var),
        expected = ""
    )
    addToPathStart(x = x, var = var)
    expect_identical(
        object = Sys.getenv(var),
        expected = paste(
            file.path("", "usr", "local", "bin"),
            file.path("", "usr", "bin"),
            sep = ":"
        )
    )
})

test_that("modifyPathString : extra and duplicate elements", {
    x <- c(
        file.path("", "tmp"),
        file.path("", "tmp"),
        file.path("", "usr", "sbin")
    )
    var <- "TESTPATH"
    Sys.setenv(
        "TESTPATH" = paste(
            file.path("", "usr", "local", "bin"),
            file.path("", "usr", "bin"),
            sep = ":"
        )
    )
    addToPathEnd(x = x, var = var)
    expect_identical(
        object = Sys.getenv(var),
        expected = paste(
            file.path("", "usr", "local", "bin"),
            file.path("", "usr", "bin"),
            file.path("", "usr", "sbin"),
            file.path("", "tmp"),
            file.path("", "tmp"),
            sep = ":"
        )
    )
    removeFromPath(x = x, var = var)
    expect_identical(
        object = Sys.getenv(var),
        expected = paste(
            file.path("", "usr", "local", "bin"),
            file.path("", "usr", "bin"),
            sep = ":"
        )
    )
    addToPathStart(x = x, var = var)
    expect_identical(
        object = Sys.getenv(var),
        expected = paste(
            file.path("", "tmp"),
            file.path("", "tmp"),
            file.path("", "usr", "sbin"),
            file.path("", "usr", "local", "bin"),
            file.path("", "usr", "bin"),
            sep = ":"
        )
    )
    Sys.unsetenv(var)
})

test_that("uniquePathString", {
    expect_identical(
        object = uniquePathString(
            paste(
                file.path("", "usr", "local", "bin"),
                file.path("", "usr", "bin"),
                file.path("", "tmp"),
                file.path("", "tmp"),
                sep = ":"
            )
        ),
        expected = paste(
            file.path("", "usr", "local", "bin"),
            file.path("", "usr", "bin"),
            file.path("", "tmp"),
            sep = ":"
        )
    )
})
