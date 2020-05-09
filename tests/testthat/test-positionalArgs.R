context("positionalArgs")

## This function is well-covered inside koopa package.

test_that("No arguments", {
    expect_error(
        object = positionalArgs(),
        regexp = "No positional arguments are defined."
    )
})
