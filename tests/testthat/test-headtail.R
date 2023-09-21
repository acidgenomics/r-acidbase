test_that("atomic", {
    expect_identical(
        object = headtail(c("A", "B")),
        expected = "A B"
    )
    expect_identical(
        object = headtail(LETTERS),
        expected = "A B ... Y Z"
    )
})

test_that("matrix", {
    mat <- matrix(
        data = sample(x = c(0L, 1L), size = 10000L, replace = TRUE),
        nrow = 100L,
        ncol = 100L,
        byrow = FALSE,
        dimnames = list(
            paste0("gene", seq(from = 1L, to = 100L, by = 1L)),
            paste0("sample", seq(from = 1L, to = 100L, by = 1L))
        )
    )
    expect_match(
        object = headtail(mat)[[2L]],
        regexp = "gene1"
    )
    expect_match(
        object = headtail(mat[seq_len(2L), seq_len(2L)])[[2L]],
        regexp = "gene1"
    )
})
