## `bashLibrary`

> Run or source a library

### Usage

    bashLibrary libraryRelativePath [ command ] [ --help ]

Run or source one or more bash scripts and load any defined functions into the current context.
Has security implications - only load trusted code sources and prevent user injection of bash source code into your applications.

### Arguments

- `libraryRelativePath` - Path. Required. Path to library source file.
- `command` - Callable. Optional. Command to run after loading the library.
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

