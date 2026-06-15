### `hookRunOptional`

> Identical to `hookRun` but returns exit code zero if the

#### Usage

    hookRunOptional [ --next scriptName ] [ --application applicationHome ] [ --extensions extensionList ] hookName [ ... ] [ --help ]

Identical to `hookRun` but returns exit code zero if the hook does not exist.

> Location: `bin/build/tools/hook.sh`

#### Arguments

- `--next scriptName` - File. Optional. Run the script found *after* the named script, if any. Allows easy chaining of scripts.
- `--application applicationHome` - Path. Optional. Directory of alternate application home.
- `--extensions extensionList` - ColonDelimitedList. Optional. List of extensions to search, in order for matching files in each hook directory. Defaults to `BUILD_HOOK_EXTENSIONS`.
- `hookName` - String. Required. Hook name to run.
- `...` - Arguments. Optional. Any arguments to the hook. See each hook implementation for details.
- `--help` - Flag. Optional. Display this help.

#### Debugging settings

Append to the value of `BUILD_DEBUG` (a comma-delimited (`,`) list) and add these tokens to enable debugging:

- `hook` - `hookRun` and `hookSource` and optional versions of the same functions will output additional debugging information

#### Examples

    version="$(hookRunOptional version-current)"

#### Return codes

- `Any` - The hook exit code is returned if it is run
- `1` - is returned if the hook is not found

#### Environment

- [`BUILD_HOOK_EXTENSIONS` Build Hook Extension List]({rel}env/#application) – **ColonDelimitedList**. List of extensions to run when looking for hooks
- [`BUILD_HOOK_DIRS` Build Hook Directory List]({rel}env/#build_configuration) – **ApplicationDirectoryList**. List of directories to search for hooks. Defaults to `bin/hooks:bin/build/hooks`.

#### See Also

- {SEE:hooks.md}
- [hookRunOptional]({rel}tools/hook.md#hookrunoptional) - Identical to \`hookRun\` but returns exit code zero if the ([source](https://github.com/zesk/build/blob/main/bin/build/tools/hook.sh#L154))
- [hookRun]({rel}tools/hook.md#hookrun) - Run a project hook ([source](https://github.com/zesk/build/blob/main/bin/build/tools/hook.sh#L128))

