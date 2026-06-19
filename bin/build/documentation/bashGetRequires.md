### `bashGetRequires`

> Fetch requirements lines from a bash file

#### Usage

    bashGetRequires script

Gets a list of the `Requires:` comments in a bash file.
Returns a unique list of tokens

> Location: `bin/build/tools/bash.sh`

#### Arguments

- `script` - File. Required. Bash script to fetch requires tokens from.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

