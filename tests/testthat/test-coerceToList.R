context("coerceToList")

data(DFrame, package = "AcidTest", envir = environment())

test_that("coerceToList", {
    object <- DFrame
    object <- coerceToList(object)
    expect_is(object, "list")
    expect_identical(
        object = names(object),
        expected = c(
            "rownames",
            "nrows",
            "listData",
            "elementType",
            "elementMetadata",
            "metadata"
        )
    )
})
