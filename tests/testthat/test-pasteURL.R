test_that("HTTPS", {
    expect_identical(
        object = pasteURL(
            "steinbaugh.com",
            "basejump",
            "reference",
            protocol = "https"
        ),
        expected = "https://steinbaugh.com/basejump/reference"
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

test_that("No recycling", {
    expect_error(
        object = pasteURL(
            "bioconductor.org", c("aaa", "bbb"),
            protocol = "https"
        ),
        regexp = "Recycling"
    )
})
