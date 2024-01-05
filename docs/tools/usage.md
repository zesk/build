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

#### Exit codes

- `0` - Always succeeds

### `usageRequireBinary` - Check that one or more binaries are installed

Requires the binaries to be found via `which`

Runs `usageFunction` on failure

#### Usage

    usageRequireBinary usage usageFunction binary0 [ ... ]

#### Exit codes

- `0` - Always succeeds
Unable to find "usageRequireEnvironment" (from "./docs/_templates/tools/usage.md") in "./bin/build/"
Unable to find "usageMain" (from "./docs/_templates/tools/usage.md") in "./bin/build/"

### `usageTemplate` - Output usage messages to console

Output usage messages to console

Should look into an actual file template, probably

#### Usage

    usageTemplate binName options delimiter description exitCode message

#### Exit codes

- `0` - Always succeeds

#### See Also

usageDocument

#### Errors

Unable to find "usageMain" (from "./docs/_templates/tools/usage.md") in "./bin/build/"

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
