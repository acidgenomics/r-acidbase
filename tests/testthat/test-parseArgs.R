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

test_that("Required flags mismatch", {
    command <- file.path("parseArgs", "required-flags-error")
    args <- c("--aaa", "--bbb")
    shell(
        command = command,
        args = args
    )

})
