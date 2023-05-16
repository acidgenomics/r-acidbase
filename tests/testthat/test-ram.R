test_that("ram", {
    for (type in eval(formals(ram)[["type"]])) {
        expect_type(
            object = ram(type = type),
            type = "double"
        )
    }
})
