## `hookExists`

> Determine if a hook exists

### Usage

    hookExists [ --application applicationHome ] [ --extensions extensionList ] [ --next scriptName ] [ hookName0 ]

Does a hook exist in the local project?
Check if one or more hook exists. All hooks must exist to succeed.

### Arguments

- `--application applicationHome` - Path. Optional. Directory of alternate application home. Can be specified more than once to change state.
- `--extensions extensionList` - ColonDelimitedList. Optional. List of extensions to search, in order for matching files in each hook directory. Defaults to `BUILD_HOOK_EXTENSIONS`.
- `--next scriptName` - File. Optional. Locate the script found *after* the named script, if any. Allows easy chaining of scripts.
- `hookName0` - one or more hook names which must exist

### Return codes

- `0` - If all hooks exist

### Environment

- {SEE:BUILD_HOOK_EXTENSIONS.sh} {SEE:BUILD_HOOK_DIRS.sh} {SEE:BUILD_DEBUG.sh}

