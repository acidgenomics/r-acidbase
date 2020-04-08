context("parseArgs")

## This function is well-covered inside koopa package.

test_that("No arguments", {
    expect_identical(
        object = parseArgs(),
        expected = character()
    )
})
