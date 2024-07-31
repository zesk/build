# Environment Tools

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

## Environment


### `environmentVariables` - Output a list of environment variables and ignore function definitions

Output a list of environment variables and ignore function definitions

both `set` and `env` output functions and this is an easy way to just output
exported variables

#### Usage

    environmentVariables
    

#### Exit codes

- `0` - Always succeeds

### `buildEnvironmentLoad` - Load one or more environment settings from bin/build/env or bin/env.

Load one or more environment settings from bin/build/env or bin/env.


If BOTH files exist, both are sourced, so application environments should anticipate values
created by default.

#### Usage

    buildEnvironmentLoad [ envName ... ]
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

## State files


#### Usage

    environmentFileLoad environmentFile ...
    

#### Arguments



#### Exit codes

- `2` - if file does not exist; outputs an error
- `0` - if files are loaded successfully

### `environmentValueWrite` - Write a value to a state file as NAME="value"

Write a value to a state file as NAME="value"

#### Usage

    name - Required. String. Name to write.
    value - Optional. String. Value to write.
    

#### Exit codes

- `0` - Always succeeds

### `environmentValueRead` - Read one or more values values safely from a environment

Read one or more values values safely from a environment file

#### Usage

    environmentValueRead stateFile
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

### `environmentLines` - List lines of environment values set in a bash state

List lines of environment values set in a bash state file

#### Usage

    environmentLines < "$stateFile"
    

#### Exit codes

- `0` - Always succeeds

### `environmentNames` - List names of environment values set in a bash state

List names of environment values set in a bash state file

#### Usage

    environmentNames < "$stateFile"
    

#### Exit codes

- `0` - Always succeeds

## Application `.env`


### `environmentFileApplicationMake` - Create environment file `.env` for build.

Create environment file `.env` for build.

#### Usage

    environmentFileApplicationMake [ requiredEnvironment ... ] [ -- optionalEnvironment ...] "
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

#### Environment

APPLICATION_VERSION - reserved and set to `runHook version-current` if not set already
APPLICATION_BUILD_DATE - reserved and set to current date; format like SQL.
APPLICATION_TAG - reserved and set to `runHook application-id`
APPLICATION_ID - reserved and set to `runHook application-tag`

### `environmentFileApplicationVerify` - Check application environment is populated correctly.

Check application environment is populated correctly.
Also verifies that `environmentApplicationVariables` and `environmentApplicationLoad` are defined.

#### Usage

    environmentFileApplicationVerify [ requiredEnvironment ... ] [ -- optionalEnvironment ...] "
    

#### Arguments



#### Exit codes

- `0` - Always succeeds
