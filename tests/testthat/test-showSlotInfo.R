context("showSlotInfo")

test_that("showSlotInfo", {
    list <- list(
        "bool" = TRUE,
        "seq1" = seq(from = 1L, to = 4L, by = 1L),
        "seq2" = seq(from = 1L, to = 100L, by = 1L),
        "seq3" = c("a" = 1L, "b" = 2L, "c" = 3L, "d" = 4L)
    )
    output <- capture.output(showSlotInfo(list))
    expect_identical(
        object = output,
        expected = c(
            "bool: TRUE",
            "seq1(4): 1 2 3 4",
            "seq2(100): 1 2 ... 99 100",
            "seq3(4): [a] 1; [b] 2; [c] 3; [d] 4"
        )
    )
})
