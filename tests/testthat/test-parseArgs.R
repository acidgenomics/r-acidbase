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

test_that("Missing required flags", {
    command <- file.path("parseArgs", "required-flags")
    args <- c("--aaa", "--bbb")
    out <- shell(
        command = command,
        args = args,
        stderr = TRUE
    )
    expect_match(
        object = paste(out, collapse = "\n"),
        regexp = "Failed to match required flag"
    )
})

test_that("Missing required args", {
    command <- file.path("parseArgs", "required-args")
    args <- c("--aaa=AAA", "--bbb=BBB")
    out <- shell(
        command = command,
        args = args,
        stderr = TRUE
    )
    expect_match(
        object = paste(out, collapse = "\n"),
        regexp = "Failed to match required arg"
    )
})

test_that("Unset args or flags as positional args", {
    command <- file.path("parseArgs", "positional-args")
    args <- c("--aaa", "--bbb=BBB")
    out <- shell(
        command = command,
        args = args,
        stderr = TRUE
    )
    expect_match(
        object = paste(out, collapse = "\n"),
        regexp = "positionalArgs"
    )
})

test_that("Missing positional args", {
    command <- file.path("parseArgs", "positional-args")
    args <- ""
    out <- shell(
        command = command,
        args = args,
        stderr = TRUE
    )
    expect_match(
        object = paste(out, collapse = "\n"),
        regexp = "positionalArgs"
    )
})

test_that("No positional args allowed", {
    command <- file.path("parseArgs", "no-positional-args")
    args <- ""
    out <- shell(
        command = command,
        args = args,
        stdout = TRUE
    )
    expect_match(
        object = paste(out, collapse = "\n"),
        regexp = "positionalArgs"
    )
    args <- c("aaa", "bbb")
    out <- shell(
        command = command,
        args = args,
        stderr = TRUE
    )
    expect_match(
        object = paste(out, collapse = "\n"),
        regexp = "hasLength"
    )
})
