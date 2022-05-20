data(
    DataFrame,
    package = "AcidTest",
    envir = environment()
)

test_that("coerceToList", {
    object <- DataFrame
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
