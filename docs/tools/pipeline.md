# Pipeline Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)

## Application Configuration


### `dotEnvConfigure` - Load `.env` and optional `.env.local` into bash context

Loads "./.env" which is the current project configuration file
Also loads "./.env.local" if it exists
Generally speaking - these are NAME=value files and should be parsable by
bash and other languages.

Requires the file `.env` to exist and is loaded via bash `source` and all variables are `export`ed in the current shell context.

If `.env.local` exists, it is also loaded in a similar manner.

The previous version of this function was `dotEnvConfig` and is now deprecated, and outputs a warning.

#### Usage

    dotEnvConfigure
    

#### Exit codes

- `1` - if `.env` does not exist; outputs an error
- `0` - if files are loaded successfully

#### Environment

Loads `./.env` and `./.env.local`, use with caution.

#### See Also

Not found

## Hooks


### `runHook` - Run a project hook

Run a hook in the project located at `./bin/hooks/`

See (Hooks documentation)[../hooks/index.md] for standard hooks.

Hooks provide an easy way to customize your build. Hooks are binary files located in your project directory at `./bin/hooks/` and are named `hookName` with a `.sh` extension added.
So the hook for `version-current` would be a file at:

    bin/hooks/version-current.sh

Sample hooks (scripts) can be found in the build source code at `./bin/hooks/`.

Default hooks (scripts) can be found in the current build version at `bin/build/hooks/`

#### Arguments

- `--application applicationHome` - Path. Optional. Directory of alternate application home.
- `hookName` - String. Required. Hook name to run.
- `arguments` - Optional. Arguments are passed to `hookName`.

#### Examples

    version="$(runHook version-current)"

#### Exit codes

- `Any` - The hook exit code is returned if it is run
- `1` - is returned if the hook is not found

#### See Also

Not found
- [function runOptionalHook
](./docs/tools/pipeline.md
) - [Identical to `runHook` but returns exit code zero if the
](https://github.com/zesk/build/blob/main/bin/build/tools/hook.sh#L110
)

### `runOptionalHook` - Identical to `runHook` but returns exit code zero if the

Identical to `runHook` but returns exit code zero if the hook does not exist.

#### Examples

    if ! runOptionalHook test-cleanup >>"$quietLog"; then
        buildFailed "$quietLog"
    fi

#### Exit codes

- `Any` - The hook exit code is returned if it is run
- `0` - is returned if the hook is not found

#### See Also

Not found
- [function runHook
](./docs/tools/pipeline.md
) - [Run a project hook
](https://github.com/zesk/build/blob/main/bin/build/tools/hook.sh#L92
)

### `hasHook` - Determine if a hook exists

Does a hook exist in the local project?

Check if one or more hook exists. All hooks must exist to succeed.

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

#### Arguments

- `--application applicationHome` - Path. Optional. Directory of alternate application home. Can be specified more than once to change state.

#### Exit codes

- `0` - Always succeeds

## Reporting timing


### `beginTiming` - Start a timer for a section of the build

Outputs the offset in seconds from January 1, 1970.

#### Usage

    beginTiming
    

#### Examples

    init=$(beginTiming)
    ...
    reportTiming "$init" "Completed in"

#### Exit codes

- `0` - Always succeeds

### `reportTiming` - Output the time elapsed

Outputs the timing in magenta optionally prefixed by a message in green

Outputs a nice colorful message showing the number of seconds elapsed as well as your custom message.

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

#### Usage

    buildFailed logFile
    

#### Arguments

- `logFile` - the most recent log from the current script

#### Examples

    quietLog="$(buildQuietLog "$me")"
    if ! ./bin/deploy.sh >>"$quietLog"; then
        consoleError "Deploy failed"
        buildFailed "$quietLog"
    fi

#### Exit codes

- `1` - Always fails

### `versionSort` - Sort versions in the format v0.0.0

Sorts semantic versions prefixed with a `v` character; intended to be used as a pipe.

vXXX.XXX.XXX

for sort - -k 1.c,1 - the `c` is the 1-based character index, so 2 means skip the 1st character

Odd you can't globally flip sort order with -r - that only works with non-keyed entries I assume

#### Usage

    versionSort [ -r ]
    

#### Arguments

- `-r` - Reverse the sort order (optional)

#### Examples

   git tag | grep -e '^v[0-9.]*$' | versionSort

#### Exit codes

- `0` - Always succeeds

### `ipLookup` - Get the current IP address of the host

Get the current IP address of the host

#### Exit codes

- `1` - Returns

## Deployment tools


### `makeEnvironment` - Create environment file `.env` for build.

Create environment file `.env` for build.

#### Arguments

- `requireEnv1` - Optional. One or more environment variables which should be non-blank and included in the `.env` file.
- `optionalEnv1` - Optional. One or more environment variables which are included if blank or not

#### Exit codes

- `0` - Always succeeds

#### Environment

APPLICATION_VERSION - reserved and set to `runHook version-current` if not set already
APPLICATION_BUILD_DATE - reserved and set to current date; format like SQL.
APPLICATION_TAG - reserved and set to `runHook application-id`
APPLICATION_ID - reserved and set to `runHook application-tag`

### `deployApplication` - Deploy an application from a deployment repository

Deploy an application from a deployment repository

     ____             _
    |  _ \  ___ _ __ | | ___  _   _
    | | | |/ _ \ '_ \| |/ _ \| | | |
    | |_| |  __/ |_) | | (_) | |_| |
    |____/ \___| .__/|_|\___/ \__, |
               |_|            |___/

This acts on the local file system only but used in tandem with `deployment.sh` functions.

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

- `0` - Always succeeds

#### Environment

BUILD_TARGET APPLICATION_ID APPLICATION_TAG

#### See Also

- [function deployToRemote
](./docs/tools/todo.md
) - [Deploy current application to one or more hosts
](https://github.com/zesk/build/blob/main/bin/build/tools/deployment.sh#L347
)
Unable to find "deployRevertApplication" (using index "/Users/kent/.build")

### `deployNextVersion` - Get the next version of the supplied version

Get the next version of the supplied version

#### Exit codes

- `0` - Always succeeds

#### Errors

Unable to find "deployRevertApplication" (using index "/Users/kent/.build")

### `deployPreviousVersion` - Get the previous version of the supplied version

Get the previous version of the supplied version

#### Exit codes

- `1` - No version exists
- `2` - Argument error

#### Errors

Unable to find "deployRevertApplication" (using index "/Users/kent/.build")

### `deployHasVersion` - Does a deploy version exist? versionName is the version identifier

Does a deploy version exist? versionName is the version identifier for deployments

#### Arguments

- `deployHome` - Required. Directory. Deployment database home.
- `versionName` - Required. String. Application ID to look for

#### Exit codes

- `0` - Always succeeds

#### Errors

Unable to find "deployRevertApplication" (using index "/Users/kent/.build")

### `deployApplicationVersion` - Extracts version from an application either from `.deploy` files or

Extracts version from an application either from `.deploy` files or from the the `.env` if
that does not exist.

Checks `APPLICATION_ID` and `APPLICATION_TAG` and uses first non-blank value.

#### Arguments

- `applicationHome` - Required. Directory. Application home to get the version from.

#### Exit codes

- `0` - Always succeeds

#### Errors

Unable to find "deployRevertApplication" (using index "/Users/kent/.build")

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
