# Environment Tools

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

## Environment

### `environmentVariables` - Output a list of environment variables and ignore function definitions

Output a list of environment variables and ignore function definitions

both `set` and `env` output functions and this is an easy way to just output
exported variables

- Location: `bin/build/tools/environment.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `environmentVariableNameValid` - variableName - String. Required. Exit status 0 if all variables

variableName - String. Required. Exit status 0 if all variables names are valid ones.
Validates an environment variable name

- alpha
- digit
- underscore

First letter MUST NOT be a digit

- Location: `bin/build/tools/environment.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## Variable lists

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## State files

### `environmentFileLoad` - Safely load an environment file (no code execution)

Safely load an environment file (no code execution)

- Location: `bin/build/tools/environment.sh`

#### Arguments

- `environmentFile` - Required. Environment file to load.
- `environmentFile` - Required. Environment file to load.
- `--required` - Flag. Optional. All subsequent environment files on the command line will be required.
- `--optional` - Flag. Optional. All subsequent environment files on the command line will be optional. (If they do not exist, no errors.)
- `--verbose` - Flag. Optional. Output errors with variables in files.
- `environmentFile` - Required. Environment file to load. For `--optional` files the directory must exist.
- `--ignore environmentName` - Optional. String. Environment value to ignore on load.
- `--secure environmentName` - Optional. String. If found in a loaded file, entire file fails.
- `--secure-defaults` - Flag. Optional. Add a list of environment variables considered security risks to the `--ignore` list.

#### Exit codes

- `2` - if file does not exist; outputs an error
- `0` - if files are loaded successfully
### `environmentValueWrite` - Write a value to a state file as NAME="value"

Write a value to a state file as NAME="value"

- Location: `bin/build/tools/environment.sh`

#### Usage

    name - Required. String. Name to write.
    value - Optional. EmptyString. Value to write.
    ... - Optional. EmptyString. Additional values, when supplied, write this value as an array.
    

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `environmentValueWriteArray` - Write an array value as NAME=([0]="a" [1]="b" [2]="c")

Write an array value as NAME=([0]="a" [1]="b" [2]="c")
Supports empty arrays
Bash outputs on different versions:

    declare -a foo='([0]="a'\''s" [1]="b" [2]="c")'
    declare -a foo=([0]="a's" [1]="b" [2]="c")

- Location: `bin/build/tools/environment.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `environmentValueRead` - Read one or more values values safely from a environment

Read one or more values values safely from a environment file

- Location: `bin/build/tools/environment.sh`

#### Arguments

- `stateFile` - Required. File. File to access, must exist.
- `name` - Required. String. Name to read.
- `default` - Optional. String. Value to return if value not found.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `environmentValueReadArray` - Read an array value from a state file

Read an array value from a state file
Outputs array elements, one per line.

- Location: `bin/build/tools/environment.sh`

#### Arguments

- `stateFile` - Required. File. File to access, must exist.
- `name` - Required. EnvironmentVariable. Name to read.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error 
### `environmentValueConvertArray` - Convert an array value which was loaded already

Convert an array value which was loaded already

- Location: `bin/build/tools/environment.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `environmentLines` - List lines of environment values set in a bash state

List lines of environment values set in a bash state file

- Location: `bin/build/tools/environment.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `environmentNames` - List names of environment values set in a bash state

List names of environment values set in a bash state file

- Location: `bin/build/tools/environment.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## Application `.env`

### `environmentFileApplicationMake` - Create environment file `.env` for build.

Create environment file `.env` for build.

- Location: `bin/build/tools/environment.sh`

#### Arguments

- `requiredEnvironment ...` - Optional. One or more environment variables which should be non-blank and included in the `.env` file.
- `--` - Optional. Divider. Divides the requiredEnvironment values from the optionalEnvironment
- `optionalEnvironment ...` - Optional. One or more environment variables which are included if blank or not

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

APPLICATION_VERSION - reserved and set to `runHook version-current` if not set already
APPLICATION_BUILD_DATE - reserved and set to current date; format like SQL.
APPLICATION_TAG - reserved and set to `runHook application-id`
APPLICATION_ID - reserved and set to `runHook application-tag`
### `environmentFileApplicationVerify` - Check application environment is populated correctly.

Check application environment is populated correctly.
Also verifies that `environmentApplicationVariables` and `environmentApplicationLoad` are defined.

- Location: `bin/build/tools/environment.sh`

#### Arguments

- `requiredEnvironment ...` - Optional. One or more environment variables which should be non-blank and included in the `.env` file.
- `--` - Optional. Divider. Divides the requiredEnvironment values from the optionalEnvironment
- `optionalEnvironment ...` - Optional. One or more environment variables which are included if blank or not

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
