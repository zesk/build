## `fileNotMatches`

> Find list of files which do NOT match a specific

### Usage

    fileNotMatches [ --help ] pattern ... -- [ exception ... ] -- file ...

Find list of files which do NOT match a specific pattern or patterns and output them

### Arguments

- `--help` - Flag. Optional. Display this help.
- `pattern ...` - String. Required.`grep -e` Pattern to find in files.
- `--` - Delimiter. Required. exception.
- `exception ...` - String. Optional. `grep -e` File pattern which should be ignored.
- `--` - Delimiter. Required. file.
- `file ...` - File. Required. File to search. Special file `-` indicates files should be read from `stdin`.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

