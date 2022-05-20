data(
    DataFrame,
    matrix,
    package = "AcidTest",
    envir = environment()
)

test_that("ANY", {
    object <- matrix
    expect_output(
        object = showHeader(object),
        regexp = "length"
    )
})

test_that("Annotated", {
    object <- DataFrame
    expect_output(
        object = showHeader(object),
        regexp = "length"
    )
    version <- package_version("0.0.1")
    metadata(object)[["version"]] <- version
    expect_output(
        object = showHeader(object),
        regexp = as.character(version)
    )
})
