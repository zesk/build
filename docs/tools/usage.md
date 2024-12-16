# Usage Functions

The concept of a "usage" function is one that fails, and displays a reasonable error to the user or controlling program.

Essentially a `usage` function is a failure handler. If you need a simple `usage` function use `_return`.

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

## Usage formatting

### `usageDocument` - Universal error handler for functions

Generates console usage output for a script using documentation tools parsed from the comment of the function identified.

Simplifies documentation and keeps it with the code.

- Location: `bin/build/tools/documentation.sh`

#### Usage

    usageDocument functionDefinitionFile functionName exitCode [ message ... ]
    

#### Arguments

- `functionDefinitionFile` - Required. File. The file in which the function is defined. If you don't know, use `bashDocumentation_FindFunctionDefinitions` or `bashDocumentation_FindFunctionDefinition`.
- `functionName` - Required. String. The function which actually defines our usage syntax. Documentation is extracted from this function, regardless.
- `exitCode` - Required. Integer. The function which actually defines our usage syntax. Documentation is extracted from this function, regardless.
- `message` - Optional. String. A message.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
#### Usage

    usageArguments delimiter
    

#### Arguments

- `delimiter` - Required. String. The character to separate name value pairs in the input

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `usageGenerator` - Formats name value pairs separated by separatorChar (default " ")

Formats name value pairs separated by separatorChar (default " ") and uses
$nSpaces width for first field

usageGenerator nSpaces separatorChar labelPrefix valuePrefix < formatFile

use with maximumFieldLength 1 to generate widths

- Location: `bin/build/tools/usage.sh`

#### Arguments

- `nSpaces` - Required. Integer. Number of spaces to indent arguments.
- `separatorChar` - Optional. String. Default is space.
- `labelPrefix` - Optional. String. Defaults to blue color text.
- `valuePrefix` - Optional. String. Defaults to red color text.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `usageTemplate` - Output usage messages to console

Output usage messages to console

Should look into an actual file template, probably

Do not call usage functions here to avoid recursion

- Location: `bin/build/tools/usage.sh`

#### Usage

    usageTemplate binName options delimiter description exitCode message ...
    

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## Environment

### `usageRequireBinary` - Check that one or more binaries are installed

Requires the binaries to be found via `which`

Runs `usage` on failure

- Location: `bin/build/tools/usage.sh`

#### Arguments

- `usageFunction` - Required. `bash` function already defined to output usage
- `binary0` - Required. Binary which must have a `which` path.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `usageRequireEnvironment` - Requires environment variables to be set and non-blank

Requires environment variables to be set and non-blank

- Location: `bin/build/tools/usage.sh`

#### Arguments

- `usageFunction` - Required. `bash` function already defined to output usage
- `env0` - Optional. String. One or more environment variables which should be set and non-empty.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## Argument check: File System

### `usageArgumentFile` - Validates a value is not blank and is a file.

Validates a value is not blank and is a file.
Upon success, outputs the file name

- Location: `bin/build/tools/usage.sh`

#### Arguments

- `usageFunction` - Required. Function. Run if usage fails
- `variableName` - Required. String. Name of variable being tested
- `variableValue` - Required. String. Required only in that if it's blank, it fails.
- `noun` - Optional. String. Noun used to describe the argument in errors, defaults to `file`

#### Exit codes

- `2` - Argument error
- `0` - Success
### `usageArgumentFileDirectory` - Validates a value is not blank and is a file

Validates a value is not blank and is a file path with a directory that exists. Upon success, outputs the file name.

- Location: `bin/build/tools/usage.sh`

#### Arguments

- `usageFunction` - Required. Function. Run if usage fails
- `variableName` - Required. String. Name of variable being tested
- `variableValue` - Required. String. Required only in that if it's blank, it fails.
- `noun` - Optional. String. Noun used to describe the argument in errors, defaults to `file`

#### Exit codes

