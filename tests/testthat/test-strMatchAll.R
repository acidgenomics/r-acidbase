test_that("WormBase peptides", {
    expect_identical(
        object = strMatchAll(
            x = c(
                paste(
                    "wormpep=CE32090",
                    "gene=WBGene00007063",
                    "status=Confirmed",
                    "uniprot=A4F336",
                    "insdc=CCD61130.1"
                ),
                paste(
                    "wormpep=CE32785",
                    "gene=WBGene00007064",
                    "locus=rga-9",
                    "status=Confirmed",
                    "uniprot=A4F337",
                    "insdc=CCD61138.1",
                    "product=\"Rho-GAP domain-containing protein\""
                ),
                NA
            ),
            pattern = "\\b([a-z]+)=(\"[^\"]+\"|[^ ]+\\b)"
        ),
        expected = list(
            matrix(
                data = c(
                    "wormpep=CE32090",
                    "wormpep",
                    "CE32090",
                    "gene=WBGene00007063",
                    "gene",
                    "WBGene00007063",
                    "status=Confirmed",
                    "status",
                    "Confirmed",
                    "uniprot=A4F336",
                    "uniprot",
                    "A4F336",
                    "insdc=CCD61130.1",
                    "insdc",
                    "CCD61130.1"
                ),
                nrow = 5L,
                ncol = 3L,
                byrow = TRUE
            ),
            matrix(
                data = c(
                    "wormpep=CE32785",
                    "wormpep",
                    "CE32785",
                    "gene=WBGene00007064",
                    "gene",
                    "WBGene00007064",
                    "locus=rga-9",
                    "locus",
                    "rga-9",
                    "status=Confirmed",
                    "status",
                    "Confirmed",
                    "uniprot=A4F337",
                    "uniprot",
                    "A4F337",
                    "insdc=CCD61138.1",
                    "insdc",
                    "CCD61138.1",
                    "product=\"Rho-GAP domain-containing protein\"",
                    "product",
                    "\"Rho-GAP domain-containing protein\""
                ),
                nrow = 7L,
                ncol = 3L,
                byrow = TRUE
            ),
            matrix(
                data = rep(NA_character_, 3L),
                nrow = 1L,
                ncol = 3L
            )
        )
    )
})

