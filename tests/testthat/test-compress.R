context("compress")

text <- c("hello", "world")
file <- "test.txt"
writeLines(text = text, con = file)

ext <- eval(formals(compress)[["ext"]])
with_parameters_test_that(
    desc_stub = toString(ext),
    code = {
        ## Compress the file.
        zfile <- compress(
            file = file,
            ext = ext,
            remove = TRUE,
            overwrite = TRUE
        )
        expect_true(file.exists(zfile))
        expect_false(file.exists(file))
        ## Decompress the compressed file.
        file <- decompress(file = zfile, remove = TRUE, overwrite = TRUE)
        expect_true(file.exists(file))
        expect_false(file.exists(zfile))
        expect_identical(
            object = readLines(con = file),
            expected = text
        )
    },
    ext = ext
)

unlink(file)
