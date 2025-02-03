# Function signatures for callbacks

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

The following function signatures are used prevalently as callbacks:

- `errorHandler` - Used by 99% of functions to handle or display errors

A typical usage is:

    usageRequireBinary "$handler" curl sftp

The `$handler` is defined here:

### `errorHandler` - The main error handler signature used in Zesk Build.

The main error handler signature used in Zesk Build.

Some code patterns:

    usageRequireBinary "$handler" mariadb || return $?

- Location: `bin/identical/arguments.sh`

#### Arguments

- `exitCode` - Integer. Required. The exit code to handle.
- `message ...` - EmptyString. Optional. The message to display to the user about what caused the error.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## Installation function signatures

These are all used in - [function ]() - []().

### `packageVersionFunction` - Used to check the remote version against the local version

Used to check the remote version against the local version of a package to be installed.
`versionFunction` should exit 0 to halt the installation, in addition it should output the current version as a decorated string.

- Location: `bin/build/identical/_installRemotePackage.sh`

#### Arguments

- `handler` - Function. Required. Function to call when an error occurs. Signature `errorHandler`.
- `applicationHome` - Directory. Required. Path to the application home where target will be installed, or is installed. (e.g. myApp/)
- `installPath` - Directory. Required. Path to the installPath home where target will be installed, or is installed. (e.g. myApp/bin/build)

#### Exit codes

- `0` - Do not upgrade, version is same as remote (stdout is found, current version)
- `1` - Do upgrade, version changed. (stdout is version change details) ### `packageUrlFunction` - Prints the remote URL for a package, or exits non-zero

Prints the remote URL for a package, or exits non-zero on error.

Takes a single argument, the error handler, a function.

- Location: `bin/build/identical/_installRemotePackage.sh`

#### Arguments

- `handler` - Function. Required. Function to call when an error occurs.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error ### `packageCheckFunction` - Verify an installation afterwards.

Verify an installation afterwards.


If `checkFunction` fails, it should output any errors to `stderr` and return a non-zero exit code.

- Location: `bin/build/identical/_installRemotePackage.sh`

#### Arguments

- `handler` - Function. Required. Function to call when an error occurs.
- `installPath` - Directory. Required. Path to the installPath home where target will be installed, or is installed. (e.g. myApp/bin/build)

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
