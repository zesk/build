## `reloadChanges`

> Watch or more directories for changes in a file extension

### Usage

    reloadChanges --source source [ --name name ] --path path --file file [ --stop ] [ --show ] [ source ] [ path|file ... ] [ --help ]

Watch or more directories for changes in a file extension and reload a source file if any changes occur.

### Arguments

- `--source source` - File. Required. Source file to source upon change.
- `--name name` - String. Optional. The name to call this when changes occur.
- `--path path` - Directory. Required. OneOrMore. A directory to scan for changes in `.sh` files
- `--file file` - File. Required. OneOrMore. A file to watch.å
- `--stop` - Flag. Optional. Stop watching changes and remove all watches.
- `--show` - Flag. Optional. Show watched settings and exit.
- `source` - File. Optional. If supplied directly on the command line, sets the source.
- path|- `file ...` - DirectoryOrFile. Optional. If `source` supplied, then any other command line argument is treated as a path to scan for changes.
- `--help` - Flag. Optional. Display this help.

### Debugging settings

Append to the value of `BUILD_DEBUG` (a comma-delimited (`,`) list) and add these tokens to enable debugging:

- `reloadChanges` - prompt module will show debugging information
- `reloadChangesProfile` - prompt module will show profiling information

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

