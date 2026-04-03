## `environmentFileLoad`

> Safely load an environment file (no code execution)

### Usage

    environmentFileLoad [ --prefix ] --require [ --optional ] [ --verbose ] environmentFile [ --ignore environmentName ] [ --secure environmentName ] [ --secure-defaults ] [ --execute arguments ... ] [ --help ]

Safely load an environment file (no code execution)

### Arguments

- `--prefix` - EnvironmentVariable|Blank. Optional. All subsequent environment variables are prefixed with this prefix.
- `--require` - Flag. Optional. All subsequent environment files on the command line will be required.
- `--optional` - Flag. Optional. All subsequent environment files on the command line will be optional. (If they do not exist, no errors.)
- `--verbose` - Flag. Optional. Output errors with variables in files.
- `environmentFile` - Required. Environment file to load. For `--optional` files the directory must exist.
- `--ignore environmentName` - String. Optional. Environment value to ignore on load.
- `--secure environmentName` - String. Optional. If found in a loaded file, entire file fails.
- `--secure-defaults` - Flag. Optional. Add a list of environment variables considered security risks to the `--ignore` list.
- `--execute arguments ...` - Callable. Optional. All additional arguments are passed to callable after loading environment files.
- `--help` - Flag. Optional. Display this help.

### Return codes

- `2` - if file does not exist; outputs an error
- `0` - if files are loaded successfully

