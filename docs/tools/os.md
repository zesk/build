# Operating System Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)

## Environment Files


### `buildEnvironmentLoad` - Load one or more environment settings from bin/build/env or bin/env.

Load one or more environment settings from bin/build/env or bin/env.


If BOTH files exist, both are sourced, so application environments should anticipate values
created by default.

#### Usage

    buildEnvironmentLoad [ envName ... ]
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

### `environmentNames` - List names of environment values set in a bash state

List names of environment values set in a bash state file

#### Usage

    environmentNames < "$stateFile"
    

#### Exit codes

- `0` - Always succeeds

### `environmentValueRead` - Read a value safely from a environment file

Read a value safely from a environment file

#### Exit codes

- `0` - Always succeeds

### `environmentValueWrite` - Write a value to a state file as NAME="value"

Write a value to a state file as NAME="value"

#### Exit codes

- `0` - Always succeeds

### `environmentVariables` - Output a list of environment variables and ignore function definitions

Output a list of environment variables and ignore function definitions

both `set` and `env` output functions and this is an easy way to just output
exported variables

#### Usage

    environmentVariables
    

#### Exit codes

- `0` - Always succeeds

## Services


### `isAbsolutePath` - Is a path an absolute path?

Is a path an absolute path?

#### Usage

    isAbsolutePath path ...
    

#### Exit codes

- `0` - if all paths passed in are absolute paths (begin with `/`).
- `1` - one ore more paths are not absolute paths


### `whichExists` - IDENTICAL whichExists EOF

IDENTICAL whichExists EOF

#### Usage

    whichExists binary ...
    

#### Arguments



#### Exit codes

- `0` - If all values are found


### `serviceToPort` - Get the port number associated with a service

Get the port number associated with a service

#### Usage

    serviceToPort service [ ... ]
    

#### Arguments



#### Sample Output

    Port number of associated service (integer) one per line
    

#### Exit codes

- `1` - service not found
- `2` - bad argument or invalid port
- `0` - service found and output is an integer

### `serviceToStandardPort` - Hard-coded services for:

Hard-coded services for:

- `ssh` -> 22
- `http`-> 80
- `https`-> 80
- `postgres`-> 5432
- `mariadb`-> 3306
- `mysql`-> 3306

Backup when `/etc/services` does not exist.

#### Usage

    serviceToStandardPort service [ ... ]
    

#### Arguments



#### Sample Output

    Port number of associated service (integer) one per line
    

#### Exit codes

- `1` - service not found
- `0` - service found and output is an integer

#### See Also

{SEE:serviceToPort}

## Caching


### `buildCacheDirectory` - Path to cache directory for build system.

Path to cache directory for build system.

Defaults to `$HOME/.build` unless `$HOME` is not a directory.

Appends any passed in arguments as path segments.

#### Usage

    buildCacheDirectory [ pathSegment ... ]
    

#### Arguments



#### Examples

    logFile=$(buildCacheDirectory test.log)

#### Exit codes

- `0` - Always succeeds

#### Usage

    buildQuietLog name
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

## File manipulation


### `fileDirectoryExists` - Does the file's directory exist?

Does the file's directory exist?

#### Usage

    fileDirectoryExists directory
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

### `renameFiles` - Rename a list of files usually to back them up temporarily

Renames "$file0$oldSuffix" to "$file0$newSuffix" if file exists and outputs a message using the actionVerb

If files do not exist, does nothing

Used to move files, temporarily, sometimes and then move back easily.

Renames files which have `oldSuffix` to then have `newSuffix` and output a message using `actionVerb`:

#### Usage

    renameFiles oldSuffix newSuffix actionVerb file0 [ file1 file2 ... ]
    

#### Arguments



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



#### Exit codes

- `0` - Always succeeds

### `reverseFileLines` - Reverse output lines

Reverses a pipe's input lines to output using an awk trick. Do not recommend on big files.

#### Exit codes

- `0` - Always succeeds

#### Credits

