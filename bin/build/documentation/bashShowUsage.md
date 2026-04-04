## `bashShowUsage`

> Show function handler in files

### Usage

    bashShowUsage functionName file [ --help ]

Show function handler in files
This check is simplistic and does not verify actual coverage or code paths.

### Arguments

- `functionName` - String. Required. Function which should be called somewhere within a file.
- `file` - File. Required. File to search for function handler.
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - Function is used within the file
- `1` - Function is *not* used within the file

