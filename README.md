# acidbase

[![Repo status: active](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Travis CI build status](https://travis-ci.com/acidgenomics/acidbase.svg?branch=master)](https://travis-ci.com/acidgenomics/acidbase)
[![AppVeyor CI build status](https://ci.appveyor.com/api/projects/status/s6ckyym8ivwobybj/branch/master?svg=true)](https://ci.appveyor.com/project/mjsteinbaugh/acidbase/branch/master)

Low-level base functions imported by [Acid Genomics][] packages.

## Installation

This is an [R][] package.

### [R][] method

```r
if (!requireNamespace("remotes", quietly = TRUE)) {
    install.packages("remotes")
}
Sys.setenv(R_REMOTES_UPGRADE = "always")
## Set `GITHUB_PAT` in `~/.Renviron` if you get a rate limit error.
remotes::install_github("acidgenomics/acidbase")
remotes::update_packages()
```

[acid genomics]: https://acidgenomics.com/
[r]: https://www.r-project.org/
