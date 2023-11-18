# Operating System Functions



## `requireFileDirectory` - Given a list of files, ensure their parent directories exist

Given a list of files, ensure their parent directories exist

Creates the directories for all files passed in.

### Usage

    requireFileDirectory file1 file2 ...

### Examples

    logFile=./.build/$me.log
    requireFileDirectory "$logFile"

### Exit codes

- `0` - Always succeeds

## `runCount` - Run a binary count times

$Run a binary count times

### Usage

    runCount count binary [ args ... ]

### Arguments

- `count` - The number of times to run the binary
- `binary` - The binary to run
- args - `...` - Any arguments to pass to the binary each run

### Exit codes

- `0` - success
- `2` - `count` is not an unsigned number
- `Any` - If `binary` fails, the exit code is returned

## `renameFiles` - Run a binary count times
Rename a list of files usually to back them up temporarily

Renames "$file0$oldSuffix" to "$file0$newSuffix" if file exists and outputs a message using the actionVerb

If files do not exist, does nothing

Used to move files, temporarily, sometimes and then move back easily.

Renames files which have `oldSuffix` to then have `newSuffix` and output a message using `actionVerb`:

### Usage

    renameFiles oldSuffix newSuffix actionVerb file0 [ file1 file2 ... ]

### Arguments

- `oldSuffix` - Required. String. Old suffix to look rename from.
- `newSuffix` - Required. String. New suffix to rename to.
- `actionVerb` - Required. String. Description to output for found files.
- `file0` - Required. String. One or more files to rename, if found, renaming occurs.

### Examples

    renameFiles "" ".$$.backup" hiding etc/app.json etc/config.json
    ...
    renameFiles ".$$.backup" "" restoring etc/app.json etc/config.json

### Exit codes

- `0` - success
- `2` - `count` is not an unsigned number
- `Any` - If `binary` fails, the exit code is returned

## `createTarFile` - Platform agnostic tar create which keeps user and group as user 0

Platform agnostic tar cfz which ignores owner and attributes

`tar` command is not cross-platform so this differentiates between the GNU and BSD command line arguments without needing to know what operating system you are on. Creates a gz-compressed tar file (`.tgz` or `.tar.gz`) with user and group set to 0 and no extended attributes attached to the files.

### Usage

    createTarFile target files

### Arguments

- `target` - The tar.gz file to create
- `files` - A list of files to include in the tar file

### Exit codes

- `0` - Always succeeds

## `aptUpdateOnce` - Do `apt-get update` once

Run apt-get update once and only once in the pipeline, at least
once an hour as well (when testing)

### Usage

    aptUpdateOnce

### Exit codes

- `0` - Always succeeds

### Environment

Stores state files in `./.build/` directory which is created if it does not exist.

## `whichApt` - Install tools using `apt-get` if they are not found

whichApt binary aptInstallPackage

Installs an apt package if a binary does not exist in the which path.
The assumption here is that `aptInstallPackage` will install the desired `binary`.

If fails, runs `buildFailed` and outputs the log file.

Confirms that `binary` is installed after installation succeeds.

### Usage

    whichApt binary aptInstallPackage

### Arguments

- `binary` - The binary to look for
- `aptInstallPackage` - The package name to install if the binary is not found in the `$PATH`.

### Examples

    whichApt shellcheck shellcheck
    whichApt mariadb mariadb-client

### Exit codes

- `0` - Always succeeds

### Environment

Technically this will install the binary and any related files as a package.

## `environmentVariables` - Fetch a list of environment variable names

Output a list of environment variables and ignore function definitions

both `set` and `env` output functions and this is an easy way to just output
exported variables

Returns the list of defined environment variables exported in the current bash context.

### Usage

    environmentVariables

### Examples

    for f in $(environmentVariables); do
        echo "$f"
    done

### Sample Output

Environment variable names, one per line.

### Exit codes

- `0` - Always succeeds

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)