## `hookFind`

> Find the path to a hook binary file

### Usage

    hookFind [ --application applicationHome ] [ --extensions extensionList ] [ --next scriptName ] hookName0 [ hookName1 ]

Does a hook exist in the local project?
Find the path to a hook. The search path is:
- `./bin/hooks/`
- `./bin/build/hooks/`
If a file named `hookName` with the extension `.sh` is found which is executable, it is output.

### Arguments

- `--application applicationHome` - Path. Optional. Directory of alternate application home. Can be specified more than once to change state.
- `--extensions extensionList` - ColonDelimitedList. Optional. List of extensions to search, in order for matching files in each hook directory. Defaults to `BUILD_HOOK_EXTENSIONS`.
- `--next scriptName` - File. Optional. Locate the script found *after* the named script, if any. Allows easy chaining of scripts.
- `hookName0` - String. Required. Hook to locate
- `hookName1` - String. Optional. Additional hooks to locate.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- {SEE:BUILD_HOOK_EXTENSIONS.sh} {SEE:BUILD_HOOK_DIRS.sh} {SEE:BUILD_DEBUG.sh}

