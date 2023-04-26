data(
    DFrame,
    package = "AcidTest",
    envir = environment()
)

test_that("coerceToList", {
    object <- DFrame
    object <- coerceToList(object)
    expect_type(object, "list")
    expect_identical(
        object = sort(names(object)),
        expected = c(
            "elementMetadata",
            "elementType",
            "listData",
            "metadata",
            "nrows",
            "rownames"
        )
    )
})
