### `json`

> JSON pretty

#### Usage

    json [ --help ]

Format something neatly as JSON

> Location: `bin/build/tools/json.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.

#### Reads standard input

JSONFile

#### Writes to standard output

JSONFile pretty formatted

#### Examples

    json < inputFile > outputFile

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

