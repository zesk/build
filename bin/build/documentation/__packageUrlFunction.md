## `packageUrlFunction`

> Prints the remote URL for a package, or exits non-zero

### Usage

    packageUrlFunction handler

Prints the remote URL for a package, or exits non-zero on error.
Takes a single argument, the error handler, a function.

### Arguments

- `handler` - Function. Required. Function to call when an error occurs.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

