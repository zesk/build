# Bash Functions

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

### `bashSanitize` - Sanitize bash files for code quality.

Sanitize bash files for code quality.

Placing a `.debugging` file in your project with a list of permitted files which contain debugging (`set -x`)

- Location: `bin/build/tools/bash.sh`

#### Arguments

- `--help` - Optional. Flag. Display this help.
- `--` - Flag. Optional. Interactive mode on fixing errors.
- `--home home` - Optional. Directory. Sanitize files starting here. (Defaults to `buildHome`)
- `--interactive` - Flag. Optional. Interactive mode on fixing errors.
- `--check checkDirectory` - Optional. Directory. Check shell scripts in this directory for common errors.
- `...` - Additional arguments are passed to `validateShellScripts` `validateFileContents`

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
