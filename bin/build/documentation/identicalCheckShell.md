### `identicalCheckShell`

> Identical check for shell files

#### Usage

    identicalCheckShell [ --help ] [ --singles singlesFiles ] [ --single singleToken ] [ --repair directory ] [ --internal-only ] [ --interactive ] [ ... ]

Identical check for shell files

Looks for up to three tokens in code:

- `# ``IDENTICAL tokenName 1`
- `# ``_IDENTICAL_ tokenName 1`, and
- `# ``DOC`` TEMPLATE: tokenName 1`

This allows for overlapping identical sections within templates with the intent:

- `IDENTICAL` - used in most cases (not internal)
- `_IDENTICAL_` - used in templates which must be included in IDENTICAL templates
- `__IDENTICAL__` - used in templates which must be included in _IDENTICAL_ templates
- `DOC`` TEMPLATE:` - used in documentation templates for functions - is handled by internal document generator

> Location: `bin/build/tools/identical.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.
- `--singles singlesFiles` - File. Optional. One or more files which contain a list of allowed `IDENTICAL` singles, one per line.
- `--single singleToken` - String. Optional. One or more tokens which cam be singles.
- `--repair directory` - Directory. Optional. Any files in onr or more directories can be used to repair other files.
- `--internal-only` - Flag. Optional. Just do `--internal` repairs.
- `--interactive` - Flag. Optional. Interactive mode on fixing errors.
- `...` - Arguments. Optional. Additional arguments are passed directly to `identicalCheck`.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

