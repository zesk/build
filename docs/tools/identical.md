# Identical Functions

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

### `identicalRepair` - Repair an identical `token` in `destination` from `source`

Repair an identical `token` in `destination` from `source`

- Location: `bin/build/tools/identical/repair.sh`

#### Arguments

- `--prefix prefix` - Required. A text prefix to search for to identify identical sections (e.g. `# IDENICAL`) (may specify more than one)
- `token` - String. Required. The token to repair.
- `source` - Required. File. The token file source. First occurrence is used.
- `destination` - Required. File. The token file to repair. Can be same as `source`.
- `--stdout` - Optional. Flag. Output changed file to `stdout`

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `identicalCheck` - When, for whatever reason, you need code to match between

When, for whatever reason, you need code to match between files, add a comment in the form:

    # IDENTICAL tokenName n

Where `tokenName` is unique to your project, `n` is the number of lines to match. All found sets of lines in this form
must match each other set of lines with the same prefix, otherwise errors and details about failures are printed to stdout.

The command to then check would be:

    identicalCheck --extension sh --prefix '# IDENTICAL'

This is largely useful for projects in which specific functions are replicated between scripts for code independence, yet
should remain identical.

Mapping also automatically handles file names and paths, so `__FILE__` maps to path to a file relative to the project root.

Failures are considered:

- Partial success, but warnings occurred with an invalid number in a file
- Two code instances with the same token were found which were not identical
- Two code instances with the same token were found which have different line counts

This is best used as a pre-commit check, for example. Wink!

- Location: `bin/build/tools/identical/check.sh`

#### Arguments

- `--extension extension` - Required. String. One or more extensions to search for in the current directory.
- `--prefix prefix` - Required. String. A text prefix to search for to identify identical sections (e.g. `# IDENTICAL`) (may specify more than one)
- `--exclude pattern` - Optional. String. One or more patterns of paths to exclude. Similar to pattern used in `find`.
- `--cd directory` - Optional. Directory. Change to this directory before running. Defaults to current directory.
- `--repair directory` - Optional. Directory. Any files in onr or more directories can be used to repair other files.
- `--ignore-singles` - Optional. Flag. Skip the check to see if single entries exist.
- `--no-map` - Optional. Flag. Do not map __BASE__, __FILE__, __DIR__ tokens.
- `--help` - Optional. Flag. This help.

#### Exit codes

- `2` - Argument error
- `0` - Success, everything matches
- `100` - Failures
### `identicalCheckShell` - Identical check for shell files

Identical check for shell files

- Location: `bin/build/tools/identical/check.sh`

#### Arguments

- `--singles singlesFiles` - Optional. File. One or more files which contain a list of allowed `IDENTICAL` singles, one per line.
- `--single singleToken` - Optional. String. One or more tokens which cam be singles.
- `--repair directory` - Optional. Directory. Any files in onr or more directories can be used to repair other files.
- `--help` - Flag. Optional. I need somebody.
- `--interactive` - Flag. Optional. Interactive mode on fixing errors.
- `...` - Optional. Additional arguments are passed directly to `identicalCheck`.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
