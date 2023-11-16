# Operating System Functions

{runCount}

## `requireFileDirectory` - Given the path to a file, ensure the parent directory exists

Usage:

    requireFileDirectory file1 file2 ...

Creates the directories for all files passed in.

### Examples

    logFile=./.build/$me.log

    requireFileDirectory "$logFile"

### Environment:

- None

## `renameFiles` - Rename a list of files usually to back them up temporarily

Renames files which have `oldSuffix` to then have `newSuffix` and output a message using `actionVerb`:

### Usage:

    renameFiles oldSuffix newSuffix actionVerb file0 [ file1 ... ]

### Examples:

    renameFiles "" ".$$.backup" hiding etc/app.json etc/config.json
    ...
    renameFiles ".$$.backup" "" restoring etc/app.json etc/config.json

## `createTarFile` - Platform agnostic tar create which keeps user and group as user 0

`tar` command is not cross-platform so this differentiates between the GNU and BSD command line arguments without needing to know what operating system you are on. Creates a gz-compressed tar file (`.tgz` or `.tar.gz`) with user and group set to 0 and no extended attributes attached to the files.

### Usage:

    createTarFile target files

### Arguments

- `target` - The tar.gz file to create
- `files` - A list of files to include in the tar file

## `aptUpdateOnce` - Do `apt-get update` once

Like it says

### Usage:

    aptUpdateOnce

### Environment

Stores state files in `./.build/` directory which is created if it does not exist.

## `whichApt` - Install tools using `apt-get` if they are not found

Installs an apt package if a binary does not exist in the which path. The assumption here is that `aptInstallPackage` will install the desired `binary`.

### Usage:

    whichApt binary aptInstallPackage

### Examples:

    whichApt shellcheck shellcheck
    whichApt mariadb mariadb-client

If fails, runs `buildFailed` and outputs the log file.

Confirms that `binary` is installed after installation succeeds.

### Arguments

- `binary` - The binary to look for
- `aptInstallPackage` - The package name to install if the binary is not found in the `$PATH`.

### Environment

Technically this will install the binary and any related files as a package.

## `environmentVariables` - Fetch a list of environment variable names

Returns the list of defined environment variables exported in the current bash context.

### Usage

    environmentVariables

### Arguments

None.

### Exit codes

Zero

### Output

Environment variable names, one per line.

### Examples

    for f in $(environmentVariables); do
        echo "$f"
    done

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)