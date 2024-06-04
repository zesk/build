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

{SEE:toDockerEnv}

## Hooks


### `runHook` - Run a project hook

Run a hook in the project located at `./bin/hooks/`

See (Hooks documentation)[../hooks/index.md] for standard hooks.

Hooks provide an easy way to customize your build. Hooks are binary files located in your project directory at `./bin/hooks/` and are named `hookName` with a `.sh` extension added.
So the hook for `version-current` would be a file at:

    bin/hooks/version-current.sh

Sample hooks (scripts) can be found in the build source code at `./bin/hooks/`.

Default hooks (scripts) can be found in the current build version at `bin/build/hooks/`

#### Usage

    runHook [ --application applicationHome ] hookName [ arguments ... ]
    

#### Arguments



#### Examples

    version="$(runHook version-current)"

#### Exit codes

- `Any` - The hook exit code is returned if it is run
- `1` - is returned if the hook is not found

#### See Also

{SEE:hooks.md}
{SEE:runOptionalHook}

### `runOptionalHook` - Identical to `runHook` but returns exit code zero if the

Identical to `runHook` but returns exit code zero if the hook does not exist.

#### Usage

    runOptionalHook hookName [ arguments ... ]
    

#### Examples

    if ! runOptionalHook test-cleanup >>"$quietLog"; then
        buildFailed "$quietLog"
    fi

#### Exit codes

- `Any` - The hook exit code is returned if it is run
- `0` - is returned if the hook is not found

#### See Also

{SEE:hooks.md}
{SEE:runHook}

### `hasHook` - Determine if a hook exists

Does a hook exist in the local project?

Check if one or more hook exists. All hooks must exist to succeed.

#### Usage

    hasHook [ --application applicationHome ] hookName0 [ hookName1 ... ]
    

#### Arguments



#### Exit codes

- `0` - If all hooks exist

### `whichHook` - Find the path to a hook binary file

Does a hook exist in the local project?

Find the path to a hook. The search path is:

- `./bin/hooks/`
- `./bin/build/hooks/`

If a file named `hookName` with the extension `.sh` is found which is executable, it is output.

#### Usage

    whichHook [ --application applicationHome ] hookName0 [ hookName1 ... ]
    

#### Arguments



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



#### Examples

    quietLog="$(buildQuietLog "$me")"
    if ! ./bin/deploy.sh >>"$quietLog"; then
        consoleError "Deploy failed"
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

#### Usage

    versionSort [ -r ]
    

#### Arguments



#### Examples

   git tag | grep -e '^v[0-9.]*$' | versionSort

#### Exit codes

- `0` - Always succeeds

### `ipLookup` - Get the current IP address of the host

Get the current IP address of the host

#### Exit codes

- `1` - Returns

### `isUpToDate` - Test whether the key needs to be updated

For security one should update keys every N days

This value would be better encrypted and tied to the key itself so developers
can not just update the value to avoid the security issue.

This tool checks the value and checks if it is `upToDateDays` of today; if not this fails.

It will also fail if:

- `upToDateDays` is less than zero or greater than 366
- `keyDate` is empty or has an invalid value

Otherwise, the tool *may* output a message to the console warning of pending days, and returns exit code 0 if the `keyDate` has not exceeded the number of days.

#### Usage

    isUpToDate [ --name name ] keyDate upToDateDays
    

#### Arguments



#### Examples

    if !isUpToDate "$AWS_ACCESS_KEY_DATE" 90; then
      bigText Failed, update key and reset date
      exit 99
    fi

#### Exit codes

- `0` - Always succeeds

## Application Environment


### `makeEnvironment` - Create environment file `.env` for build.

Create environment file `.env` for build.

#### Usage

    makeEnvironment [ requireEnv1 requireEnv2 requireEnv3 ... ] [ -- optionalEnv1 optionalEnv2 ] "
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

#### Environment

APPLICATION_VERSION - reserved and set to `runHook version-current` if not set already
APPLICATION_BUILD_DATE - reserved and set to current date; format like SQL.
APPLICATION_TAG - reserved and set to `runHook application-id`
APPLICATION_ID - reserved and set to `runHook application-tag`
Unable to find "showEnviornment" (using index "/root/.build")

#### Exit codes

- `0` - Always succeeds

#### Errors

Unable to find "showEnviornment" (using index "/root/.build")

### `applicationEnvironment` - Loads application environment variables, set them to their default values

Loads application environment variables, set them to their default values if needed, and outputs the list of variables set.

#### Exit codes

- `0` - Always succeeds

#### Environment

BUILD_TIMESTAMP
APPLICATION_BUILD_DATE
APPLICATION_VERSION
APPLICATION_ID
APPLICATION_TAG

#### Errors

Unable to find "showEnviornment" (using index "/root/.build")

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

#### Usage

    deployApplication deployHome applicationId applicationPath [ targetPackage ]
    

#### Arguments



#### Examples

deployApplication --home /var/www/DEPLOY --id 10c2fab1 --application /var/www/apps/cool-app

#### Exit codes

- `0` - Always succeeds

#### Environment

BUILD_TARGET APPLICATION_ID APPLICATION_TAG

#### See Also

{SEE:deployToRemote}

#### Errors

Unable to find "showEnviornment" (using index "/root/.build")

### `deployNextVersion` - Get the next version of the supplied version

Get the next version of the supplied version

#### Usage

    deployNextVersion deployHome versionName
    

#### Exit codes

- `0` - Always succeeds

#### Errors

Unable to find "showEnviornment" (using index "/root/.build")

### `deployPreviousVersion` - Get the previous version of the supplied version

Get the previous version of the supplied version

#### Usage

    deployPreviousVersion deployHome versionName
    

#### Exit codes

- `1` - No version exists
- `2` - Argument error

#### Errors

Unable to find "showEnviornment" (using index "/root/.build")

### `deployHasVersion` - Does a deploy version exist? versionName is the version identifier

Does a deploy version exist? versionName is the version identifier for deployments

#### Usage

    deployHasVersion deployHome versionName [ targetPackage ]
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

#### Errors

Unable to find "showEnviornment" (using index "/root/.build")

### `deployApplicationVersion` - Extracts version from an application either from `.deploy` files or

Extracts version from an application either from `.deploy` files or from the the `.env` if
that does not exist.

Checks `APPLICATION_ID` and `APPLICATION_TAG` and uses first non-blank value.

#### Usage

    deployApplicationVersion applicationHome
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

#### Errors

Unable to find "showEnviornment" (using index "/root/.build")

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
