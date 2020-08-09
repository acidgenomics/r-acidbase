context("parseArgs")

test_that("Working example", {
    command <- system.file("scripts", "parse-args", package = "acidbase")
    args <- c(
        ## Required flags:
        "--aaa", "--bbb",
        ## Optional flags:
        "--ccc", "--ddd",
        ## Required args:
        "--eee=EEE", "--fff=FFF",
        ## Optional args:
        "--ggg=GGG", "--hhh=HHH",
        ## Positional args:
        "III", "JJJ"
    )
    out <- shell(
        command = command,
        args = args,
        stdout = TRUE
    )
    expect_match(
        object = paste(out, collapse = "\n"),
        regexp = "requiredFlags"
    )
})

test_that("No arguments", {
    expect_identical(
        object = parseArgs(),
        expected = character()
    )
})
