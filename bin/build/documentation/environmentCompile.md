## `environmentCompile`

> Load an environment file and evaluate it using bash and

### Usage

    environmentCompile [ --underscore ] [ --secure ] [ --keep-comments ] [ --variables ] [ --parse ] environmentFile

Load an environment file and evaluate it using bash and output the changed environment variables after running
Do not perform this operation on files which are untrusted.

### Arguments

- `--underscore` - Flag. Optional. Include environment variables which begin with underscore `_`.
- `--secure` - Flag. Optional. Include environment variables which are in `environmentSecureVariables`
- `--keep-comments` - Flag. Keep all comments in the source
- `--variables` - CommaDelimitedList. Optional. Always output the value of these variables.
- `--parse` - Flag. Optional. Parse the file for things which look like variables to output (basically `^foo=`)
- `environmentFile` - File. Required. Environment file to load, evaluate, and output in raw form (Bash-compatible).

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

