### `hookSource`

> Run a project hook

#### Usage

    hookSource [ --application applicationHome ] [ --extensions extensionList ] hookName ...

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
- `hookName ...` - String. Required. Hook to source.

#### Debugging settings

Append to the value of `BUILD_DEBUG` (a comma-delimited (`,`) list) and add these tokens to enable debugging:

- `hook` - `hookRun` and `hookSource` and optional versions of the same functions will output additional debugging information

#### Examples

    version="$(hookSource version-current)"

#### Return codes

- `Any` - The hook exit code is returned if it is run
- `1` - is returned if the hook is not found

#### Environment

- [`BUILD_HOOK_EXTENSIONS` Build Hook Extension List]({rel}env/#application) – **ColonDelimitedList**. List of extensions to run when looking for hooks [`BUILD_HOOK_DIRS` Build Hook Directory List]({rel}env/#build_configuration) – **ApplicationDirectoryList**. List of directories to search for hooks. Defaults to `bin/hooks:bin/build/hooks`. [`BUILD_DEBUG` Debugging Flag]({rel}env/#build_configuration) – **CommaDelimitedList**. Constant for turning debugging on during build to find errors

#### See Also

- [hookExists]({rel}tools/hook.md#hookexists) - Determine if a hook exists ([source](https://github.com/zesk/build/blob/main/bin/build/tools/hook.sh#L230))
- [hookRun]({rel}tools/hook.md#hookrun) - Run a project hook ([source](https://github.com/zesk/build/blob/main/bin/build/tools/hook.sh#L128))
- [hookRunOptional]({rel}tools/hook.md#hookrunoptional) - Optionally run a project hook ([source](https://github.com/zesk/build/blob/main/bin/build/tools/hook.sh#L154))
- [hookSourceOptional]({rel}tools/hook.md#hooksourceoptional) - Identical to \`hookRun\` but returns exit code zero if the ([source](https://github.com/zesk/build/blob/main/bin/build/tools/hook.sh#L209))

