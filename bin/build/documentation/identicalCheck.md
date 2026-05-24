## `identicalCheck`

> When, for whatever reason, you need code to match between

### Usage

    identicalCheck --extension extension --prefix prefix [ --exclude pattern ] [ --cd directory ] [ --repair directory ] [ --skip file ] [ --ignore-singles ] [ --no-map ] [ --debug ] [ --help ] [ --singles singlesFiles ] [ --single singleToken ] [ --token token ] [ token ... ]

When, for whatever reason, you need code to match between files, add a comment in the form:

    # IDENTICAL tokenName n

Where `tokenName` is unique to your project, `n` is the number of lines to match. All found sets of lines in this form
must match each other set of lines with the same prefix, otherwise errors and details about failures are printed to stdout.

The command to then check would be:

    identicalCheck --extension sh --prefix '# IDENTICAL'

This is largely useful for projects in which specific functions are replicated between scripts for code independence, yet
should remain identical.

Mapping also automatically handles file names and paths, so using the token `__FILE__` within your identical source
will convert to the target file's application path:

- `__FULL__` - Full path to file
- `__EXTENSION__` - The file extension (`sh`)
- `__BASE__` - Just file name and extension
- `__FILE__` - The application file
- `__NAME__` - Just the file name without extension
- `__DIRECTORY__` - Application directory (also `__DIR__`)

Failures are considered:

- Partial success, but warnings occurred with an invalid number in a file
- Two code instances with the same token were found which were not identical
- Two code instances with the same token were found which have different line counts

This is best used as a pre-commit check, for example.

> Location: `bin/build/tools/identical.sh`

### Arguments

- `--extension extension` - String. Required. One or more extensions to search for in the current directory.
- `--prefix prefix` - String. Required. A text prefix to search for to identify identical sections (e.g. `# IDENTICAL`) (may specify more than one)
- `--exclude pattern` - String. Optional. One or more patterns of paths to exclude. Similar to pattern used in `find`.
- `--cd directory` - Directory. Optional. Change to this directory before running. Defaults to current directory.
- `--repair directory` - Directory. Optional. Any files in onr or more directories can be used to repair other files.
- `--skip file` - Directory. Optional. Ignore this file for repairs.
- `--ignore-singles` - Flag. Optional. Skip the check to see if single entries exist.
- `--no-map` - Flag. Optional. Do not map __FULL__, __EXTENSION__, __BASE__, __FILE__, __NAME__, __DIR__, __DIRECTORY__  tokens.
- `--debug` - Flag. Optional. Additional debugging information is output.
- `--help` - Flag. Optional. This help.
- `--singles singlesFiles` - File. Optional. One or more files which contain a list of allowed `IDENTICAL` singles, one per line.
- `--single singleToken` - String. Optional. One or more tokens which cam be singles.
- `--token token` - String. Optional. Replace this token (only). May be specified more than once. Old method, deprecated but here for compatibility.
- `token ...` - String. Optional. Replace this token (only). May be specified more than once.

### Debugging settings

Append to the value of `BUILD_DEBUG` (a comma-delimited (`,`) list) and add these tokens to enable debugging:

- `identical-compare` - Show verbose comparisons when things differ between identical sections

### Return codes

- `2` - Argument error
- `0` - Success, everything matches
- `100` - Failures

### See Also

- {SEE:identicalWatch}

