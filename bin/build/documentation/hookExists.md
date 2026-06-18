### `hookExists`

> Determine if a hook exists

#### Usage

    hookExists [ --application applicationHome ] [ --extensions extensionList ] [ --next scriptName ] [ hookName0 ]

Does a hook exist in the local project?

Check if one or more hook exists. All hooks must exist to succeed.

> Location: `bin/build/tools/hook.sh`

#### Arguments

- `--application applicationHome` - Path. Optional. Directory of alternate application home. Can be specified more than once to change state.
- `--extensions extensionList` - ColonDelimitedList. Optional. List of extensions to search, in order for matching files in each hook directory. Defaults to `BUILD_HOOK_EXTENSIONS`.
- `--next scriptName` - File. Optional. Locate the script found *after* the named script, if any. Allows easy chaining of scripts.
- `hookName0` - one or more hook names which must exist

#### Return codes

- `0` - If all hooks exist

#### Environment

- [`BUILD_HOOK_EXTENSIONS` Build Hook Extension List]({rel}env/#application) – **ColonDelimitedList**. List of extensions to run when looking for hooks [`BUILD_HOOK_DIRS` Build Hook Directory List]({rel}env/#build_configuration) – **ApplicationDirectoryList**. List of directories to search for hooks. Defaults to `bin/hooks:bin/build/hooks`. [`BUILD_DEBUG` Debugging Flag]({rel}env/#build_configuration) – **CommaDelimitedList**. Constant for turning debugging on during build to find errors

#### See Also

- [hookRun]({rel}tools/hook.md#hookrun) - Run a project hook ([source](https://github.com/zesk/build/blob/main/bin/build/tools/hook.sh#L128))
- [hookRunOptional]({rel}tools/hook.md#hookrunoptional) - Optionally run a project hook ([source](https://github.com/zesk/build/blob/main/bin/build/tools/hook.sh#L154))
- [hookSource]({rel}tools/hook.md#hooksource) - Run a project hook ([source](https://github.com/zesk/build/blob/main/bin/build/tools/hook.sh#L186))
- [hookSourceOptional]({rel}tools/hook.md#hooksourceoptional) - Identical to \`hookRun\` but returns exit code zero if the ([source](https://github.com/zesk/build/blob/main/bin/build/tools/hook.sh#L209))

