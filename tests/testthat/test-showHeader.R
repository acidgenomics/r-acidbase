data(
    DFrame,
    matrix,
    package = "AcidTest",
    envir = environment()
)

test_that("ANY", {
    object <- matrix
    expect_output(
        object = showHeader(object),
        regexp = "matrix of length 16"
    )
})

test_that("Annotated", {
    object <- DFrame
    expect_output(
        object = showHeader(object),
        regexp = "DFrame with 4 rows and 2 columns"
    )
    version <- package_version("0.0.1")
    metadata(object)[["version"]] <- version
    expect_output(
        object = showHeader(object),
        regexp = as.character(version)
    )
})
