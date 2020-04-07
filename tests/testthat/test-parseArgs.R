context("parseArgs")

test_that("No arguments", {
    expect_identical(
        object = parseArgs(),
        expected = character()
    )
})
