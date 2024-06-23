# Usage Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)


### `usageDocument` - Generates console usage output for a script using documentation tools

Generates console usage output for a script using documentation tools parsed from the comment of the function identified.

Simplifies documentation and has it in one place for shell and online.

#### Usage

    usageDocument functionDefinitionFile functionName exitCode [ ... ]
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

#### Usage

    usageArguments delimiter
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

### `usageGenerator` - Formats name value pairs separated by separatorChar (default " ")

Formats name value pairs separated by separatorChar (default " ") and uses
$nSpaces width for first field

usageGenerator nSpaces separatorChar labelPrefix valuePrefix < formatFile

use with maximumFieldLength 1 to generate widths

#### Arguments



#### Exit codes

- `0` - Always succeeds

### `usageRequireBinary` - Check that one or more binaries are installed

Requires the binaries to be found via `which`

Runs `usageFunction` on failure

#### Usage

    usageRequireBinary usageFunction binary0 [ ... ]
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

### `usageRequireEnvironment` - Requires environment variables to be set and non-blank

Requires environment variables to be set and non-blank

#### Usage

    usageRequireEnvironment usageFunction [ env0 ... ]
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

### `usageTemplate` - Output usage messages to console

Output usage messages to console

Should look into an actual file template, probably

#### Usage

    usageTemplate binName options delimiter description exitCode message ...
    

#### Exit codes

- `0` - Always succeeds

#### See Also

{SEE:usageDocument}


### `usageArgumentFileDirectory` - Validates a value is not blank and is a file

Validates a value is not blank and is a file path with a directory that exists. Upon success, outputs the file name.

#### Usage

    usageArgumentFileDirectory usageFunction variableName variableValue [ noun ]
    

#### Arguments



#### Exit codes

- `2` - Argument error
- `0` - Success

### `usageArgumentFile` - Validates a value is not blank and is a file.

Validates a value is not blank and is a file.
Upon success, outputs the file name

#### Usage

    usageArgumentFile usageFunction variableName variableValue [ noun ]
    

#### Arguments



#### Exit codes

- `2` - Argument error
- `0` - Success

### `usageArgumentInteger` - Validates a value is an integer

Validates a value is an integer

#### Usage

    usageArgumentInteger usageFunction variableName variableValue [ noun ]
    

#### Arguments



#### Exit codes

- `2` - Argument error
- `0` - Success

### `usageArgumentLoadEnvironmentFile` - Validates a value is not blank and is an environment

Validates a value is not blank and is an environment file which is loaded immediately.

Upon success, outputs the file name to stdout, outputs a console message to stderr

#### Usage

    usageArgumentLoadEnvironmentFile processPid usageFunction variableName variableValue [ noun ]
    

#### Arguments



#### Exit codes

- `2` - Argument error
- `0` - Success

### `usageArgumentUnsignedInteger` - Validates a value is an unsigned integer

Validates a value is an unsigned integer

#### Usage

    usageArgumentUnsignedInteger usageFunction variableName variableValue [ noun ]
    

#### Arguments



#### Exit codes

- `2` - Argument error
- `0` - Success

### `usageArgumentDirectory` - Validates a value is not blank and is a directory.

Validates a value is not blank and is a directory. Upon success, outputs the directory name trailing slash stripped.

#### Usage

    usageArgumentDirectory usageFunction variableName variableValue [ noun ]
    

#### Arguments



#### Exit codes

- `2` - Argument error
- `0` - Success

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
