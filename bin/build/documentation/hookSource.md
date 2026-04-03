## `hookSource`

> Run a project hook

### Usage

    hookSource [ --application applicationHome ] [ --extensions extensionList ] hookName ...

Run a hook in the project located at `./bin/hooks/`
See (Hooks documentation)[../hooks/index.md] for standard hooks.
Hooks provide an easy way to customize your build. Hooks are binary files located in your project directory at `./bin/hooks/` and are named `hookName` with a `.sh` extension added.
So the hook for `version-current` would be a file at:
    bin/hooks/version-current.sh
Sample hooks (scripts) can be found in the build source code at `./bin/hooks/`.
Default hooks (scripts) can be found in the current build version at `bin/build/hooks/`

### Arguments

- `--application applicationHome` - Path. Optional. Directory of alternate application home.
- `--extensions extensionList` - ColonDelimitedList. Optional. List of extensions to search, in order for matching files in each hook directory. Defaults to `BUILD_HOOK_EXTENSIONS`.
- `hookName ...` - String. Required. Hook to source.

### Debugging settings

Append to the value of `BUILD_DEBUG` (a comma-delimited (`,`) list) and add these tokens to enable debugging:

- `hook` - `hookRun` and `hookSource` and optional versions of the same functions will output additional debugging information

### Examples

    version="$(hookSource version-current)"

### Return codes

- `Any` - The hook exit code is returned if it is run
- `1` - is returned if the hook is not found

### Environment

- {SEE:BUILD_HOOK_EXTENSIONS.sh} {SEE:BUILD_HOOK_DIRS.sh} {SEE:BUILD_DEBUG.sh}

