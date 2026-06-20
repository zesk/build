### `fileRealPath`

> Find the full, actual path of a file avoiding symlinks

#### Usage

    fileRealPath file ...

Find the full, actual path of a file avoiding symlinks or redirection.
Without arguments, displays help.

> Location: `bin/build/tools/file.sh`

#### Arguments

- `file ...` - File. Required. One or more files to `realpath`.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Requires

- [executableExists]({rel}tools/bash.md#executableexists) - Does a binary exist in the PATH? ([source](https://github.com/zesk/build/blob/main/bin/build/tools/platform.sh#L174))
- [`realpath`]({rel}guide/command.md#realpath)
- {SEE:helpArgument}
- [bashDocumentation]({rel}tools/documentation.md#bashdocumentation) - Universal function documentation ([source](https://github.com/zesk/build/blob/main/bin/build/tools/usage.sh#L59))
- {SEE:returnArgument}

#### See Also

- [`readlink`]({rel}guide/command.md#readlink)
- [`realpath`]({rel}guide/command.md#realpath)

