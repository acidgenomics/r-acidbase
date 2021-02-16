# AcidBase

[![Install with Bioconda](https://img.shields.io/badge/install%20with-bioconda-brightgreen.svg?style=flat)](http://bioconda.github.io/recipes/r-acidbase/README.html)

Low-level base functions imported by [Acid Genomics][] packages.

## Installation

This is an [R][] package.

### [R][] method

```r
install.packages(
    pkgs = "AcidBase",
    repos = c(
        "https://r.acidgenomics.com",
        getOption("repos")
    )
)
```

### [Conda][] method

Configure [Conda][] to use the [Bioconda][] channels.

```sh
# Don't install recipe into base environment.
name="r-acidbase"
conda create --name="$name" "$name"
conda activate "$name"
R
```

### [Docker][] method

```sh
image="acidgenomics/r-acidbase"
workdir="/mnt/work"
docker pull "$image"
docker run -it \
    --volume="${PWD}:${workdir}" \
    --workdir="$workdir" \
    "$image" \
    R
```

[acid genomics]: https://acidgenomics.com/
[conda]: https://conda.io/
[docker]: https://www.docker.com/
[r]: https://www.r-project.org/
