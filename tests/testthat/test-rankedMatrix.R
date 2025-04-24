data(matrix_lfc, package = "AcidTest", envir = environment())
object <- matrix_lfc
dimnames <- dimnames(object)

test_that("Increasing (negative to positive)", {
    object <- rankedMatrix(object, method = "increasing")
    expected <- matrix(
        data = c(
            1.0,
            2.0,
            3.0,
            4.5,
            4.5,
            6.0,
            7.0,
            8.0,
            7.0,
            4.5,
            2.0,
            1.0,
            6.0,
            4.5,
            8.0,
            3.0,
            6.0,
            8.0,
            2.0,
            4.5,
            3.0,
            4.5,
            7.0,
            1.0,
            8.0,
            6.0,
            1.0,
            7.0,
            4.5,
            2.0,
            4.5,
            3.0
        ),
        nrow = 8L,
        ncol = 4L,
        byrow = FALSE,
        dimnames = dimnames
    )
    expect_type(object, "double")
    expect_identical(object, expected)
})

test_that("Decreasing (positive to negative)", {
    object <- rankedMatrix(object, method = "decreasing")
    expected <- matrix(
        data = c(
            8.0,
            7.0,
            6.0,
            4.5,
            4.5,
            3.0,
            2.0,
            1.0,
            2.0,
            4.5,
            7.0,
            8.0,
            3.0,
            4.5,
            1.0,
            6.0,
            3.0,
            1.0,
            7.0,
            4.5,
            6.0,
            4.5,
            2.0,
            8.0,
            1.0,
            3.0,
            8.0,
            2.0,
            4.5,
            7.0,
            4.5,
            6.0
        ),
        nrow = 8L,
        ncol = 4L,
        byrow = FALSE,
        dimnames = dimnames
    )
    expect_type(object, "double")
    expect_identical(object, expected)
})

test_that("Bidirectional", {
    object <- rankedMatrix(object, method = "bidirectional")
    expected <- matrix(
        data = c(
            -2.0,
            -1.0,
            0.0,
            1.5,
            1.5,
            3.0,
            4.0,
            5.0,
            4.0,
            1.5,
            -1.0,
            -2.0,
            3.0,
            1.5,
            5.0,
            0.0,
            3.0,
            5.0,
            -1.0,
            1.5,
            0.0,
            1.5,
            4.0,
            -2.0,
            5.0,
            3.0,
            -2.0,
            4.0,
            1.5,
            -1.0,
            1.5,
            0.0
        ),
        nrow = 8L,
        ncol = 4L,
        byrow = FALSE,
        dimnames = dimnames
    )
    expect_type(object, "double")
    expect_identical(object, expected)
})
