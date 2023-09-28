test_that("cacheDir", {
    dir <- cacheDir("AcidBase")
    expect_true(dir.exists(dir))
})
