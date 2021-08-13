context("shell")

test_that("Error on invalid command", {
    expect_error(
        object = shell(
            command = "XXX",
            stdout = FALSE,
            stderr = FALSE
        ),
        regexp = "error in running command"
    )
})

test_that("Output to R console", {
    x <- shell(
        command = "echo",
        args = c("hello", "world"),
        stdout = ""
    )
    expect_identical(x, 0L)
})

test_that("Suppress console output", {
    x <- shell(
        command = "echo",
        args = c("hello", "world"),
        stdout = FALSE
    )
    expect_identical(x, 0L)
})

test_that("Output to character vector", {
    x <- shell(
        command = "echo",
        args = c("hello", "world"),
        stdout = TRUE
    )
    expect_identical(
        object = x,
        expected = "hello world"
    )
})
