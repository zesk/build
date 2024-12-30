# Pipeline Functions

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

## Application Configuration

### `dotEnvConfigure` - Load `.env` and optional `.env.local` into bash context

Loads `.env` which is the current project configuration file
Also loads `.env.local` if it exists
Generally speaking - these are NAME=value files and should be parsable by
bash and other languages.

Requires the file `.env` to exist and is loaded via bash `source` and all variables are `export`ed in the current shell context.

If `.env.local` exists, it is also loaded in a similar manner.

- Location: `bin/build/tools/environment.sh`

#### Usage

    environmentFileLoad .env --optional .env.local where
    

#### Arguments

- `where` - Optional. Directory. Where to load the `.env` files.

#### Exit codes

- `1` - if `.env` does not exist; outputs an error
- `0` - if files are loaded successfully

#### Environment

Loads `.env` and `.env.local`, use with caution on trusted content only

## Hooks

### `runHook` - Run a project hook

Run a hook in the project located at `./bin/hooks/`

See (Hooks documentation)[../hooks/index.md] for standard hooks.

Hooks provide an easy way to customize your build. Hooks are binary files located in your project directory at `./bin/hooks/` and are named `hookName` with a `.sh` extension added.
So the hook for `version-current` would be a file at:

    bin/hooks/version-current.sh

Sample hooks (scripts) can be found in the build source code at `./bin/hooks/`.

Default hooks (scripts) can be found in the current build version at `bin/build/hooks/`

- Location: `bin/build/tools/hook.sh`

#### Arguments

- `--application applicationHome` - Path. Optional. Directory of alternate application home.
- `hookName` - String. Required. Hook name to run.
- `arguments` - Optional. Arguments are passed to `hookName`.

#### Examples

    version="$(runHook version-current)"

#### Exit codes

- `Any` - The hook exit code is returned if it is run
- `1` - is returned if the hook is not found
### `runOptionalHook` - Identical to `runHook` but returns exit code zero if the

Identical to `runHook` but returns exit code zero if the hook does not exist.

- Location: `bin/build/tools/hook.sh`

#### Arguments

- No arguments.

#### Examples

    if ! runOptionalHook test-cleanup >>"$quietLog"; then
        buildFailed "$quietLog"
    fi

#### Exit codes

- `Any` - The hook exit code is returned if it is run
- `0` - is returned if the hook is not found
### `hasHook` - Determine if a hook exists

Does a hook exist in the local project?

Check if one or more hook exists. All hooks must exist to succeed.

- Location: `bin/build/tools/hook.sh`

#### Arguments

- `--application applicationHome` - Path. Optional. Directory of alternate application home. Can be specified more than once to change state.
- `hookName0` - one or more hook names which must exist

#### Exit codes

- `0` - If all hooks exist
### `whichHook` - Find the path to a hook binary file

Does a hook exist in the local project?

Find the path to a hook. The search path is:

- `./bin/hooks/`
- `./bin/build/hooks/`

If a file named `hookName` with the extension `.sh` is found which is executable, it is output.

- Location: `bin/build/tools/hook.sh`

#### Arguments

- `--application applicationHome` - Path. Optional. Directory of alternate application home. Can be specified more than once to change state.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## Reporting timing

### `beginTiming` - Start a timer for a section of the build

Outputs the offset in seconds from January 1, 1970.

- Location: `bin/build/tools/pipeline.sh`

#### Usage

    beginTiming
    

#### Arguments

- No arguments.

#### Examples

    init=$(beginTiming)
    ...
    reportTiming "$init" "Completed in"

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `reportTiming` - Output the time elapsed

Outputs the timing in magenta optionally prefixed by a message in green

Outputs a nice colorful message showing the number of seconds elapsed as well as your custom message.

- Location: `bin/build/tools/pipeline.sh`

#### Usage

    reportTiming start [ message ... ]
    

#### Arguments

- `start` - Unix timestamp seconds of start timestamp
- `message` - Any additional arguments are output before the elapsed value computed

#### Examples

   init=$(beginTiming)
   ...
   reportTiming "$init" "Deploy completed in"

#### Exit codes

- `0` - Exits with exit code zero

## Build Utilities

### `buildFailed` - Output debugging information when the build fails

Outputs debugging information after build fails:

- last 50 lines in build log
- Failed message
- last 3 lines in build log

- Location: `bin/build/tools/pipeline.sh`

#### Usage

    buildFailed logFile
    

#### Arguments

- `logFile` - the most recent log from the current script

#### Examples

    quietLog="$(buildQuietLog "$me")"
    if ! ./bin/deploy.sh >>"$quietLog"; then
        decorate error "Deploy failed"
        buildFailed "$quietLog"
    fi

#### Sample Output

    stdout
    

#### Exit codes

- `1` - Always fails
### `versionSort` - Sort versions in the format v0.0.0

Sorts semantic versions prefixed with a `v` character; intended to be used as a pipe.

vXXX.XXX.XXX