Thanks to [Eric Pement](https://web.archive.org/web/20090208232311/http://student.northpark.edu/pemente/awk/awk1line.txt).

### `modificationTime` - Fetch the modification time of a file as a timestamp

Fetch the modification time of a file as a timestamp

#### Usage

    modificationTime filename0 [ filename1 ... ]
    

#### Examples

    modificationTime ~/.bash_profile

#### Exit codes

- `2` - If file does not exist
- `0` - If file exists and modification times are output, one per line

### `modificationSeconds` - Fetch the modification time in seconds from now of a

Fetch the modification time in seconds from now of a file as a timestamp

#### Usage

    modificationSeconds filename0 [ filename1 ... ]
    

#### Examples

    modificationTime ~/.bash_profile

#### Exit codes

- `2` - If file does not exist
- `0` - If file exists and modification times are output, one per line


### `isNewestFile` - Check to see if the first file is the newest

Check to see if the first file is the newest one

If `sourceFile` is modified AFTER ALL `targetFile`s, return `0``
Otherwise return `1``

#### Usage

    isNewestFile firstFile [ targetFile0 ... ]
    

#### Arguments



#### Exit codes

- `1` - `sourceFile`, 'targetFile' does not exist, or
- `0` - All files exist and `sourceFile` is the oldest file

### `isOldestFile` - Check to see if the first file is the newest

Check to see if the first file is the newest one

If `sourceFile` is modified AFTER ALL `targetFile`s, return `0``
Otherwise return `1``

#### Usage

    isOldestFile firstFile [ targetFile0 ... ]
    

#### Arguments



#### Exit codes

- `1` - `sourceFile`, 'targetFile' does not exist, or
- `0` - All files exist and `sourceFile` is the oldest file


### `oldestFile` - Return the oldest file in the list.

Return the oldest file in the list.

#### Usage

    oldestFile file0 [ file1 ... ]
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

### `newestFile` - Return the newest file in the list

Return the newest file in the list

#### Usage

    newestFile file0 [ file1 ... ]
    

#### Arguments



#### Exit codes

- `0` - Always succeeds


### `modifiedDays` - Prints days (integer) since modified

Prints days (integer) since modified

#### Exit codes

- `0` - Success
- `2` - Can not get modification time

### `modifiedSeconds` - Prints seconds since modified

Prints seconds since modified

#### Usage

    modifiedSeconds file
    

#### Exit codes

- `0` - Success
- `2` - Can not get modification time


### `listFileModificationTimes` - Lists files in a directory recursively along with their modification

Lists files in a directory recursively along with their modification time in seconds.

Output is unsorted.

#### Usage

    listFileModificationTimes directory [ findArgs ... ]
    

#### Arguments



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

#### Usage

    mostRecentlyModifiedFile directory [ findArgs ... ]
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

### `mostRecentlyModifiedTimestamp` - List the most recently modified timestamp in a directory

List the most recently modified timestamp in a directory

#### Usage

    mostRecentlyModifiedTimestamp directory [ findArgs ... ]
    

#### Arguments



#### Exit codes

- `0` - Always succeeds


### `fileOwner` - Outputs the file owner for each file passed on the

Outputs the file owner for each file passed on the command line

#### Usage

    fileOwner file ...
    

#### Arguments



#### Exit codes

- `0` - Success
- `1` - Unable to access file

### `fileGroup` - Outputs the file group for each file passed on the

Outputs the file group for each file passed on the command line

#### Usage

    fileGroup file ...
    

#### Arguments



#### Exit codes

- `0` - Success
- `1` - Unable to access file

### `fileSize` - Outputs value of virtual memory allocated for a process, value

Outputs value of virtual memory allocated for a process, value is in kilobytes

#### Usage

    fileSize file
    

#### Arguments



#### Exit codes

- `0` - Success
- `1` - Environment error

### `betterType` - Better type handling of shell objects

Better type handling of shell objects

Outputs one of `type` output or enhancements:
- `builtin`. `function`, `alias`, `file`
- `link-directory`, `link-file`, `directory`, `integer`, `unknown`

#### Usage

    betterType [ thing ]
    

#### Exit codes

- `0` - Always succeeds

## Directory Manipulation


### `requireFileDirectory` - Given a list of files, ensure their parent directories exist

Given a list of files, ensure their parent directories exist

Creates the directories for all files passed in.

#### Usage

    requireFileDirectory file1 file2 ...
    

#### Examples

    logFile=./.build/$me.log
    requireFileDirectory "$logFile"

#### Exit codes

- `0` - Always succeeds

### `requireDirectory` - Given a list of directories, ensure they exist and create

Given a list of directories, ensure they exist and create them if they do not.

#### Usage

    requireDirectory dir1 [ dir2 ... ]
    

#### Arguments



#### Examples

    requireDirectory "$cachePath"

#### Exit codes

- `0` - Always succeeds


### `directoryClobber` - Copy directory over another sort-of-atomically

Copy directory over another sort-of-atomically

#### Usage

    directoryClobber source target
    

#### Exit codes

- `0` - Always succeeds

### `directoryIsEmpty` - Does a directory exist and is it empty?

Does a directory exist and is it empty?

#### Usage

    directoryIsEmpty directory
    

#### Exit codes

- `2` - Directory does not exist
- `1` - Directory is not empty
- `0` - Directory is empty

## Execution


### `runCount` - Run a binary count times

$\Run a binary count times

#### Usage

    runCount count binary [ args ... ]
    

#### Arguments



#### Exit codes

- `0` - success
- `2` - `count` is not an unsigned number
- `Any` - If `binary` fails, the exit code is returned

### `/var/folders/6r/r9y5y7f51q592kr56jyz4gh80000z_/T/tmp.Nfp1tMlULT chmod-sh.sh` - Makes all `*.sh` files executable

Makes all `*.sh` files executable

#### Usage

    /var/folders/6r/r9y5y7f51q592kr56jyz4gh80000z_/T/tmp.Nfp1tMlULT chmod-sh.sh [ findArguments ... ]
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

#### Environment

Works from the current directory

#### See Also

{SEE:makeShellFilesExecutable}

## Modify PATH or MANPATH


#### Usage

    pathConfigure [ --first | --last | path ] ...
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

#### Usage

    manPathConfigure [ --first | --last | path ] ...
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

## Path manipulation


#### Usage

    pathAppend pathValue separator [ --first | --last | path ]
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

### `pathCleanDuplicates` - Cleans the path and removes non-directory entries and duplicates

Cleans the path and removes non-directory entries and duplicates

Maintains ordering.

#### Usage

    pathCleanDuplicates
    

#### Exit codes

- `0` - Always succeeds

### `realPath` - IDENTICAL _realPath EOF

IDENTICAL _realPath EOF

#### Usage

    realPath argument
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

### `renameLink` - Uses mv and clobbers always

Uses mv and clobbers always

#### Usage

    renameLink from to
    

#### Exit codes

- `0` - Always succeeds

## Memory


### `processMemoryUsage` - Outputs value of resident memory used by a process, value

Outputs value of resident memory used by a process, value is in kilobytes

#### Usage

    processMemoryUsage pid
    

#### Arguments



#### Examples

    > processMemoryUsage 23

#### Sample Output

    423
    

#### Exit codes

- `0` - Success
- `2` - Argument error

### `processVirtualMemoryAllocation` - Outputs value of virtual memory allocated for a process, value

Outputs value of virtual memory allocated for a process, value is in kilobytes

#### Usage

    processVirtualMemoryAllocation pid
    

#### Arguments



#### Examples

    processVirtualMemoryAllocation 23

#### Sample Output

    423
    

#### Exit codes

- `0` - Success
- `2` - Argument error

## Miscellaneous


### `JSON` - Format something neatly as JSON

Format something neatly as JSON

#### Usage

    JSON < inputFile > outputFile
    

#### Exit codes

- `0` - Always succeeds


[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
