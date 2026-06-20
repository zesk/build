### `documentationFunctionsSeeDirty`

> Dirty documentation files with unresolved `SEE:` tokens in documentation path

#### Usage

    documentationFunctionsSeeDirty [ --help ] path

Changes the modification date of the associated files such that it will be regenerated with `documentationFunctionsCompile`.

> Location: `bin/build/tools/documentation.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.
- `path` - Directory. Required. The documentation path to examine.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### See Also

- [documentationFunctionsCompile]({rel}tools/documentation.md#documentationfunctionscompile) - Extract and build the documentation settings cache and generate derived ([source](https://github.com/zesk/build/blob/main/bin/build/tools/documentation.sh#L475))