for sort - -k 1.c,1 - the `c` is the 1-based character index, so 2 means skip the 1st character

Odd you can't globally flip sort order with -r - that only works with non-keyed entries I assume

- Location: `bin/build/tools/pipeline.sh`

#### Usage

    versionSort [ -r ]
    

#### Arguments

- `-r` - Reverse the sort order (optional)

#### Examples

   git tag | grep -e '^v[0-9.]*$' | versionSort

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `ipLookup` - Get the current IP address of a host

Get the current IP address of a host

- Location: `bin/build/tools/pipeline.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `isUpToDate` - Test whether the key needs to be updated

For security one should update keys every N days

This value would be better encrypted and tied to the key itself so developers
can not just update the value to avoid the security issue.

This tool checks the value and checks if it is `upToDateDays` of today; if not this fails.

It will also fail if:

- `upToDateDays` is less than zero or greater than 366
- `keyDate` is empty or has an invalid value

Otherwise, the tool *may* output a message to the console warning of pending days, and returns exit code 0 if the `keyDate` has not exceeded the number of days.

- Location: `bin/build/tools/pipeline.sh`

#### Arguments

- `keyDate` - Required. Date. Formatted like `YYYY-MM-DD`
- `--name name` - Optional. Name of the expiring item for error messages.
- `upToDateDays` - Required. Integer. Days that key expires after `keyDate`.

#### Examples

    if !isUpToDate "$AWS_ACCESS_KEY_DATE" 90; then
      bigText Failed, update key and reset date
      exit 99
    fi

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## Application Environment

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
### `environmentFileShow` - Display and validate application variables.

Display and validate application variables.

- Location: `bin/build/tools/environment.sh`

#### Arguments

- `environmentName` - EnvironmentVariable. Optional. A required environment variable name
- `--` - Separator. Optional. Separates requires from optional environment variables
- `optionalEnvironmentName` - EnvironmentVariable. Optional. An optional environment variable name.

#### Exit codes

- `1` - If any required application variables are blank, the function fails with an environment error
- `0` - All required application variables are non-blank
### `environmentApplicationLoad` - Loads application environment variables, set them to their default values

Loads application environment variables, set them to their default values if needed, and outputs the list of variables set.

- Location: `bin/build/tools/environment.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

BUILD_TIMESTAMP
APPLICATION_BUILD_DATE
APPLICATION_VERSION
APPLICATION_ID
APPLICATION_TAG

## Deployment tools

### `deployApplication` - Deploy an application from a deployment repository

Deploy an application from a deployment repository

     ____             _
    |  _ \  ___ _ __ | | ___  _   _
    | | | |/ _ \ '_ \| |/ _ \| | | |
    | |_| |  __/ |_) | | (_) | |_| |
    |____/ \___| .__/|_|\___/ \__, |
               |_|            |___/

This acts on the local file system only but used in tandem with `deployment.sh` functions.

- Location: `bin/build/tools/deploy/application.sh`

#### Arguments

- `--help` - Optional. Flag. This help.
- `--first` - Optional. Flag. The first deployment has no prior version and can not be reverted.
- `--revert` - Optional. Flag. Means this is part of the undo process of a deployment.
- `--home deployHome` - Required. Directory. Path where the deployments database is on remote system.
- `--id applicationId` - Required. String. Should match `APPLICATION_ID` or `APPLICATION_TAG` in `.env` or `.deploy/`
- `--application applicationPath` - Required. String. Path on the remote system where the application is live
- `--target targetPackage` - Optional. Filename. Package name, defaults to `BUILD_TARGET`
- `--message message` - Optional. String. Message to display in the maintenance message on systems while upgrade is occurring.

#### Examples

deployApplication --home /var/www/DEPLOY --id 10c2fab1 --application /var/www/apps/cool-app

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

BUILD_TARGET APPLICATION_ID APPLICATION_TAG
### `deployNextVersion` - Get the next version of the supplied version

Get the next version of the supplied version

- Location: `bin/build/tools/deploy.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `deployPreviousVersion` - Get the previous version of the supplied version

Get the previous version of the supplied version

- Location: `bin/build/tools/deploy.sh`

#### Arguments

- No arguments.

#### Exit codes

- `1` - No version exists
- `2` - Argument error
### `deployHasVersion` - Does a deploy version exist? versionName is the version identifier

Does a deploy version exist? versionName is the version identifier for deployments

- Location: `bin/build/tools/deploy.sh`

#### Arguments

- `deployHome` - Required. Directory. Deployment database home.
- `versionName` - Required. String. Application ID to look for

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `deployApplicationVersion` - Extracts version from an application either from `.deploy` files or

Extracts version from an application either from `.deploy` files or from the the `.env` if
that does not exist.

Checks `APPLICATION_ID` and `APPLICATION_TAG` and uses first non-blank value.

- Location: `bin/build/tools/deploy.sh`

#### Arguments

- `applicationHome` - Required. Directory. Application home to get the version from.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
