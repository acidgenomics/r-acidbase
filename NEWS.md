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
