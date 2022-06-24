# AcidBase

Low-level base functions imported by [Acid Genomics][] packages.

## Installation

This is an [R][] package.

```r
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}
install.packages(
    pkgs = "AcidBase",
    repos = c(
        "https://r.acidgenomics.com",
        BiocManager::repositories()
    ),
    dependencies = TRUE
)
```

[acid genomics]: https://acidgenomics.com/
[r]: https://www.r-project.org/
