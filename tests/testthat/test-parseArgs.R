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

test_that("Invalid required args", {
    command <- file.path("parseArgs", "required-args")
    args <- "--zzz=ZZZ"
    out <- shell(
        command = command,
        args = args,
        stderr = TRUE
    )
    expect_match(
        object = paste(out, collapse = "\n"),
        regexp = "Missing required args: aaa, bbb."
    )
})

test_that("Missing required args", {
    command <- file.path("parseArgs", "required-args")
    args <- "--aaa=AAA"
    out <- shell(
        command = command,
        args = args,
        stderr = TRUE
    )
    expect_match(
        object = paste(out, collapse = "\n"),
        regexp = "Missing required args: bbb."
    )
})

test_that("Invalid optional arguments", {
    command <- file.path("parseArgs", "optional-args")
    args <- "--ccc=CCC"
    out <- shell(
        command = command,
        args = args,
        stderr = TRUE
    )
    expect_match(
        object = paste(out, collapse = "\n"),
        regexp = "Invalid args detected: ccc."
    )
})

test_that("Invalid flags", {
    command <- file.path("parseArgs", "flags")
    args <- "--ccc"
    out <- shell(
        command = command,
        args = args,
        stderr = TRUE
    )
    expect_match(
        object = paste(out, collapse = "\n"),
        regexp = "Invalid flags detected: ccc."
    )
})

test_that("Positional arguments only", {
    command <- file.path("parseArgs", "positional-args")
    args <- c("aaa", "bbb")
    out <- shell(
        command = command,
        args = args,
        stdout = TRUE
    )
    expect_match(
        object = paste(out, collapse = "\n"),
        regexp = "aaa"
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
