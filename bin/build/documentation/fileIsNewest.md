## `fileIsNewest`

> Check to see if the first file is the newest

### Usage

    fileIsNewest sourceFile [ targetFile ... ] [ --help ]

Check to see if the first file is the newest one
If `sourceFile` is modified AFTER ALL `targetFile`s, return `0``
Otherwise return `1``

### Arguments

- `sourceFile` - File. Required. File to check
- `targetFile ...` - File. Optional. One or more files to compare. All must exist.
- `--help` - Flag. Optional. Display this help.

### Return codes

- `1` - `sourceFile`, 'targetFile' does not exist, or
- `0` - All files exist and `sourceFile` is the oldest file

