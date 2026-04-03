## `hookSourceOptional`

> Identical to `hookRun` but returns exit code zero if the

### Usage

    hookSourceOptional [ --application applicationHome ] [ --extensions extensionList ] hookName ...

Identical to `hookRun` but returns exit code zero if the hook does not exist.

### Arguments

- `--application applicationHome` - Path. Optional. Directory of alternate application home.
- `--extensions extensionList` - ColonDelimitedList. Optional. List of extensions to search, in order for matching files in each hook directory. Defaults to `BUILD_HOOK_EXTENSIONS`.
- `hookName ...` - String. Required. Hook to source (if it exists).

### Debugging settings

Append to the value of `BUILD_DEBUG` (a comma-delimited (`,`) list) and add these tokens to enable debugging:

- `hook` - `hookRun` and `hookSource` and optional versions of the same functions will output additional debugging information

### Examples

    hookSourceOptional test-cleanup

### Return codes

- `Any` - The hook exit code is returned if it is run
- `0` - is returned if the hook is not found

### Environment

- {SEE:BUILD_HOOK_EXTENSIONS.sh}
- {SEE:BUILD_HOOK_DIRS.sh}
- {SEE:BUILD_DEBUG.sh}

