## AcidBase 0.3.1 (2021-01-06)

### Minor changes

- Now importing new AcidCLI package, to improve CLI messages.

## AcidBase 0.3.0 (2021-01-06)

### Major changes

- Reworked internal function organization a bit, handing off some functions
  back into the goalie package.
- Now that goalie doesn't depend on AcidBase, we can import and use the superior
  assert checks defined in the package.

## AcidBase 0.2.6 (2020-12-15)

### Minor changes

- `download`: Function now recursively creates destination file parent directory
  if necessary.
- `pasteURL`: Now defaulting to no protocol (e.g. "https") by default. This
  makes pasting of an existing URL with subdirectories easier.

## AcidBase 0.2.5 (2020-12-10)

### New functions

- Added `download`, which acts as a hardened wrapper for `utils::download.file`.
  Annoying, `download.file` returns status codes but does not intentionally
  error on any unsuccessful downloads. Our wrapper ensures that R always errors
  on any file download issue. It also sets a longer timeout internally, to
  avoid any potential issues with the `timeout` option being defined in
  `Rprofile`.

### Bug fixes

- `compress` and `decompress` were found to potentially generate integer
  overflow warnings on very large files, due to R using 32-bit integers.
  This issue has been resolving by ensuring the internal `nbytes` counter
  is set as `numeric` instead. See related
  [Stack Overflow post](https://stackoverflow.com/questions/8804779/) for
  details on integer overflows in R.
- `sem`: Requires `AsIs` class support, to work inside dplyr summarize calls.
- Now need to import BiocGenerics, for proper import of `AsIs` S4 class, which
  is an `oldClass` of the S3 class.

## AcidBase 0.2.4 (2020-11-24)

### New functions

- `sem`: Added support for standard error of the mean calculation.

## AcidBase 0.2.3 (2020-10-07)

- Fixed reference to AcidPlots package, renamed from previous "acidplots".

## AcidBase 0.2.2 (2020-10-07)

### New functions

- Migrated `headtail` atomic, matrix, and data.frame methods here from basejump.
  The methods that work on S4 objects, such as DataFrame, Matrix, GRanges,
  and SummarizedExperiment are still defined in basejump.
- `showSlotInfo`: Migrated from basejump, so we can use in AcidGenomes.

## AcidBase 0.2.1 (2020-10-06)

### New functions

- Added `forceDetach`, previously used internally inside basejump.
- Updated documentation to inherit from AcidRoxygen instead of acidroxygen.

## AcidBase 0.2.0 (2020-10-06)

### Major changes

- Renamed package from acidbase to AcidBase.

## acidbase 0.1.14 (2020-08-25)

### Minor changes

- Migrated some globals previously exported in basejump.
- Updated `formalsList` to consolidate params from basejump.

## acidbase 0.1.13 (2020-08-11)

### Minor changes

- Bug fix for `realpath` file path resolution using `..`.

## acidbase 0.1.12 (2020-08-09)

### Major changes

- Migrated `parseArgs` and `positionalArgs` out of package.

## acidbase 0.1.11 (2020-07-24)

### Minor changes

- Maintenance release, increasing minimum R dependency to 4.0.

## acidbase 0.1.10 (2020-07-07)

### Minor changes

- `formalsList`: Added `acid.import.make.names` global.

## acidbase 0.1.9 (2020-05-09)

### Minor changes

- `positionalArgs`: Function now intentionally errors when no positional
  arguments are defined.

## acidbase 0.1.8 (2020-05-05)

### Minor changes

- `shell`: The `args` argument has been changed to `""` by default so that
  only `command` argument is required as input.

## acidbase 0.1.7 (2020-04-09)

### New functions

- `majorVersion`, `minorVersion`, `sanitizeVersion`: Additional version utilites
  that help extraction major and minor release versions. `sanitizeVersion` helps
  strip extra characters at the end of version strings commonly found in the
  return of some shell commands (e.g. via `--version` command).
- `shell`: Wrapper for base `system2` function.

## acidbase 0.1.6 (2020-04-08)

### New functions

- `parseArgs` and `positionalArgs`: Migrated these functions previously defined
  inside [koopa][] shell bootloader package.
- `requireNamespaces`: Parameterized variant of `requireNamespace` that allows
  for easy loading of multiple package namespaces in a single call.

## acidbase 0.1.5 (2020-01-28)

### Minor changes

- Documentation fixes to pass CRAN release checks.
- Switched license from MIT to GPL-3.

## acidbase 0.1.4 (2020-01-19)

### New functions

- `compress`, `decompress`: Added dynamic file compression/decompression support
  for GZ, BZ2, XZ, and ZIP files. Inspired by approach used in R.utils
  `compressFile` and `decompressFile`.

### Minor changes

- `fileDepth`: Updated unit test to work reliably on macOS.

## acidbase 0.1.3 (2020-01-10)

### Minor changes

- `standardizeCall`: Removed extra unnecessary assert check.

## acidbase 0.1.2 (2019-12-05)

### New functions

- Added new `fileDepth` function.

## acidbase 0.1.1 (2019-10-22)

### Minor changes

- Migrated `realpath` from brio package. Reworked slightly to not depend on any
  assert checks from goalie package. Now this function essentially wraps
  `normalizePath` but provides a more informative error message.
- `basenameSansExt`: Minor tweak to ensure that files without an extension still
  return basename as expected.

## acidbase 0.1.0 (2019-10-21)

- Initial release.


[koopa]: https://koopa.acidgenomics.com/
