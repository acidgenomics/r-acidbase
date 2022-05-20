test_that("methods 'show()'", {
    skip_if_not_installed("methods")
    x <- methodFunction(
        f = "show",
        signature = "ANY",
        package = "methods"
    )
    expect_type(x, "closure")
    x <- methodFormals(
        f = "show",
        signature = "ANY",
        package = "methods"
    )
    expect_type(x, "pairlist")
})

test_that("Expected failure", {
    expect_error(
        methodFunction("XXX", signature = "ANY", package = "methods"),
        "Failed to locate"
    )
})

test_that("S4Vectors 'as.data.frame()'", {
    skip_if_not_installed("S4Vectors")
    ## Use `substitute()` to put a missing argument in pairlist.
    ## https://stackoverflow.com/questions/3892580
    formals <- pairlist(
        "x" = substitute(),
        row.names = NULL,
        optional = FALSE,
        "..." = substitute()
    )
    ## Function
    x <- methodFunction(
        f = "as.data.frame",
        signature = "ANY",
        package = "S4Vectors"
    )
    expect_type(x, "closure")
    expect_identical(formals(x), formals)
    ## Formals
    x <- methodFormals(
        f = "as.data.frame",
        signature = "ANY",
        package = "S4Vectors"
    )
    expect_identical(x, formals)
})

test_that(".local handling", {
    skip_if_not_installed("BiocGenerics")
    skip_if_not_installed("S4Vectors")
    md <- getMethod(
        f = "aggregate",
        signature = "Vector",
        where = asNamespace("S4Vectors")
    )
    expect_true(.hasLocal(md))
    expect_type(.extractLocal(md), "closure")
    md <- getMethod(
        f = "as.data.frame",
        signature = "ANY",
        where = asNamespace("BiocGenerics")
    )
    expect_false(.hasLocal(md))
    expect_error(.extractLocal(md))
})
