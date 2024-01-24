# Operating System Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)


### `buildCacheDirectory` - Path to cache directory for build system.

Path to cache directory for build system.

Defaults to `$HOME/.build` unless `$HOME` is not a directory.

Appends any passed in arguments as path segments.

#### Arguments

- `pathSegment` - One or more directory or file path, concatenated as path segments using `/`

#### Examples

logFile=$(buildCacheDirectory test.log)

#### Exit codes

- `0` - Always succeeds

#### Arguments

- `name` - The log file name
- `--no-create` - Optional. Do not require creation of the directory where the log file will appear.

#### Exit codes

- `0` - Always succeeds


### `requireFileDirectory` - Given a list of files, ensure their parent directories exist

Given a list of files, ensure their parent directories exist

Creates the directories for all files passed in.

#### Examples

logFile=./.build/$me.log
    requireFileDirectory "$logFile"

#### Exit codes

- `0` - Always succeeds

### `requireDirectory` - Given a list of files, ensure their parent directories exist

Given a list of files, ensure their parent directories exist

Creates the directories for all files passed in.

#### Arguments

- `dir1` - One or more directories to create

#### Examples

requireDirectory "$cachePath"

#### Exit codes

- `0` - Always succeeds


### `runCount` - Run a binary count times

$Run a binary count times

#### Arguments

- `count` - The number of times to run the binary
- `binary` - The binary to run
- `args ...` - Any arguments to pass to the binary each run

#### Exit codes

- `0` - success
- `2` - `count` is not an unsigned number
- `Any` - If `binary` fails, the exit code is returned


### `renameFiles` - Rename a list of files usually to back them up temporarily

Renames "$file0$oldSuffix" to "$file0$newSuffix" if file exists and outputs a message using the actionVerb

If files do not exist, does nothing

Used to move files, temporarily, sometimes and then move back easily.

Renames files which have `oldSuffix` to then have `newSuffix` and output a message using `actionVerb`:

#### Arguments

- `oldSuffix` - Required. String. Old suffix to look rename from.
- `newSuffix` - Required. String. New suffix to rename to.
- `actionVerb` - Required. String. Description to output for found files.
- `file0` - Required. String. One or more files to rename, if found, renaming occurs.

#### Examples

renameFiles "" ".$$.backup" hiding etc/app.json etc/config.json
    ...
    renameFiles ".$$.backup" "" restoring etc/app.json etc/config.json

#### Exit codes

- `0` - Always succeeds


### `createTarFile` - Platform agnostic tar cfz which ignores owner and attributes

Platform agnostic tar cfz which ignores owner and attributes

`tar` command is not cross-platform so this differentiates between the GNU and BSD command line arguments without needing to know what operating system you are on. Creates a gz-compressed tar file (`.tgz` or `.tar.gz`) with user and group set to 0 and no extended attributes attached to the files.

#### Usage

    createTarFile target files

#### Arguments

- `target` - The tar.gz file to create
- `files` - A list of files to include in the tar file

#### Exit codes

- `0` - Always succeeds


### `environmentVariables` - Fetch a list of environment variable names

Output a list of environment variables and ignore function definitions

both `set` and `env` output functions and this is an easy way to just output
exported variables

Returns the list of defined environment variables exported in the current bash context.

#### Usage

    environmentVariables

#### Examples

for f in $(environmentVariables); do
    echo "$f"
    done

#### Sample Output

    Environment variable names, one per line.

#### Exit codes

- `0` - Always succeeds


### `reverseFileLines` - Reverse output lines

Reverses a pipe's input lines to output using an awk trick. Do not recommend on big files.

#### Exit codes

- `0` - Always succeeds

#### Credits

