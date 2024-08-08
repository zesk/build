# Environment Tools

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

## Environment

### `environmentVariables` - Output a list of environment variables and ignore function definitions

Output a list of environment variables and ignore function definitions

both `set` and `env` output functions and this is an easy way to just output
exported variables

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## State files

#### Arguments

- `environmentFile` - Required. Environment file to load.

#### Exit codes

- `2` - if file does not exist; outputs an error
- `0` - if files are loaded successfully
### `environmentValueWrite` - Write a value to a state file as NAME="value"

Write a value to a state file as NAME="value"

#### Usage

    name - Required. String. Name to write.
    value - Optional. String. Value to write.
    

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `environmentValueRead` - Read one or more values values safely from a environment

Read one or more values values safely from a environment file

#### Arguments

- `stateFile` - Required. File. File to access, must exist.
- `name` - Required. String. Name to read.
- `default` - Optional. String. Value to return if value not found.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `environmentLines` - List lines of environment values set in a bash state

List lines of environment values set in a bash state file

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `environmentNames` - List names of environment values set in a bash state

List names of environment values set in a bash state file

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## Application `.env`

### `environmentFileApplicationMake` - Create environment file `.env` for build.

Create environment file `.env` for build.

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

#### Arguments

- `requiredEnvironment ...` - Optional. One or more environment variables which should be non-blank and included in the `.env` file.
- `--` - Optional. Divider. Divides the requiredEnvironment values from the optionalEnvironment
- `optionalEnvironment ...` - Optional. One or more environment variables which are included if blank or not

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
