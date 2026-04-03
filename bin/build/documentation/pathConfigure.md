## `pathConfigure`

> Modify the PATH environment variable to add a path.

### Usage

    pathConfigure [ --help ] [ --first ] [ --last ] [ path ]

Modify the PATH environment variable to add a path.

### Arguments

- `--help` - Flag. Optional. Display this help.
- `--first` - Flag. Optional. Place any paths after this flag first in the list
- `--last` - Flag. Optional. Place any paths after this flag last in the list. Default.
- `path` - the path to be added to the `PATH` environment

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

