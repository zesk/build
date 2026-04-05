## `bashLibraryHome`

> Output the home for a library in the parent path

### Usage

    bashLibraryHome libraryRelativePath [ startDirectory ] [ --help ]

This function searches for a library located at the current path and searches upwards until it is found.
A simple example is `bin/build/tools.sh` for this library which will generally give you an application root if this library
is properly installed. You can use this for any application to find a library's home directory.
Note that the `libraryRelativePath` given must be both executable and a file.

### Arguments

- `libraryRelativePath` - RelativeFile. Required. Path of file to find from the home directory. Must also be executable.
- `startDirectory` - Directory. Optional. Place to start searching. Uses `pwd` if not specified.
- `--help` - Flag. Optional. Display this help.

### Writes to standard output

Parent path where `libraryRelativePath` exists

### Examples

    libFound=$(bashLibraryHome "bin/watcher/server.py")

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

