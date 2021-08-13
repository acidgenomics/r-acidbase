context("intersectionMatrix")

test_that("named list", {
    expect_identical(
        object = intersectionMatrix(
            object = list(
                "a" = c("a", "b", "c", "d", "e", "f"),
                "b" = c("b", "c", "d", "e", "f", "g"),
                "c" = c("c", "d", "e", "f", "g", "h")
            )
        ),
        expected = matrix(
            data = c(
                TRUE, FALSE, FALSE,
                TRUE,  TRUE, FALSE,
                TRUE,  TRUE,  TRUE,
                TRUE,  TRUE,  TRUE,
                TRUE,  TRUE,  TRUE,
                TRUE,  TRUE,  TRUE,
                FALSE,  TRUE,  TRUE,
                FALSE, FALSE,  TRUE
            ),
            nrow = 8L,
            ncol = 3L,
            byrow = TRUE,
            dimnames = list(
                letters[seq_len(8L)],
                letters[seq_len(3L)]
            )
        )
    )
})

test_that("unnamed list", {
    expect_identical(
        object = intersectionMatrix(
            object = list(
                seq(from = 1L, to = 3L),
                seq(from = 1L, to = 4L)
            )
        ),
        expected = matrix(
            data = c(
                TRUE, TRUE,
                TRUE, TRUE,
                TRUE, TRUE,
                FALSE, TRUE
            ),
            nrow = 4L,
            ncol = 2L,
            byrow = TRUE,
            dimnames = list(
                as.character(seq_len(4L)),
                NULL
            )
        )
    )
})

test_that("two-dimensional arrays", {
    ## Create a minimal test data.frame (subset from `datasets::mtcars`).
    cars <- data.frame(
        "carb" = c(4L, 4L, 1L, 1L),
        "cyl" = c(6L, 6L, 4L, 6L),
        "gear" = c(4L, 4L, 4L, 3L),
        row.names = c(
            "Mazda RX4",
            "Mazda RX4 Wag",
            "Datsun 710",
            "Hornet 4 Drive"
        )
    )
    for (object in list(
        "matrix" = as.matrix(object),
        "data.frame" = as.data.frame(object),
        "DataFrame" = as(object, "DataFrame")
    )) {
        expect_identical(
            object = intersectionMatrix(object),
            expected = matrix(
                data = c(
                     TRUE, FALSE, FALSE,
                    FALSE, FALSE,  TRUE,
                     TRUE,  TRUE,  TRUE,
                    FALSE,  TRUE, FALSE
                ),
                nrow = 4L,
                ncol = 3L,
                byrow = TRUE,
                dimnames = list(
                    c("1", "3", "4", "6"),
                    c("carb", "cyl", "gear")
                )
            )
        )
    }
})

test_that("data frame of factors", {
    expect_identical(
        object = intersectionMatrix(
            object = data.frame(
                "a" = as.factor(c(1L, 2L, 3L)),
                "b" = as.factor(c(2L, 3L, 4L)),
                "c" = as.factor(c(5L, 6L, 7L))
            )
        ),
        expected = matrix(
            data = c(
                 TRUE, FALSE, FALSE,
                 TRUE,  TRUE, FALSE,
                 TRUE,  TRUE, FALSE,
                FALSE,  TRUE, FALSE,
                FALSE, FALSE,  TRUE,
                FALSE, FALSE,  TRUE,
                FALSE, FALSE,  TRUE
            ),
            nrow = 7L,
            ncol = 3L,
            byrow = TRUE,
            dimnames = list(
                as.character(seq_len(7L)),
                letters[seq_len(3L)]
            )
        )
    )
})
