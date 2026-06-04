### `bashDocumentationAllEnvironment`

> Generate markdown for a list of all functions

#### Usage

    bashDocumentationAllEnvironment [ --help ]

Uses list of functions passed in `stdin`; using the `SEE` template.
Output to `allEnvironmentList.md` typically.

> Location: `bin/build/tools/documentation.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.

#### Reads standard input

EnvironmentVariable. One per line.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

