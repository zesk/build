## `textCannon`

> Replace text `fromText` with `toText` in files

### Usage

    textCannon [ --help ] [ --handler handler ] [ --path cannonPath ] fromText toText [ findArgs ... ]

Replace text `fromText` with `toText` in files, using `findArgs` to filter files if needed.
This can break your files so use with caution. Blank `searchText` is **not allowed**.
The term `textCannon` is not a mistake - it will break something at some point.

### Arguments

- `--help` - Flag. Optional. Display this help.
- `--handler handler` - Function. Optional. Use this error handler instead of the default error handler.
- `--path cannonPath` - Directory. Optional. Run textCannon operation starting in this directory.
- `fromText` - Required. String of text to search for.
- `toText` - Required. String of text to replace.
- `findArgs ...` - Arguments. Optional. Any additional arguments are meant to filter files.

### Examples

    textCannon master main ! -path '*/old-version/*')

### Return codes

- `0` - Success, no files changed
- `3` - At least one or more files were modified successfully
- `1` - --path is not a directory
- `1` - searchText is not blank
- `1` - `fileTemporaryName` failed
- `2` - Arguments are identical

