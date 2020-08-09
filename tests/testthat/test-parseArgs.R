context("parseArgs")

test_that("Working example", {
    command <- system.file("scripts", "parse-args", package = "acidbase")
    args <- c(
        ## Required arguments:
        "--aaa=AAA", "--bbb=BBB",
        ## Optional arguments:
        "--ccc=CCC", "--ddd=DDD",
        ## Flags:
        "--eee", "--fff",
        ## Positional args:
        "GGG", "HHH"
    )
    out <- shell(
        command = command,
        args = args,
        stdout = TRUE
    )
    expect_match(
        object = paste(out, collapse = "\n"),
        regexp = "requiredArgs"
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
    out <- shell(
        command = command,
        stderr = TRUE
    )
    expect_match(
        object = paste(out, collapse = "\n"),
        regexp = "Positional arguments are required but missing."
    )
})

test_that("No positional args allowed", {
    command <- file.path("parseArgs", "no-positional-args")
    out <- shell(
        command = command,
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
        regexp = "Positional arguments are defined but not allowed"
    )
})
