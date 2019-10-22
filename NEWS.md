## acidbase 0.1.1 (2019-10-22)

- Migrated `realpath` from brio package. Reworked slightly to not depend on any
  assert checks from goalie package. Now this function essentially wraps
  `normalizePath` but provides a more informative error message.

## acidbase 0.1.0 (2019-10-21)

- Initial release.