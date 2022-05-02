context("stdout")

test_that("stdout", {
    x <- shell(
        command = "printf",
        args = c("%s\n", "aaa", "bbb"),
        print = FALSE
    )
    expect_identical(
        object = stdout(x),
        expected = c("aaa", "bbb")
    )
})
