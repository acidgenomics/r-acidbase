context("positionalArgs")

## This function is well-covered inside koopa package.

test_that("No arguments", {
    expect_identical(
        object = positionalArgs(),
        expected = character()
    )
})
