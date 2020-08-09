context("positionalArgs")

test_that("Arguments with long flags", {
    out <- shell(
        command = "Rscript",
        args = c(
            file.path("argparse", "positional-args"),
            "--force",
            "a", "b", "c"
        ),
        stdout = TRUE
    )
    expect_identical(out, c("a", "b", "c"))
})

test_that("Error on short flags", {
    out <- shell(
        command = "Rscript",
        args = c(
            file.path("argparse", "positional-args"),
            "-r",
            "a", "b", "c"
        ),
        stderr = TRUE
    )
    expect_match(
        object = paste(out, collapse = "\n"),
        regexp = "Use long flags"
    )
})

test_that("No arguments", {
    out <- shell(
        command = "Rscript",
        args = file.path("argparse", "positional-args"),
        stderr = TRUE
    )
    expect_match(
        object = paste(out, collapse = "\n"),
        regexp = "No positional arguments are defined."
    )
})
