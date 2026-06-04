### `hookRun`

> Run a project hook

#### Usage

    hookRun [ --application applicationHome ] [ --extensions extensionList ] [ --next scriptName ] hookName [ ... ] [ --help ]

Run a hook in the project located at `./bin/hooks/`

See (Hooks documentation)[../hooks/index.md] for standard hooks.

Hooks provide an easy way to customize your build. Hooks are binary files located in your project directory at `./bin/hooks/` and are named `hookName` with a `.sh` extension added.
So the hook for `version-current` would be a file at:

    bin/hooks/version-current.sh

Sample hooks (scripts) can be found in the build source code at `./bin/hooks/`.

Default hooks (scripts) can be found in the current build version at `bin/build/hooks/`

> Location: `bin/build/tools/hook.sh`

#### Arguments

- `--application applicationHome` - Path. Optional. Directory of alternate application home.
- `--extensions extensionList` - ColonDelimitedList. Optional. List of extensions to search, in order for matching files in each hook directory. Defaults to `BUILD_HOOK_EXTENSIONS`.
- `--next scriptName` - File. Optional. Run the script found *after* the named script, if any. Allows easy chaining of scripts.
- `hookName` - String. Required. Hook name to run.
- `...` - Arguments. Optional. Any arguments to the hook. See each hook implementation for details.
- `--help` - Flag. Optional. Display this help.

#### Debugging settings

Append to the value of `BUILD_DEBUG` (a comma-delimited (`,`) list) and add these tokens to enable debugging:

- `hook` - `hookRun` and `hookSource` and optional versions of the same functions will output additional debugging information

#### Examples

    version="$(hookRun version-current)"

#### Return codes

- `Any` - The hook exit code is returned if it is run
- `1` - is returned if the hook is not found

#### Environment

- [`BUILD_HOOK_EXTENSIONS` Build Hook Extension List]({rel}/env/#application) – **ColonDelimitedList**. List of extensions to run when looking for hooks [`BUILD_HOOK_DIRS` Build Hook Directory List]({rel}/env/#build_configuration) – **ApplicationDirectoryList**. List of directories to search for hooks. Defaults to `bin/hooks:bin/build/hooks`. [`BUILD_DEBUG` Debugging Flag]({rel}/env/#build_configuration) – **CommaDelimitedList**. Constant for turning debugging on during build to find errors

#### See Also

- {SEE:hooks.md}
- [hookRunOptional]({rel}tools/hook.md#hookrunoptional) - Identical to \`hookRun\` but returns exit code zero if the ([source](https://github.com/zesk/build/blob/main/bin/build/tools/hook.sh#L154))[hookRun]({rel}tools/hook.md#hookrun) - Run a project hook ([source](https://github.com/zesk/build/blob/main/bin/build/tools/hook.sh#L128))[hookSource]({rel}tools/hook.md#hooksource) - Run a project hook ([source](https://github.com/zesk/build/blob/main/bin/build/tools/hook.sh#L186))[hookSourceOptional]({rel}tools/hook.md#hooksourceoptional) - Identical to \`hookRun\` but returns exit code zero if the ([source](https://github.com/zesk/build/blob/main/bin/build/tools/hook.sh#L209))

