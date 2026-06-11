### `networkNameValid`

> Is a network host name valid?

#### Usage

    networkNameValid [ --help ] [ name ]

Must be valid name containing alphabetic characters, dashes, or dots.
Dotted sections must be no longer than 63 characters; total name must be no longer than 253 characters.

> Location: `bin/build/tools/network.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.
- `name` - String. Network name to test for validity.

#### Reads standard input

line:String - Network names to test for validity.

#### Return codes

- `0` - All network names passed in are valid.
- `1` - One or more network names passed in are not valid

