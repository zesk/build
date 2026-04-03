## `packageCheckFunction`

> Verify an installation afterwards.

### Usage

    packageCheckFunction handler installPath

Verify an installation afterwards.
If `checkFunction` fails, it should output any errors to `stderr` and return a non-zero exit code.

### Arguments

- `handler` - Function. Required. Function to call when an error occurs.
- `installPath` - Directory. Required. Path to the installPath home where target will be installed, or is installed. (e.g. myApp/bin/build)

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

