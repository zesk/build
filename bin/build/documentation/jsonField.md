### `jsonField`

> Fetch a non-blank field from a JSON file with error

#### Usage

    jsonField [ --help ] handler jsonFile [ ... ]

Fetch a non-blank field from a JSON file with error handling

> Location: `bin/build/tools/json.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.
- `handler` - Function. Required. Error handler.
- `jsonFile` - File. Required. A JSON file to parse
- `...` - Arguments. Optional. Passed directly to jq

#### Writes to standard output

selected field

#### Writes to standard error

error messages

#### Return codes

- `0` - Field was found and was non-blank
- `1` - Field was not found or is blank

#### Requires

- [`jq`]({rel}guide/command.md#jq)
- [executableExists]({rel}tools/bash.md#executableexists) - Does a binary exist in the PATH? ([source](https://github.com/zesk/build/blob/main/bin/build/tools/platform.sh#L174))
- {SEE:throwEnvironment}
- [`printf`]({rel}guide/builtin.md#printf)
- [`rm`]({rel}guide/command.md#rm)
- [decorate]({rel}tools/decorate.md#decorate) - decorate text using colors and styles ([source](https://github.com/zesk/build/blob/main/bin/build/tools/decorate/core.sh#L144))
- [`head`]({rel}guide/command.md#head)

