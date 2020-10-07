context("headtail")

test_that("atomic", {
    expect_output(
        object = headtail(LETTERS),
        regexp = "A B ... Y Z"
    )

})

test_that("matrix", {
    mat <- assay(rse)
    expect_output(
        object = headtail(mat),
        regexp = "gene001"
    )
})

test_that("matrix : No quadrants", {
    expect_message(
        object = capture.output(headtail(mat)),
        regexp = "Object can't be split into quadrants."
    )
})