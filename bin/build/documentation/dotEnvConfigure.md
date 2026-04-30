## `dotEnvConfigure`

> Load `.env` and optional `.env.local` into bash context

### Usage

    dotEnvConfigure [ where ] [ --help ]

Loads `.env` which is the current project configuration file
Also loads `.env.local` if it exists
Generally speaking - these are NAME=value files and should be parsable by
bash and other languages.
Requires the file `.env` to exist and is loaded via bash `source` and all variables are `export`ed in the current shell context.
If `.env.local` exists, it is also loaded in a similar manner.
Use with caution on trusted content only.

### Arguments

- `where` - Directory. Optional. Where to load the `.env` files.
- `--help` - Flag. Optional. Display this help.

### Return codes

- `1` - if `.env` does not exist; outputs an error
- `0` - if files are loaded successfully

