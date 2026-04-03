## `directoryRelativePath`

> Given a path to a file, compute the path back

### Usage

    directoryRelativePath [ directory ]

Given a path to a file, compute the path back up to the top in reverse (../..)
If path is blank, outputs `.`.
Essentially converts the slash `/` to a `..`, so convert your source appropriately.
     directoryRelativePath "/" -> ".."
     directoryRelativePath "/a/b/c" -> ../../..

### Arguments

- `directory` - String. A path to convert.

### Writes to standard output

Relative paths, one per line

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

