# Usage Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)


### `usageDocument` - Generates console usage output for a script using documentation tools

Generates console usage output for a script using documentation tools parsed from the comment of the function identified.

Simplifies documentation and has it in one place for shell and online.

#### Usage

    usageDocument functionDefinitionFile functionName exitCode [ ... ]
    

#### Arguments

- `functionDefinitionFile` - Required. The file in which the function is defined. If you don't know, use `bashDocumentation_FindFunctionDefinitions` or `bashDocumentation_FindFunctionDefinition`.
- `functionName` - Required. The function which actually defines our usage syntax. Documentation is extracted from this function, regardless.

#### Examples

    _documentationTemplateCompileUsage "$errorEnvironment" "Something is awry"

#### Exit codes

- `0` - Always succeeds

#### Usage

    usageArguments delimiter
    

#### Arguments

- `delimiter` - Required. String. The character to separate name value pairs in the input

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

- [function usageDocument
](./docs/tools/usage.md
) - [Generates console usage output for a script using documentation tools
](https://github.com/zesk/build/blob/main/bin/build/tools/documentation.sh
#L30
)


### `usageArgumentFileDirectory` - Validates a value is not blank and is a path

Validates a value is not blank and is a path with a directory that exists
Upon success, outputs the file name

#### Arguments

- `usageFunction` - Required. Function. Run if usage fails
- `variableName` - Required. String. Name of variable being tested
- `variableValue` - Required. String. Required only in that if it's blank, it fails.
- `noun` - Optional. String. Noun used to describe the argument in errors, defaults to `file`

#### Exit codes

- `2` - Argument error
- `0` - Success

### `usageArgumentFile` - Validates a value is not blank and is a file

Validates a value is not blank and is a file
Upon success, outputs the file name

#### Arguments

- `usageFunction` - Required. Function. Run if usage fails
- `variableName` - Required. String. Name of variable being tested
- `variableValue` - Required. String. Required only in that if it's blank, it fails.
- `noun` - Optional. String. Noun used to describe the argument in errors, defaults to `file`

#### Exit codes

- `2` - Argument error
- `0` - Success

### `usageArgumentDirectory` - Validates a value is not blank and is a directory

Validates a value is not blank and is a directory
Upon success, outputs the directory name trailing slash stripped

#### Arguments

- `usageFunction` - Required. Function. Run if usage fails
- `variableName` - Required. String. Name of variable being tested
- `variableValue` - Required. String. Required only in that if it's blank, it fails.
- `noun` - Optional. String. Noun used to describe the argument in errors, defaults to `directory`

#### Exit codes

- `2` - Argument error
- `0` - Success

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
