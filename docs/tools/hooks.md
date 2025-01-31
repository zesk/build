# Defined Hooks

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

## Context hook runners

These run within the current project regardless of where Zesk Build is loaded:

### `hookVersionCurrent` - Application current version

Application current version

Extracts the version from the repository

- Location: `bin/build/tools/hooks.sh`

#### Arguments

- `--help` - Optional. Flag. Display this help.
- `--application application` - Optional. Directory. Application home directory.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `hookVersionLive` - Application deployed version

Application deployed version

- Location: `bin/build/tools/hooks.sh`

#### Arguments

- `--help` - Optional. Flag. Display this help.
- `--application application` - Optional. Directory. Application home directory.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## Application hooks

#### Arguments

- `--sound soundName` - Play a sound
- `--title title` - Set the title of the notification
- `message ...` - Display this message (one per line) in the notification.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

BUILD_NOTIFY_SOUND - Play this sound if none is specified.
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

# Version hooks

These hooks interact with `new-release.sh` and deployment tools but are intended to be used anywhere.

- `version-current` - Required. The current version. Defaults to the highest version in `docs/release`.
- `version-live` - Optional. Determine the live version.
- `version-created` - Optional. Run when a new version is created.
- `version-already` - Optional. Run when a new version is requested, but it already exists in the source code.

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

BUILD_VERSION_NO_OPEN - Do not open in the default editor. Set this is you do not want the behavior and do not have an override `version-created` hook
#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

BUILD_VERSION_NO_OPEN - Do not open in the default editor. Set this is you do not want the behavior and do not have an override `version-created` hook
#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `__hookVersionLive` - Fetch the current live version of the software

Fetch the current live version of the software

- Location: `bin/hooks/version-live.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## Deployment Hooks

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
#### Arguments

- No arguments.

#### Examples

    885acc3

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
#### Arguments

- `message` - Required. String. Maintenance setting: `on | 1 | true | off | 0 | false`
- `maintenanceSetting` - Required. String. Maintenance setting: `on | 1 | true | off | 0 | false`

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

BUILD_MAINTENANCE_VARIABLE - If you want to use a different environment variable than `MAINTENANCE`, set this environment variable to the variable you want to use.

#### Arguments

- No arguments.

#### Examples

- Move directories to make deployment final

#### Exit codes

- `0` - This SHOULD exit successfully always
#### Arguments

- `applicationPath` - This is the target for the current application

#### Exit codes

- `0` - This is called to replace the running application in-place
#### Arguments

- No arguments.

#### Examples

- Enable a health endpoint which returns version number and ensure all servers return the same version number (which was just updated)
- Check the home page for a version number
- Check for a known artifact (build sha) in the server somehow
- etc.

#### Exit codes

- `0` - Continue with deployment
- `Non-zero` - Any non-zero exit code will run `deploy-revert` hook on all systems and cancel deployment
#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
#### Arguments

- No arguments.

#### Examples

- Move directories to make deployment final

#### Exit codes

- `0` - This SHOULD exit successfully always
#### Arguments

- No arguments.

#### Exit codes

- `0` - This SHOULD exit successfully always

## Git hooks

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

## Test Hooks

#### Arguments

- No arguments.

#### Exit codes

- `0` - If the test setup was successful
- `Non-Zero` - Any error will terminate testing
#### Arguments

- No arguments.

#### Exit codes

- `0` - If the tests all pass
- `Non-Zero` - If any test fails for any reason
#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
