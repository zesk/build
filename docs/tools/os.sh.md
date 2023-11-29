# Operating System Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)


## `buildCacheDirectory` - Path to cache directory for build system.

Path to cache directory for build system.

Defaults to `$HOME/.build` unless `$HOME` is not a directory.

Appends any passed in arguments as path segments.

### Usage

    buildCacheDirectory [ pathSegment ... ]

### Arguments

- `pathSegment` - One or more directory or file path, concatenated as path segments using `/`

### Examples

logFile=$(buildCacheDirectory test.log)

### Exit codes

- `0` - Always succeeds

### Usage

    buildQuietLog name

### Arguments

- `name` - The log file name

### Exit codes

- `0` - Always succeeds


## `requireFileDirectory` - Given a list of files, ensure their parent directories exist

Given a list of files, ensure their parent directories exist

Creates the directories for all files passed in.

### Usage

    requireFileDirectory file1 file2 ...

### Arguments

- `name` - The log file name

### Examples

logFile=./.build/$me.log
    requireFileDirectory "$logFile"

### Exit codes

- `0` - Always succeeds

## `requireDirectory` - Given a list of files, ensure their parent directories exist

Given a list of files, ensure their parent directories exist

Creates the directories for all files passed in.

### Usage

    requireDirectory dir1 [ dir2 ... ]

### Examples

requireDirectory "$cachePath"

### Exit codes

- `0` - Always succeeds


## `runCount` - Run a binary count times

$Run a binary count times

### Usage

    runCount count binary [ args ... ]

### Arguments

- `count` - The number of times to run the binary
- `binary` - The binary to run
- `args ...` - Any arguments to pass to the binary each run

### Exit codes

- `0` - success
- `2` - `count` is not an unsigned number
- `Any` - If `binary` fails, the exit code is returned


## `renameFiles` - Rename a list of files usually to back them up temporarily

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

- `0` - Always succeeds


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


## `reverseFileLines` - Reverse output lines

Reverses a pipe's input lines to output using an awk trick.

### Exit codes

- `0` - Always succeeds

### Credits

Thanks to [Eric Pement](https://web.archive.org/web/20090208232311/http://student.northpark.edu/pemente/awk/awk1line.txt).


## `chmod-sh.sh` - Makes all `*.sh` files executable

Makes all `*.sh` files executable

### Usage

    makeShellFilesExecutable

### Exit codes

- `0` - Always succeeds

### Environment

Works from the current directory

## See Also

makeShellFilesExecutable


## `modificationTime` - Fetch the modification time of a file as a timestamp

Fetch the modification time of a file as a timestamp

### Usage

    modificationTime filename0 [ filename1 ... ]

### Examples

modificationTime ~/.bash_profile

### Exit codes

- `2` - If file does not existd
- `0` - If file exists and modification times are output, one per line


## `isNewestFile` - Check to see if the first file is the newest

Check to see if the first file is the newest one

If `sourceFile` is modified AFTER ALL `targetFile`s, return `0``
Otherwise return `1``

### Usage

    isNewestFile firstFile [ targetFile0 ... ]

### Arguments

- `sourceFile` - File to check
- `targetFile0` - One or more files to compare

### Exit codes

- `1` - `sourceFile`, 'targetFile' does not exist, or
- `0` - All files exist and `sourceFile` is the oldest file

## `isOldestFile` - Check to see if the first file is the newest

Check to see if the first file is the newest one

If `sourceFile` is modified AFTER ALL `targetFile`s, return `0``
Otherwise return `1``

### Usage

    isNewestFile firstFile [ targetFile0 ... ]

### Arguments

- `sourceFile` - File to check
- `targetFile0` - One or more files to compare

### Exit codes

- `1` - `sourceFile`, 'targetFile' does not exist, or
- `0` - All files exist and `sourceFile` is the oldest file


## `oldestFile` - Return the oldest file in the list.

Return the oldest file in the list.

### Usage

    oldestFile file0 [ file1 ... ]

### Arguments

- `file0` - One or more files to examine

### Exit codes

- `0` - Always succeeds

## `newestFile` - Return the newest file in the list

Return the newest file in the list

### Usage

    newestFile file0 [ file1 ... ]

### Arguments

- `file0` - One or more files to examine

### Exit codes

- `0` - Always succeeds

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)