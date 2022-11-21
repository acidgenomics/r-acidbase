# Release notes

## AcidBase 0.6.9 (2022-11-21)

New functions:

- `euclidean`: Calculate Euclidean distance of two numeric vectors.
- `zscore`: Calculate Z score for an input numeric vector or matrix. Note that
  matrix method defaults to row-wise scaling, defined by `MARGIN` argument.
  This convention is intended to match recommended R defaults, and also to
  work as expected with sample (columns) x gene (rows) matrix, commonly used
  for gene expression in `SummarizedExperiment` class objects.

## AcidBase 0.6.8 (2022-10-20)

New functions:

- `truncateString`: Simple utility function that smartly adds ellipsis (`...`)
  when necessary to a long character string. Don't want to export this as
  `truncate`, which is defined in base R for connections.

Minor changes:

- `shell`: Improved interactive printing and error message handling. The
  function now attempts to automatically handle `~` character, when defined
  at the beginning of an argument.

## AcidBase 0.6.7 (2022-09-06)

Minor changes:

- `shell`: Added support for `env`, which allows for environment variable
  definition inside the child process. Refer to `processx::run` and `system2`
  for details.

## AcidBase 0.6.6 (2022-08-24)

Minor changes:

- `requireNamespaces`: Made error message regarding `NAMESPACE` more
  informative. Now indicates that user needs to install a missing package.
- Miscellaneous documentation updates, based on roxygen2 changes.

## AcidBase 0.6.5 (2022-06-08)

Minor changes:

- `unlink2`: Added assert check to ensure files and/or directories are
  successfully deleted. Calls `file.exists` internally, which checks both
  files and directories.

## AcidBase 0.6.4 (2022-06-02)

New functions:

- `tempdir2`: Temporary directory generator that improves upon base R
  `tempdir` conventions, ensuring that a new unique directory is created
  per call.
- `unlink2`: Hardened variant of `unlink` that provides better file system
  compatibility with Windows. Function will intentionally error if file or
  directory does not exist on disk.

## AcidBase 0.6.3 (2022-05-31)

Minor changes:

- Improved internal consistency of `normalizePath` calls, using platform
  `fsep` for `winslash`, similar to conventions used in `realpath`. This helps
  improve consistency of messages and file path output on Windows.
- Fixed unit test compatibility on Windows.

## AcidBase 0.6.2 (2022-05-20)

Minor changes:

- Updated package to use testthat 3e and updated lintr checks.
- `fileExt`: Added `pattern` formal, which lets us override compressed file
  handling in other packages.
- `compress`: Improved handling of ZIP files, to no longer rely on internal
  `setwd` call. Now using `withr::with_dir` temporary approach instead.
- `compress` and `decompress`: Reformatted internal code to pass lintr checks.
- `forceDetach`: Simplify internal code using a for loop.
- Now using `Map` internally instead of `mapply`.

## AcidBase 0.6.1 (2022-05-02)

New functions:

- Migrated `gitCurrentBranch` and `gitDefaultBranch` from r-koopa here.

Minor changes:

- `shell`: Added `returnStdout` argument, which helps parse stdout.
- `fileExt`: Added option to override default `extPattern` match.

## AcidBase 0.6.0 (2022-04-29)

Major changes:

- Updated minimum R dependency version to 4.2
- Reduced the number of strong dependencies, migrating AcidCLI, stats, and
  utils to `Suggests` from `Imports`.

Minor changes:

- Improved formatting consistency using styler package.

## AcidBase 0.5.0 (2022-03-11)

Minor changes:

- Ordered S4 method exports alphabetically by class, where applicable.
- `compress` / `decompress`: Simplified default formals and documentation.
  User can no longer set `remove` or `overwrite` globally with
  `"acid.compress.remove"` or `"acid.overwrite"`, respectively.
- Removed `formalsList` from NAMESPACE, in favor of a reworked approach
  across packages that previously inherited these values (in development).
- `printString`: Improved and cleaned up documentation.
- Updated working examples to use `DataFrame` object instead of `DFrame`,
  where applicable. This requires an update to AcidTest package.
- `compress`: Bug fix for ZIP file compression handling outside of working
  directory. Incorrectly used `basename` argument internally. Unfortunately
  need to change the working directory internally to get this working correctly.

## AcidBase 0.4.5 (2021-09-08)

Minor changes:

- Cleaned up the NAMESPACE a bit, removing some deprecated functions:
  `metadataBlacklist` (in favor of `metadataDenylist`) and `bapply`, which
  should only be defined in goalie package.
