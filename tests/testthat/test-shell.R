context("shell")

test_that("Printing output to R console", {
    expect_output(
        shell(
            command = "echo",
            args = c("hello", "world"),
            print = TRUE
        )
    )
    expect_silent(
        shell(
            command = "echo",
            args = c("hello", "world"),
            print = FALSE
        )
    )
})

test_that("Return structure", {
    x <- shell(
        command = "echo",
        args = c("hello", "world"),
        print = FALSE
    )
    expect_identical(
        object = x,
        expected = list(
            "status" = 0L,
            "stdout" = "hello world\n",
            "stderr" = "",
            "timeout" = FALSE
        )
    )
})

test_that("Error on invalid command", {
    expect_error(
        object = shell(
            command = "XXX",
            print = FALSE
        ),
        regexp = "isSystemCommand"
    )
})
