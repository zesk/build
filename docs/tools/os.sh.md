# Operating System Functions

## `requireFileDirectory` - Given the path to a file, ensure the parent directory exists

Usage:

    requireFileDirectory file1 file2 ...

Creates the directories for all files passed in.

Environment:

- None


## `createTarFile` - Platform agnostic tar create which keeps user and group as user 0

`tar` command is not cross-platform so this differentiates between the GNU and BSD command line arguments without needing to know what operating system you are on. Creates a gz-compressed tar file (`.tgz` or `.tar.gz`) with user and group set to 0 and no extended attributes attached to the files.

Usage:

    createTarFile target files

### Arguments

- `target` - The tar.gz file to create
- `files` - A list of files to include in the tar file

## `aptUpdateOnce` - Do `apt-get update` once

Like it says

Usage:

    aptUpdateOnce

### Environment

Stores state files in `./.build/` directory which is created if it does not exist.

## `whichApt` - Install tools using `apt-get` if they are not found

Installs an apt package if a binary does not exist in the which path. The assumption here is that `aptInstallPackage` will install the desired `binary`.

Usage:

    whichApt binary aptInstallPackage

Examples:

    whichApt shellcheck shellcheck
    whichApt mariadb mariadb-client

If fails, runs `buildFailed` and outputs the log file.

Confirms that `binary` is installed after installation succeeds.

### Arguments

- `binary` - The binary to look for
- `aptInstallPackage` - The package name to install if the binary is not found in the `$PATH`.

### Environment

None.

...

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)