- Reexporting `tar` from untils package alongside `untar`, for consistency.

## AcidBase 0.4.4 (2021-09-03)

Minor changes:

- `parentDirectory`: Added support for handling URLs.

## AcidBase 0.4.3 (2021-08-23)

New functions:

- `collapseToPathString`: Previously used internally, now exporting so we can
  use in koopa dependency package.

## AcidBase 0.4.2 (2021-08-19)

New functions:

- `parentDirectory` (`parentDir`): Allows for each return of nested parent
  directories, similar to approach used in koopa shell package (`parent_dir`).

Minor changes:

- `realpath`: Now keeps track of names,  if defined.

## AcidBase 0.4.1 (2021-08-18)

Minor changes:

- `shell` Added some more useful options for subprocess handling and logging:
  `wd`, `stdoutFile`, `stderrFile`, as well as `stderrToStdout`.

## AcidBase 0.4.0 (2021-08-18)

New functions:

- Added new system path modifier functions, based on code previously defined in
  koopa shell package: `addToPathStart`, `addToPathEnd`, `removeFromPath`.
- Also added some useful path string parsing functions: `splitPathString` and
  `uniquePathString`.

Major changes:

- `shell`: Reworked internal code to handoff to `processx::run` instead of using
  `base::system2`. Simplified console output handling using a single `print`
  argument.

## AcidBase 0.3.16 (2021-08-13)

Minor changes:

- Reworked package to use AcidCLI for improved error messages, which are now
  called via `abort` instead of `stop` internally.

## AcidBase 0.3.15 (2021-08-04)

New functions:

- `simpleClass`: Added utility function for simple class checks, primarily
  intended for unit testing with testthat package.

## AcidBase 0.3.14 (2021-06-20)

Minor changes:

- `standardizeCall`: Updated handling of dots handoff to `match.call` in R 4.1.
- Now importing `median` and `quantile` functions from AcidGenerics, which use
  S4 defined in IRanges, rather than the base version defined in stats.

## AcidBase 0.3.13 (2021-03-02)

Minor changes:

- Including `data` and `median` as reexports.

## AcidBase 0.3.12 (2021-03-01)

Minor changes:

- Added `install.packages` as a reexport, which is used by r-koopa.
- Also including `head` and `tail` as reexports.

## AcidBase 0.3.11 (2021-02-25)

Minor changes:

- Deprecating `metadataBlacklist` in favor of `metadataDenylist`.

## AcidBase 0.3.10 (2021-02-23)

Minor changes:

- Migrated `printString` back here from goalie package.
- `showHeader` now checks for `packageVersion` inside of metadata as default
  instead of `version`.

## AcidBase 0.3.9 (2021-02-21)

Minor changes:

- Reexporting `URLencode` from utils, which is used downstream in Cellosaurus
  package.

## AcidBase 0.3.8 (2021-02-17)

Minor changes:

- Including `formula` and `untar` as reexports, which are used in the
  WormBase package.

## AcidBase 0.3.7 (2021-02-12)

Minor changes:

- Including `download.file` as a reexport from utils.

## AcidBase 0.3.6 (2021-02-11)

Minor changes:

- Now reexporting all functions used in other Acid Genomics packages defined in
  base/recommended R packages here, including: grDevices, grid, methods,
  and stats, utils.

## AcidBase 0.3.5 (2021-02-04)

Major changes:

- Migrated `geometricMean` and `sem` methods from basejump.
- Migrated `showHeader` from basejump.
- Migrated `coerceToList` from basejump.
- Migrated log ratio functions from basejump.
- Migrated intersection functions from basejump.

Minor changes:

- Made `matchArgsToDoCall` function defunct. Doesn't always evaluate arguments
  correctly when called inside nested functions or complex S4 stacks.

## AcidBase 0.3.4 (2021-01-28)

New functions:

- Added `classContains` utility function.

## AcidBase 0.3.3 (2021-01-21)

Minor changes:

- `pasteURL`: Added support for rsync as a protocol. Using this in future
  update in AcidGenomes package for downloading from UCSC server.

## AcidBase 0.3.2 (2021-01-15)

Minor changes:

- Removed `sampleId` from `metadataBlacklist` global.
- `pasteURL` now supports "s3" as a protocol value.

## AcidBase 0.3.1 (2021-01-06)

Minor changes:

- Now importing new AcidCLI package, to improve CLI messages.

