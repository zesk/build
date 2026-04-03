## `fileMatches`

> Find one or more patterns in a list of files,

### Usage

    fileMatches [ --help ] pattern ... -- [ exception ... ] -- file ...

Find one or more patterns in a list of files, with a list of file name pattern exceptions.

### Arguments

- `--help` - Flag. Optional. Display this help.
- `pattern ...` - String. Required.`grep -e` Pattern to find in files. No quoting is added so ensure these are compatible with `grep -e`.
- `--` - Delimiter. Required. exception.
- `exception ...` - String. Optional. `grep -e` File pattern which should be ignored.
- `--` - Delimiter. Required. file.
- `file ...` - File. Required. File to search. Special file `-` indicates files should be read from `stdin`.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

