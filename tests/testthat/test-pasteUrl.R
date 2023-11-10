test_that("HTTPS", {
    expect_identical(
        object = pasteUrl(
            "r.acidgenomics.com",
            "packages",
            "acidbase",
            protocol = "https"
        ),
        expected = "https://r.acidgenomics.com/packages/acidbase"
    )
})

test_that("FTP", {
    expect_identical(
        object = pasteUrl(
            "ftp.ensembl.org",
            "pub",
            "release-94",
            "gtf",
            "homo_sapiens",
            "Homo_sapiens.GRCh38.94.gtf.gz",
            protocol = "ftp"
        ),
        ## nolint start
        expected = paste(
            "ftp://ftp.ensembl.org",
            "pub",
            "release-94",
            "gtf",
            "homo_sapiens",
            "Homo_sapiens.GRCh38.94.gtf.gz",
            sep = "/"
        )
        ## nolint end
    )
})

test_that("Character vector input", {
    expect_identical(
        object = pasteUrl(
            c("ftp.ncbi.nlm.nih.gov", "genomes"),
            protocol = "ftp"
        ),
        expected = "ftp://ftp.ncbi.nlm.nih.gov/genomes"
    )
})

test_that("Encoding support", {
    expect_identical(
        object = pasteUrl(
            "rest.ensembl.org",
            "info",
            "assembly",
            "Homo sapiens",
            protocol = "https"
        ),
        expected = "https://rest.ensembl.org/info/assembly/Homo%20sapiens"
    )
})

test_that("Trailing slashes", {
    expect_identical(
        object = pasteUrl(
            "ftp.ncbi.nlm.nih.gov", "genomes/",
            protocol = "ftp"
        ),
        expected = "ftp://ftp.ncbi.nlm.nih.gov/genomes/"
    )
    expect_identical(
        object = pasteUrl(
            "ftp.ncbi.nlm.nih.gov", "genomes", "/",
            protocol = "ftp"
        ),
        expected = "ftp://ftp.ncbi.nlm.nih.gov/genomes/"
    )
    expect_identical(
        object = pasteUrl(
            "ftp.ncbi.nlm.nih.gov", "genomes//",
            protocol = "ftp"
        ),
        expected = "ftp://ftp.ncbi.nlm.nih.gov/genomes//"
    )
})

test_that("Error if empty", {
    expect_error(
        object = pasteUrl(),
        regexp = "Nothing to paste."
    )
})

test_that("Error if not URL", {
    expect_error(
        object = pasteUrl("bioconductor.org", protocol = "none"),
        regexp = "isAUrl"
    )
})

test_that("Error on recycling", {
    expect_error(
        object = pasteUrl(
            "bioconductor.org", c("aaa", "bbb"),
            protocol = "https"
        ),
        regexp = "Recycling"
    )
})

test_that("Error on NA", {
    expect_error(
        pasteUrl(
            "ftp.ncbi.nlm.nih.gov", "genomes", NA_character_,
            protocol = "ftp"
        ),
        regexp = "character strings"
    )
    expect_error(
        pasteUrl(
            c("ftp.ncbi.nlm.nih.gov", "genomes", NA_character_),
            protocol = "ftp"
        ),
        regexp = "isCharacter"
    )
})
