skip_if_not(isSystemCommand("echo"))

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

test_that("Return stdout", {
    expect_identical(
        object = shell(
            command = "echo",
            args = c("aaa", "bbb"),
            print = FALSE,
            returnStdout = TRUE
        ),
        expected = "aaa bbb"
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

test_that("Error on invalid command argument", {
    skip_if_not(isSystemCommand("ls"))
    expect_error(
        object = shell(
            command = "ls",
            args = "--XXX",
            print = FALSE
        ),
        regexp = "XXX"
    )
})
