test_that("pkgCacheDir", {
    dir <- pkgCacheDir(pkg = "AcidBase")
    expect_true(dir.exists(dir))
})