Thanks to [Eric Pement](https://web.archive.org/web/20090208232311/http://student.northpark.edu/pemente/awk/awk1line.txt).


### `chmod-sh.sh` - Makes all `*.sh` files executable

Makes all `*.sh` files executable

#### Arguments

- `findArguments` - Optional. Add arguments to exclude files or paths.

#### Exit codes

- `0` - Always succeeds

#### Environment

Works from the current directory

#### See Also

- [function makeShellFilesExecutable](./docs/tools/os.md) - [Makes all `*.sh` files executable](https://github.com/zesk/build/blob/main/bin/build/tools/os.sh#L233)


### `modificationTime` - Fetch the modification time of a file as a timestamp

Fetch the modification time of a file as a timestamp

#### Usage

    modificationTime filename0 [ filename1 ... ]

#### Examples

modificationTime ~/.bash_profile

#### Exit codes

- `2` - If file does not exist
- `0` - If file exists and modification times are output, one per line


### `isNewestFile` - Check to see if the first file is the newest

Check to see if the first file is the newest one

If `sourceFile` is modified AFTER ALL `targetFile`s, return `0``
Otherwise return `1``

#### Arguments

- `sourceFile` - File to check
- `targetFile0` - One or more files to compare

#### Exit codes

- `1` - `sourceFile`, 'targetFile' does not exist, or
- `0` - All files exist and `sourceFile` is the oldest file

### `isOldestFile` - Check to see if the first file is the newest

Check to see if the first file is the newest one

If `sourceFile` is modified AFTER ALL `targetFile`s, return `0``
Otherwise return `1``

#### Arguments

- `sourceFile` - File to check
- `targetFile0` - One or more files to compare

#### Exit codes

- `1` - `sourceFile`, 'targetFile' does not exist, or
- `0` - All files exist and `sourceFile` is the oldest file


### `oldestFile` - Return the oldest file in the list.

Return the oldest file in the list.

#### Arguments

- `file0` - One or more files to examine

#### Exit codes

- `0` - Always succeeds

### `newestFile` - Return the newest file in the list

Return the newest file in the list

#### Arguments

- `file0` - One or more files to examine

#### Exit codes

- `0` - Always succeeds


### `modifiedDays` - Prints days (integer) since modified

Prints days (integer) since modified

#### Exit codes

- `0` - Success
- `2` - Can not get modification time

### `modifiedSeconds` - Prints seconds since modified

Prints seconds since modified

#### Exit codes

- `0` - Success
- `2` - Can not get modification time


### `listFileModificationTimes` - Lists files in a directory recursively along with their modification

Lists files in a directory recursively along with their modification time in seconds.

Output is unsorted.

#### Arguments

- `directory - Required. Directory. Must exists` - directory to list.
- `findArgs` - Optional additional arguments to modify the find query

#### Examples

listFileModificationTimes $myDir ! -path '*/.*'

#### Sample Output

    1705347087 bin/build/tools.sh
    1704312758 bin/build/deprecated.sh
    1705442647 bin/build/build.json

#### Exit codes

- `0` - Always succeeds

### `mostRecentlyModifiedFile` - List the most recently modified file in a directory

List the most recently modified file in a directory

#### Arguments

- `directory - Required. Directory. Must exists` - directory to list.
- `findArgs` - Optional additional arguments to modify the find query

#### Exit codes

- `0` - Always succeeds

### `mostRecentlyModifiedTimestamp` - List the most recently modified file in a directory

List the most recently modified file in a directory

#### Arguments

- `directory - Required. Directory. Must exists` - directory to list.
- `findArgs` - Optional additional arguments to modify the find query

#### Exit codes

- `0` - Always succeeds


#### Arguments

- `--first` - Optional. Place any paths after this flag first in the list
- `--last` - Optional. Place any paths after this flag last in the list. Default.
- `path` - the path to be added to the `PATH` environment

#### Exit codes

- `0` - Always succeeds

### `pathCleanDuplicates` - Cleans the path and removes non-directory entries and duplicates

Cleans the path and removes non-directory entries and duplicates

Maintains ordering.

#### Usage

    pathCleanDuplicates

#### Exit codes

- `0` - Always succeeds


#### Arguments

- `--first` - Optional. Place any paths after this flag first in the list
- `--last` - Optional. Place any paths after this flag last in the list. Default.
- `path` - the path to be added to the `MANPATH` environment

#### Exit codes

- `0` - Always succeeds

#### Arguments

- `pathValue` - Required. Path value to modify.
- `separator` - Required. Separator string for path values (typically `:`)
- `--first` - Optional. Place any paths after this flag first in the list
- `--last` - Optional. Place any paths after this flag last in the list. Default.
- `path` - the path to be added to the `pathValue`

#### Exit codes

- `0` - Always succeeds


#### Exit codes

- `0` - Always succeeds


### `JSON` - Format something neatly as JSON

Format something neatly as JSON

#### Usage

    JSON < inputFile > outputFile

#### Exit codes

- `0` - Always succeeds


### `fileOwner` - Outputs the file owner for each file passed on the

Outputs the file owner for each file passed on the command line

#### Arguments

- `file` - File to get the owner for

#### Exit codes

- `0` - Success
- `1` - Unable to access file


### `processMemoryUsage` - Outputs value of resident memory used by a process, value

Outputs value of resident memory used by a process, value is in kilobytes

#### Arguments

- `pid` - Process ID of running process

#### Examples

> processMemoryUsage 23

#### Sample Output

    423

#### Exit codes

- `0` - Success
- `2` - Argument error

### `processVirtualMemoryAllocation` - Outputs value of virtual memory allocated for a process, value

Outputs value of virtual memory allocated for a process, value is in kilobytes

#### Arguments

- `pid` - Process ID of running process

#### Examples

processVirtualMemoryAllocation 23

#### Sample Output

    423

#### Exit codes

- `0` - Success
- `2` - Argument error

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
