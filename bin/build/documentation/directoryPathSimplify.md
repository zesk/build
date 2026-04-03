## `directoryPathSimplify`

> Normalizes segments of `/./` and `/../` in a path without

### Usage

    directoryPathSimplify path ...

Normalizes segments of `/./` and `/../` in a path without using `fileRealPath`
Removes dot and dot-dot paths from a path correctly

### Arguments

- `path ...` - File. Required. One or more paths to simplify

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

