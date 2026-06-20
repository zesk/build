### `manPathConfigure`

> Modify the MANPATH environment variable to add a path.

#### Usage

    manPathConfigure [ --help ] [ --first ] [ --last ] [ path ]

Modify the MANPATH environment variable to add a path.

> Location: `bin/build/tools/manpath.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.
- `--first` - Flag. Optional. Place any paths after this flag first in the list
- `--last` - Flag. Optional. Place any paths after this flag last in the list. Default.
- `path` - the path to be added to the `MANPATH` environment

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

- [`MANPATH` Manual Pages Path]({rel}env/#bash) – **DirectoryList**. A colon `:` separated list of paths to search for

#### See Also

- [manPathRemove]({rel}tools/manpath.md#manpathremove) - Remove a path from the MANPATH environment variable ([source](https://github.com/zesk/build/blob/main/bin/build/tools/manpath.sh#L37))

