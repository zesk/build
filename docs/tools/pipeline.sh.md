# Pipeline Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)

## `runHook` - Run a project hook

Hooks provide an easy way to customize your build. Hooks are binary files located in your project directory at `./bin/hooks/` and are named `hookName` with a `.sh` extension added.

So the hook for `version-current` would be a file at:

    bin/hook/version-current.sh

Sample scripts can be found in the build source code at `./bin/hooks/`.

### Usage

   runHook hookName [ arguments ... ]

### Exit codes

- The hook exit code is returned if it is run
- 1 - is returned if the hook is not found

### Examples

    version="$(runHook version-current)"

### Environment

Varies.

## `runOptionalHook` - Run a hook if it exists otherwise succeed.

See `runHook`, the behavior is identical except exit code zero is returned if the hook is not found.

### Usage

   runOptionalHook hookName [ arguments ... ]

### Arguments

- `hookName` - the name of the hook to run
- `...` - Additional
### Exit codes

- The hook exit code is returned if it is run
- 0 - is returned if the hook is not found

### Examples

    if ! runOptionalHook test-cleanup >>"$quietLog"; then
        buildFailed "$quietLog"
    fi

### Environment

Varies.

## `hasHook` - Determine if a hook exists

Check if one or more hook exists. All hooks must exist to succeed.
### Usage

    hasHook [ hookName ... ]

### Arguments

- `hookName` - one or more hook names which must exist

## `whichHook` - Find the path to a hook binary file

Find the path to a hook. The search path is:

- `./bin/hooks/`
- `./bin/build/hooks/`

If a file named `hookName` with the extension `.sh` is found which is executable, it is run.

### Usage

    whichHook hookName
### Arguments

- `hookName` - Hook to locate

## `beginTiming` - Start a timer for a section of the build

Outputs the offset in seconds from January 1, 1970.

### Usage

    beginTiming

### Arguments

None.

### Example

    init=$(beginTiming)
    ...
    reportTiming "$init" "Completed in"


## `reportTiming` - Output the time elapsed

Outputs a nice colorful message showing the number of seconds elapsed as well as your custom message.

### Usage:

    reportTiming startOffset [ message ... ]

### Arguments

- `startOffset` - Unix timestamp seconds of start timestamp
- `message` - Any additional arguments are output before the elapsed value computed

### Exit codes

- 0 - Exits with exit code zero

### Examples

    init=$(beginTiming)
    ...
    reportTiming "$init" "Deploy completed in"

### Environment

None.

## `buildFailed` - Output debugging information when the build fails

Outputs debugging information after build fails:

- last 50 lines in build log
- Failed message
- last 3 lines in build log

### Usage:

    buildFailed logFile

### Arguments

- `logFile` - the most recent log from the current script


### Example

    quietLog=./bin/build/$me.log; requireFileDirectory "$quietLog"
    if ! ./bin/deploy.sh >>"$quietLog"; then
        consoleError "Deploy failed"
        buildFailed "$quietLog"
    fi

### Environment:

None.

## `versionSort` - Sort versions in the format v0.0.0

Sorts semantic versions prefixed with a `v` character; intended to be used as a pipe.

### Usage

    versionSort [ -r ]

### Arguments

- `-r` - Reverse the sort order (optional)

### Environment

None.

### Examples

    git tag | grep -e '^v[0-9.]*$' | versionSort

## `dotEnvConfigure` - Load `.env` and optional `.env.local` into bash context

Requires the file `.env` to exist and is loaded via bash `source` and all variables are `export`ed in the current shell context.

If `.env.local` exists, it is also loaded in a similar manner.

The previous version of this function was `dotEnvConfig` and is now deprecated, and outputs a warning.

### Usage:

    dotEnvConfigure

### Arguments:

None

## Environment

Loads `./.env` and `./.env.local`, use with caution.

### Exit codes

- 1 - if `.env` does not exist; outputs an error
- 0 - if files are loaded successfully

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)