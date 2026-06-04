### `dotFilesApproved`

> Lists of dot files which can be added to the

#### Usage

    dotFilesApproved [ listType ]

Lists of dot files which can be added to the dotFilesApprovedFile
If none specified, returns `bash` list.
Special value `all` returns all values

> Location: `bin/build/tools/prompt-modules.sh`

#### Arguments

- `listType` - String. Optional. One of `all`, `bash`, `git`, `darwin`, or `mysql`

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

