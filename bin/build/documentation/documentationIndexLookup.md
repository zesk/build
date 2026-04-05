## `documentationIndexLookup`

> Looks up information in the function index

### Usage

    documentationIndexLookup [ --settings ] [ --comment ] [ --source ] [ --line ] [ --combined ] [ --file ] [ matchText ]

Looks up information in the function index
### Arguments

- `--settings` - Flag. Optional. `matchText` is a function name. Outputs a file name containing function settings
- `--comment` - Flag. Optional. `matchText` is a function name. Outputs a file name containing function settings
- `--source` - Flag. Optional. `matchText` is a function name. Outputs the source code path to where the function is defined
- `--line` - Flag. Optional. `matchText` is a function name. Outputs the source code line where the function is defined
- `--combined` - Flag. Optional. `matchText` is a function name. Outputs the source code path and line where the function is defined as `path:line`
- `--file` - Flag. Optional. `matchText` is a file name. Find files which match this base file name.
- `matchText` - String. Token to look up in the index.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

