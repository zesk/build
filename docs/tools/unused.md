# Unused functions

Hides these from [New and uncategorized functions](./todo.md)

### `exampleFunction` - This is a sample function with example code and patterns

This is a sample function with example code and patterns used in Zesk Build.

- Location: `bin/build/tools/example.sh`

#### Arguments

- `--help` - Optional. Flag. Display this help.
- `--easy` - Optional. Flag. Easy mode.
- `binary` - Required. String. The binary to look for.
- `remoteUrl` - Required. URL. Remote URL.
- `--target target` - Optional. File. File to create. File must exist.
- `--path path` - Optional. Directory. Directory of path of thing.
- `--title title` - Optional. String. Title of the thing.
- `--name name` - Optional. String. Name of the thing.
- `--url url` - Optional. URL. URL to download.
- `--callable callable` - Optional. Callable. Function to call when url is downloaded.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `runHookOptional` - undocumented

No documentation for `runHookOptional`.

- Location: `bin/build/tools/deprecated.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `runHook` - Not keeping this around will break old scripts, so don't

Not keeping this around will break old scripts, so don't be a ...

- Location: `bin/build/tools/deprecated.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `consoleNameValue` - Output a name value pair

Utility function which is similar to `usageGenerator` except it operates on a line at a time. The name is output
right-aligned to the `characterWidth` given and colored using `decorate label`; the value colored using `decorate value`.



- Location: `bin/build/tools/deprecated.sh`

#### Arguments

- `characterWidth` - Required. Number of characters to format the value for spacing
- `name` - Required. Name to output
- `value ...` - Optional. One or more Value to output

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
#### Arguments

- `--help` - Optional. Flag. Display this help.
- `environmentVariableName` - Optional. String. Map this value only. If not specified, all environment variables are mapped.
- `--prefix` - Optional. String. Prefix character for tokens, defaults to `{`.
- `--suffix` - Optional. String. Suffix character for tokens, defaults to `}`.
- `--search-filter` - Zero or more. Callable. Filter for search tokens. (e.g. `lowercase`)
- `--replace-filter` - Zero or more. Callable. Filter for replacement strings. (e.g. `trimSpace`)

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

Argument-passed or entire environment variables which are exported are used and mapped to the destination.
### `bashLintFilesInteractive` - Run checks interactively until errors are all fixed.

Run checks interactively until errors are all fixed.

- Location: `bin/build/tools/test.sh`

#### Arguments

- `--exec binary` - Optional. Callable. Run binary with files as an argument for any failed files. Only works if you pass in item names.
- `--delay delaySeconds` - Optional. Integer. Delay in seconds between checks in interactive mode.
- `fileToCheck ...` - Optional. File. Shell file to validate.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `_list` - Output a titled list

Output a titled list

- Location: `bin/build/tools/deprecated.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `_command` - Output a command, quoting individual arguments

Output a command, quoting individual arguments

- Location: `bin/build/tools/deprecated.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
#### Arguments

- `separator` - Optional. String.
- `prefix` - Optional. String.
- `suffix` - Optional. String.
- `title` - Optional. String.
- `item` - Optional. String. One or more items to list.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `joinArguments` - DEPRECATED 2025-02-04

DEPRECATED 2025-02-04

- Location: `bin/build/tools/deprecated.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `listTokens` - DEPRECATED 2025-02-04

DEPRECATED 2025-02-04

- Location: `bin/build/tools/deprecated.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
