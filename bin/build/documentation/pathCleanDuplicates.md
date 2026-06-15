### `pathCleanDuplicates`

> Cleans the path and removes non-directory entries and duplicates

#### Usage

    pathCleanDuplicates [ --help ]

Cleans the path and removes non-directory entries and duplicates

Maintains ordering.

> Location: `bin/build/tools/path.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

- [`PATH` Executable Search Path]({rel}env/#bash) – **DirectoryList**. A colon `:` separated list of paths to search for