## AcidBase 0.3.0 (2021-01-06)

Major changes:

- Reworked internal function organization a bit, handing off some functions
  back into the goalie package.
- Now that goalie doesn't depend on AcidBase, we can import and use the superior
  assert checks defined in the package.

## AcidBase 0.2.6 (2020-12-15)

Minor changes:

- `download`: Function now recursively creates destination file parent directory
  if necessary.
- `pasteURL`: Now defaulting to no protocol (e.g. "https") by default. This
  makes pasting of an existing URL with subdirectories easier.

## AcidBase 0.2.5 (2020-12-10)

New functions:

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

New functions:

- `sem`: Added support for standard error of the mean calculation.

## AcidBase 0.2.3 (2020-10-07)

- Fixed reference to AcidPlots package, renamed from previous "acidplots".

## AcidBase 0.2.2 (2020-10-07)

New functions:

- Migrated `headtail` atomic, matrix, and data.frame methods here from basejump.
  The methods that work on S4 objects, such as DataFrame, Matrix, GRanges,
  and SummarizedExperiment are still defined in basejump.
- `showSlotInfo`: Migrated from basejump, so we can use in AcidGenomes.

## AcidBase 0.2.1 (2020-10-06)

New functions:

- Added `forceDetach`, previously used internally inside basejump.
- Updated documentation to inherit from AcidRoxygen instead of acidroxygen.

## AcidBase 0.2.0 (2020-10-06)

Major changes:

- Renamed package from acidbase to AcidBase.

## acidbase 0.1.14 (2020-08-25)

Minor changes:

- Migrated some globals previously exported in basejump.
- Updated `formalsList` to consolidate params from basejump.

## acidbase 0.1.13 (2020-08-11)

Minor changes:

- Bug fix for `realpath` file path resolution using `..`.

## acidbase 0.1.12 (2020-08-09)

Major changes:

- Migrated `parseArgs` and `positionalArgs` out of package.

## acidbase 0.1.11 (2020-07-24)

Minor changes:

- Maintenance release, increasing minimum R dependency to 4.0.

## acidbase 0.1.10 (2020-07-07)

Minor changes:

- `formalsList`: Added `acid.import.make.names` global.

## acidbase 0.1.9 (2020-05-09)

Minor changes:

- `positionalArgs`: Function now intentionally errors when no positional
  arguments are defined.

## acidbase 0.1.8 (2020-05-05)

Minor changes:

- `shell`: The `args` argument has been changed to `""` by default so that
  only `command` argument is required as input.

## acidbase 0.1.7 (2020-04-09)

New functions:

- `majorVersion`, `minorVersion`, `sanitizeVersion`: Additional version utilites
  that help extraction major and minor release versions. `sanitizeVersion` helps
  strip extra characters at the end of version strings commonly found in the
  return of some shell commands (e.g. via `--version` command).
- `shell`: Wrapper for base `system2` function.

## acidbase 0.1.6 (2020-04-08)

New functions:

- `parseArgs` and `positionalArgs`: Migrated these functions previously defined
  inside [koopa][] shell bootloader package.
- `requireNamespaces`: Parameterized variant of `requireNamespace` that allows
  for easy loading of multiple package namespaces in a single call.

## acidbase 0.1.5 (2020-01-28)

Minor changes:

- Documentation fixes to pass CRAN release checks.
- Switched license from MIT to GPL-3.

## acidbase 0.1.4 (2020-01-19)

New functions:

- `compress`, `decompress`: Added dynamic file compression/decompression support
  for GZ, BZ2, XZ, and ZIP files. Inspired by approach used in R.utils
  `compressFile` and `decompressFile`.

Minor changes:

- `fileDepth`: Updated unit test to work reliably on macOS.

## acidbase 0.1.3 (2020-01-10)

Minor changes:

- `standardizeCall`: Removed extra unnecessary assert check.

## acidbase 0.1.2 (2019-12-05)

New functions:

- Added new `fileDepth` function.

## acidbase 0.1.1 (2019-10-22)

Minor changes:

- Migrated `realpath` from brio package. Reworked slightly to not depend on any
  assert checks from goalie package. Now this function essentially wraps
  `normalizePath` but provides a more informative error message.
- `basenameSansExt`: Minor tweak to ensure that files without an extension still
  return basename as expected.

## acidbase 0.1.0 (2019-10-21)

- Initial release.

[koopa]: https://koopa.acidgenomics.com/
