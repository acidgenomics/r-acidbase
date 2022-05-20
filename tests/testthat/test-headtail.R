test_that("atomic", {
    expect_output(
        object = headtail(c("A", "B")),
        regexp = "A B"
    )
    expect_output(
        object = headtail(LETTERS),
        regexp = "A B ... Y Z"
    )
})

matrix <- matrix(
    data = sample(x = c(0L, 1L), size = 10000L, replace = TRUE),
    nrow = 100L,
    ncol = 100L,
    byrow = FALSE,
    dimnames = list(
        paste0("gene", seq(from = 1L, to = 100L, by = 1L)),
        paste0("sample", seq(from = 1L, to = 100L, by = 1L))
    )
)

test_that("matrix", {
    expect_output(
        object = headtail(matrix),
        regexp = "gene1"
    )
    expect_output(
        object = headtail(matrix[seq_len(2L), seq_len(2L)]),
        regexp = "gene1"
    )
})