- `2` - Argument error
- `0` - Success
### `usageArgumentDirectory` - Validates a value is not blank and is a directory.

Validates a value is not blank and is a directory. Upon success, outputs the directory name trailing slash stripped.

- Location: `bin/build/tools/usage.sh`

#### Arguments

- `usageFunction` - Required. Function. Run if usage fails
- `variableName` - Required. String. Name of variable being tested
- `variableValue` - Required. String. Required only in that if it's blank, it fails.
- `noun` - Optional. String. Noun used to describe the argument in errors, defaults to `directory`

#### Exit codes

- `2` - Argument error
- `0` - Success
### `usageArgumentRealDirectory` - Validates a value is not blank and is a directory

Validates a value is not blank and is a directory and does `realPath` on it.

- Location: `bin/build/tools/usage.sh`

#### Arguments

- `usageFunction` - Required. Function. Run if usage fails
- `variableName` - Required. String. Name of variable being tested
- `variableValue` - Required. String. Required only in that if it's blank, it fails.
- `noun` - Optional. String. Noun used to describe the argument in errors, defaults to `directory`

#### Exit codes

- `2` - Argument error
- `0` - Success
### `usageArgumentLoadEnvironmentFile` - Validates a value is not blank and is an environment

Validates a value is not blank and is an environment file which is loaded immediately.

Upon success, outputs the file name to stdout, outputs a console message to stderr

- Location: `bin/build/tools/usage.sh`

#### Arguments

- `usageFunction` - Required. Function. Run if usage fails
- `variableName` - Required. String. Name of variable being tested
- `variableValue` - Required. String. Required only in that if it's blank, it fails.
- `noun` - Optional. String. Noun used to describe the argument in errors, defaults to `file`

#### Exit codes

- `2` - Argument error
- `0` - Success

## Argument check: Strings

### `usageArgumentEmptyString` - Do not require argument to be non-blank

Do not require argument to be non-blank

- Location: `bin/build/tools/usage.sh`

#### Arguments

- `usage` - Required. Function. Usage function to call upon failure.
- `argument` - Required. String. Name of the argument used in error messages.
- `value` - Optional. String, Value to output.

#### Exit codes

- `0` - Always
### `usageArgumentString` - Require an argument to be non-blank

Require an argument to be non-blank

- Location: `bin/build/tools/usage.sh`

#### Arguments

- `usage` - Required. Function. Usage function to call upon failure.
- `argument` - Required. String. Name of the argument used in error messages.
- `value` - Optional. String, Value which should be non-blank otherwise an argument error is thrown.

#### Exit codes

- `2` - If `value` is blank
- `0` - If `value` is non-blank
### `usageArgumentEnvironmentVariable` - Validates a value is ok for an environment variable name

Validates a value is ok for an environment variable name
Upon success, outputs the name

- Location: `bin/build/tools/usage.sh`

#### Arguments

- `usageFunction` - Required. Function. Run if usage fails
- `variableName` - Required. String. Name of variable being tested
- `variableValue` - Required. String. Environment variable name.
- `noun` - Optional. String. Noun used to describe the argument in errors, defaults to `environment variable`

#### Exit codes

- `2` - Argument error
- `0` - Success

## Argument check: Types

### `usageArgumentBoolean` - Require an argument to be a boolean value

Require an argument to be a boolean value

- Location: `bin/build/tools/usage.sh`

#### Arguments

- `usage` - Required. Function. Usage function to call upon failure.
- `argument` - Required. String. Name of the argument used in error messages.
- `value` - Optional. String, Value which should be non-blank otherwise an argument error is thrown.

#### Exit codes

- `2` - If `value` is not a boolean
- `0` - If `value` is a boolean
### `usageArgumentInteger` - Validates a value is an integer

Validates a value is an integer

- Location: `bin/build/tools/usage.sh`

#### Arguments

