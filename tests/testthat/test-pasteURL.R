test_that("HTTPS", {
    expect_identical(
        object = pasteURL(
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
        object = pasteURL(
            "ftp.ensembl.org",
            "pub",
            "release-94",
            "gtf",
            "homo_sapiens",
            "Homo_sapiens.GRCh38.94.gtf.gz",
            protocol = "ftp"
        ),
        expected = paste(
            "ftp://ftp.ensembl.org/pub/release-94/gtf/homo_sapiens",
            "Homo_sapiens.GRCh38.94.gtf.gz",
            sep = "/"
        )
    )
})

test_that("Character vector input", {
    expect_identical(
        object = pasteURL(
            c("ftp.ncbi.nlm.nih.gov", "genomes"),
            protocol = "ftp"
        ),
        expected = "ftp://ftp.ncbi.nlm.nih.gov/genomes"
    )
})

test_that("Encoding support", {
    expect_identical(
        object = pasteURL(
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
        object = pasteURL(
            "ftp.ncbi.nlm.nih.gov", "genomes/",
            protocol = "ftp"
        ),
        expected = "ftp://ftp.ncbi.nlm.nih.gov/genomes/"
    )
    expect_identical(
        object = pasteURL(
            "ftp.ncbi.nlm.nih.gov", "genomes", "/",
            protocol = "ftp"
        ),
        expected = "ftp://ftp.ncbi.nlm.nih.gov/genomes/"
    )
    expect_identical(
        object = pasteURL(
            "ftp.ncbi.nlm.nih.gov", "genomes//",
            protocol = "ftp"
        ),
        expected = "ftp://ftp.ncbi.nlm.nih.gov/genomes//"
    )
})

test_that("Error if empty", {
    expect_error(
        object = pasteURL(),
        regexp = "Nothing to paste."
    )
})

test_that("Error if not URL", {
    expect_error(
        object = pasteURL("bioconductor.org", protocol = "none"),
        regexp = "isAURL"
    )
})

test_that("Error on recycling", {
    expect_error(
        object = pasteURL(
            "bioconductor.org", c("aaa", "bbb"),
            protocol = "https"
        ),
        regexp = "Recycling"
    )
})

test_that("Error on NA", {
    expect_error(
        pasteURL(
            "ftp.ncbi.nlm.nih.gov", "genomes", NA_character_,
            protocol = "ftp"
        ),
        regexp = "character strings"
    )
    expect_error(
        pasteURL(
            c("ftp.ncbi.nlm.nih.gov", "genomes", NA_character_),
            protocol = "ftp"
        ),
        regexp = "isCharacter"
    )
})
