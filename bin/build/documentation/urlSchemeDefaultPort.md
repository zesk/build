## `urlSchemeDefaultPort`

> Output the port for the given scheme

### Usage

    urlSchemeDefaultPort [ --help ] [ --handler handler ] scheme ...

Output the port for the given scheme

### Arguments

- `--help` - Flag. Optional. Display this help.
- `--handler handler` - Function. Optional. Use this error handler instead of the default error handler.
- `scheme ...` - String. Required. Scheme to look up the default port used for that scheme.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