- `usageFunction` - Required. Function. Run if usage fails
- `variableName` - Required. String. Name of variable being tested
- `variableValue` - Required. String. Required only in that if it's blank, it fails.
- `noun` - Optional. String. Noun used to describe the argument in errors, defaults to `integer`

#### Exit codes

- `2` - Argument error
- `0` - Success
### `usageArgumentPositiveInteger` - Validates a value is an unsigned integer and greater than

Validates a value is an unsigned integer and greater than zero (NOT zero)

- Location: `bin/build/tools/usage.sh`

#### Arguments

- `usageFunction` - Required. Function. Run if usage fails
- `variableName` - Required. String. Name of variable being tested
- `variableValue` - Required. String. Required only in that if it's blank, it fails.
- `noun` - Optional. String. Noun used to describe the argument in errors, defaults to `unsigned integer`

#### Exit codes

- `2` - Argument error
- `0` - Success
### `usageArgumentUnsignedInteger` - Validates a value is an unsigned integer

Validates a value is an unsigned integer

- Location: `bin/build/tools/usage.sh`

#### Arguments

- `usageFunction` - Required. Function. Run if usage fails
- `variableName` - Required. String. Name of variable being tested
- `variableValue` - Required. String. Required only in that if it's blank, it fails.
- `noun` - Optional. String. Noun used to describe the argument in errors, defaults to `unsigned integer`

#### Exit codes

- `2` - Argument error
- `0` - Success

## Argument check: Functional

### `usageArgumentCallable` - Require an argument to be a callable

Require an argument to be a callable

- Location: `bin/build/tools/usage.sh`

#### Arguments

- `usage` - Required. Function. Usage function to call upon failure.
- `argument` - Required. String. Name of the argument used in error messages.
- `value` - Optional. String, Value which should be callable otherwise an argument error is thrown.

#### Exit codes

- `2` - If `value` is not `isCallable`
- `0` - If `value` is `isCallable`
### `usageArgumentFunction` - Require an argument to be a function

Require an argument to be a function

- Location: `bin/build/tools/usage.sh`

#### Arguments

- `usage` - Required. Function. Usage function to call upon failure.
- `argument` - Required. String. Name of the argument used in error messages.
- `value` - Optional. String, Value which should be a function otherwise an argument error is thrown.

#### Exit codes

- `2` - If `value` is not `isFunction`
- `0` - If `value` is `isFunction`
### `usageArgumentExecutable` - Require an argument to be a executable

Require an argument to be a executable

- Location: `bin/build/tools/usage.sh`

#### Arguments

- `usage` - Required. Function. Usage function to call upon failure.
- `argument` - Required. String. Name of the argument used in error messages.
- `value` - Optional. String, Value which should be executable otherwise an argument error is thrown.

#### Exit codes

- `2` - If `value` is not `isExecutable`
- `0` - If `value` is `isExecutable`

## Argument check: URL

### `usageArgumentURL` - Require an argument to be a URL

Require an argument to be a URL

- Location: `bin/build/tools/usage.sh`

#### Arguments

- `usage` - Required. Function. Usage function to call upon failure.
- `argument` - Required. String. Name of the argument used in error messages.
- `value` - Optional. String, Value which should be a URL otherwise an argument error is thrown.

#### Exit codes

- `0` - If `value` is `urlValid`
- `2` - If `value` is not `urlValid`

## Argument Errors (fail)

### `usageArgumentMissing` - Throw an missing argument error

Throw an missing argument error

- Location: `bin/build/tools/usage.sh`

#### Arguments

- `usage` - Required. Function. Usage function to call upon failure.
- `argument` - Required. String. Name of the argument used in error messages.

#### Exit codes

- `2` - Always
### `usageArgumentUnknown` - Throw an unknown argument error

Throw an unknown argument error

- Location: `bin/build/tools/usage.sh`

#### Arguments

- `usage` - Required. Function. Usage function to call upon failure.
- `argument` - Required. String. Name of the argument used in error messages.

#### Exit codes

- `2` - Always
