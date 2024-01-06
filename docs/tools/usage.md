# Usage Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)


### `usageDocument` - Generates console usage output for a script using documentation tools

Generates console usage output for a script using documentation tools parsed from the comment of the function identified.

Simplifies documentation and has it in one place for shell and online.

#### Usage

    usageDocument functionDefinitionFile functionName exitCode [ ... ]

#### Arguments

- `functionDefinitionFile` - Required. The file in which the function is defined. If you don't know, use `bashFindFunctionFiles` or `bashFindFunctionFile`.
- `functionName` - Required. The function which actually defines our usage syntax. Documentation is extracted from this function, regardless.

#### Exit codes

- `0` - Always succeeds

### `usageArguments` - usageArguments delimiter

usageArguments delimiter

#### Exit codes

- `0` - Always succeeds

### `usageGenerator` - Formats name value pairs separated by separatorChar (default " ")

Formats name value pairs separated by separatorChar (default " ") and uses
$nSpaces width for first field

usageGenerator nSpaces separatorChar labelPrefix valuePrefix < formatFile

use with maximumFieldLength 1 to generate widths

#### Arguments

- `nSpaces` - Required. Integer. Number of spaces to indent arguments.
- `separatorChar` - Optional. String. Default is space.
- `labelPrefix` - Optional. String. Defaults to blue color text.
- `valuePrefix` - Optional. String. Defaults to red color text.

#### Exit codes

- `0` - Always succeeds

### `usageRequireBinary` - Check that one or more binaries are installed

Requires the binaries to be found via `which`

Runs `usageFunction` on failure

#### Arguments

- `usageFunction` - Required. `bash` function already defined to output usage
- `binary0` - Required. Binary which must have a `which` path.

#### Exit codes

- `0` - Always succeeds

### `usageRequireEnvironment` - Requires environment variables to be set and non-blank

Requires environment variables to be set and non-blank

#### Arguments

- `usageFunction` - Required. `bash` function already defined to output usage
- `env0` - Optional. String. One or more environment variables which should be set and non-empty.

#### Exit codes

- `0` - Always succeeds

### `usageTemplate` - Output usage messages to console

Output usage messages to console

Should look into an actual file template, probably

#### Usage

    usageTemplate binName options delimiter description exitCode message

#### Exit codes

- `0` - Always succeeds

#### See Also

usageDocument

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
