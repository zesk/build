## `awsCredentialsFile`

> Get the path to the AWS credentials file

### Usage

    awsCredentialsFile [ --help ] [ --verbose ] [ --create ] [ --home homeDirectory ]

Get the credentials file path, optionally outputting errors
Pass a true-ish value to output warnings to stderr on failure
Pass any value to output warnings if the environment or file is not found; otherwise
output the credentials file path.
If not found, returns with exit code 1.

### Arguments

- `--help` - Flag. Optional. Display this help.
- `--verbose` - Flag. Optional. Verbose mode
- `--create` - Flag. Optional. Create the directory and file if it does not exist
- `--home homeDirectory` - Directory. Optional. Home directory to use instead of `$HOME`.

### Examples

    credentials=$(awsCredentialsFile) || throwEnvironment "$handler" "No credentials file found" || return $?

### Return codes

- `1` - If `$HOME` is not a directory or credentials file does not exist
- `0` - If credentials file is found and output to stdout

