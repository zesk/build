# Pipeline Functions

    ░█▀█░▀█▀░█▀█░█▀▀░█░░░▀█▀░█▀█░█▀▀
    ░█▀▀░░█░░█▀▀░█▀▀░█░░░░█░░█░█░█▀▀
    ░▀░░░▀▀▀░▀░░░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀▀▀

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

toDockerEnv

## Hooks


### `runHook` - Run a project hook

Run a hook in the project located at `./bin/hooks/`

See (Hooks documentation)[../hooks/index.md] for available hooks.

Hooks provide an easy way to customize your build. Hooks are binary files located in your project directory at `./bin/hooks/` and are named `hookName` with a `.sh` extension added.
So the hook for `version-current` would be a file at:

    bin/hooks/version-current.sh

Sample hooks (scripts) can be found in the build source code at `./bin/hooks/`.

Default hooks (scripts) can be found in `bin/build/hooks/`

#### Usage

    runHook hookName [ arguments ... ]

#### Examples

version="$(runHook version-current)"

#### Exit codes

- `Any` - The hook exit code is returned if it is run
- `1` - is returned if the hook is not found

### `runOptionalHook` - Run a hook if it exists otherwise succeed

See `runHook`, the behavior is identical except exit code zero is returned if the hook is not found..

See (Hooks documentation)[../hooks/index.md] for available hooks.

Hooks provide an easy way to customize your build. Hooks are binary files located in your project directory at `./bin/hooks/` and are named `hookName` with a `.sh` extension added.
So the hook for `version-current` would be a file at:

    bin/hooks/version-current.sh

Sample hooks (scripts) can be found in the build source code at `./bin/hooks/`.

Default hooks (scripts) can be found in `bin/build/hooks/`

#### Usage

    runOptionalHook hookName [ arguments ... ]

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

#### Usage

    hasHook [ hookName ... ]

#### Arguments

- `hookName` - one or more hook names which must exist

#### Exit codes

- `0` - If all hooks exist

### `whichHook` - Find the path to a hook binary file

Does a hook exist in the local project?

Find the path to a hook. The search path is:

- `./bin/hooks/`
- `./bin/build/hooks/`

If a file named `hookName` with the extension `.sh` is found which is executable, it is output.

#### Usage

    whichHook hookName

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

Outputs the timing in Magenta optionally prefixed by a message in green

Outputs a nice colorful message showing the number of seconds elapsed as well as your custom message.

#### Usage

    reportTiming startOffset [ message ... ]

#### Arguments

- `startOffset` - Unix timestamp seconds of start timestamp
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

### `bigText` - smblock (regular)

smblock (regular)

▌  ▗   ▀▛▘     ▐
▛▀▖▄ ▞▀▌▌▞▀▖▚▗▘▜▀
▌ ▌▐ ▚▄▌▌▛▀ ▗▚ ▐ ▖
▀▀ ▀▘▗▄▘▘▝▀▘▘ ▘ ▀

smmono12 (--bigger)

▗▖     █       ▗▄▄▄▖
▐▌     ▀       ▝▀█▀▘           ▐▌
▐▙█▙  ██   ▟█▟▌  █   ▟█▙ ▝█ █▘▐███
▐▛ ▜▌  █  ▐▛ ▜▌  █  ▐▙▄▟▌ ▐█▌  ▐▌
▐▌ ▐▌  █  ▐▌ ▐▌  █  ▐▛▀▀▘ ▗█▖  ▐▌
▐█▄█▘▗▄█▄▖▝█▄█▌  █  ▝█▄▄▌ ▟▀▙  ▐▙▄
▝▘▀▘ ▝▀▀▀▘ ▞▀▐▌  ▀   ▝▀▀ ▝▀ ▀▘  ▀▀
        ▜█▛▘

#### Usage

    bigText [ --bigger ] Text to output

#### Exit codes

- `0` - Always succeeds

## Deployment tools


### `deployApplication` - Deploy an application from a deployment repository

Deploy an application from a deployment repository

#### Usage

    deployApplication deployHome deployVersion targetPackage applicationPath

#### Arguments

- `deployHome` - The deplpoyment repository home
- `deployVersion` - The version to deploy
- targetPackage -

#### Examples

deployApplication /var/www/DEPLOY 10c2fab1 app.tar.gz /var/www/apps/cool-app

#### Exit codes

- `0` - Always succeeds

### `undoDeployApplication` - _ _ _

_   _           _
    | | | |_ __   __| | ___
    | | | | '_  / _` |/ _ 
    | |_| | | | | (_| | (_) |
     ___/|_| |_|__,_|___/

Undo deplpying an application from a deployment repository

#### Usage

    undoDeployApplication deployHome deployVersion targetPackage applicationPath

#### Exit codes

- `0` - Always succeeds

### `deployNextVersion` - deployNextVersion deployHome versionName

deployNextVersion deployHome versionName

#### Exit codes

- `0` - Always succeeds

### `deployPreviousVersion` - deployPreviousVersion deployHome versionName

deployPreviousVersion deployHome versionName

#### Exit codes

- `0` - Always succeeds

### `deployHasVersion` - deployHasVersion deployHome versionName

deployHasVersion deployHome versionName

#### Exit codes

- `0` - Always succeeds

#### Exit codes

- `0` - Always succeeds

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
