# File Tools

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

## Attributes 

### Modification time

### `modificationTime` - Fetch the modification time of a file as a timestamp

Fetch the modification time of a file as a timestamp

- Location: `bin/build/tools/file.sh`

#### Arguments

- No arguments.

#### Examples

    modificationTime ~/.bash_profile

#### Exit codes

- `2` - If file does not exist
- `0` - If file exists and modification times are output, one per line
### `modificationSeconds` - Fetch the modification time in seconds from now of a

Fetch the modification time in seconds from now of a file as a timestamp

- Location: `bin/build/tools/file.sh`

#### Arguments

- No arguments.

#### Examples

    modificationTime ~/.bash_profile

#### Exit codes

- `2` - If file does not exist
- `0` - If file exists and modification times are output, one per line
### `isEmptyFile` - Is this an empty (zero-sized) file?

Is this an empty (zero-sized) file?

- Location: `bin/build/tools/file.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - if all files passed in are empty files
- `1` - if any files passed in are non-empty files

### `isNewestFile` - Check to see if the first file is the newest

Check to see if the first file is the newest one

If `sourceFile` is modified AFTER ALL `targetFile`s, return `0``
Otherwise return `1``

- Location: `bin/build/tools/file.sh`

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

- Location: `bin/build/tools/file.sh`

#### Arguments

- `sourceFile` - File to check
- `targetFile0` - One or more files to compare

#### Exit codes

- `1` - `sourceFile`, 'targetFile' does not exist, or
- `0` - All files exist and `sourceFile` is the oldest file

### `oldestFile` - Return the oldest file in the list.

Return the oldest file in the list.

- Location: `bin/build/tools/file.sh`

#### Arguments

- `file0` - One or more files to examine

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `newestFile` - Return the newest file in the list

Return the newest file in the list

- Location: `bin/build/tools/file.sh`

#### Arguments

- `file0` - One or more files to examine

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### `modifiedDays` - Prints days (integer) since modified

Prints days (integer) since modified

- Location: `bin/build/tools/file.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `2` - Can not get modification time
### `modifiedSeconds` - Prints seconds since modified

Prints seconds since modified

- Location: `bin/build/tools/file.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `2` - Can not get modification time

### `listFileModificationTimes` - Lists files in a directory recursively along with their modification

Lists files in a directory recursively along with their modification time in seconds.

Output is unsorted.

- Location: `bin/build/tools/file.sh`

#### Arguments

- `directory - Required. Directory. Must exists` - directory to list.
- `findArgs` - Optional additional arguments to modify the find query

#### Examples

listFileModificationTimes $myDir ! -path "*/.*/*"

#### Sample Output

    1705347087 bin/build/tools.sh
    1704312758 bin/build/deprecated.sh
    1705442647 bin/build/build.json
    

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `mostRecentlyModifiedFile` - List the most recently modified file in a directory

List the most recently modified file in a directory

- Location: `bin/build/tools/file.sh`

#### Arguments

- `directory - Required. Directory. Must exists` - directory to list.
- `findArgs` - Optional additional arguments to modify the find query

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `mostRecentlyModifiedTimestamp` - List the most recently modified timestamp in a directory

List the most recently modified timestamp in a directory

- Location: `bin/build/tools/file.sh`

#### Arguments

- `directory - Required. Directory. Must exists` - directory to list.
- `findArgs` - Optional additional arguments to modify the find query

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### `directoryNewestFile` - Find the newest file in a directory

Find the newest file in a directory

- Location: `bin/build/tools/file.sh`

#### Arguments

- `directory` - Directory. Required. Directory to search for the newest file.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `directoryOldestFile` - Find the oldest file in a directory

Find the oldest file in a directory

- Location: `bin/build/tools/file.sh`

#### Arguments

- `directory` - Directory. Required. Directory to search for the oldest file.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Owner Group Size Type

### `fileOwner` - Outputs the file owner for each file passed on the

Outputs the file owner for each file passed on the command line

- Location: `bin/build/tools/file.sh`

#### Arguments

- `file` - File to get the owner for

#### Exit codes

- `0` - Success
- `1` - Unable to access file
### `fileGroup` - Outputs the file group for each file passed on the

Outputs the file group for each file passed on the command line

- Location: `bin/build/tools/file.sh`

#### Arguments

- `file` - File to get the owner for

#### Exit codes

- `0` - Success
- `1` - Unable to access file
### `fileSize` - Outputs value of virtual memory allocated for a process, value

Outputs value of virtual memory allocated for a process, value is in kilobytes

- Location: `bin/build/tools/file.sh`

#### Arguments

- `file` - Required. File to get size of.

#### Exit codes

- `0` - Success
- `1` - Environment error
### `betterType` - Better type handling of shell objects

Better type handling of shell objects

Outputs one of `type` output or enhancements:
- `builtin`. `function`, `alias`, `file`
- `link-directory`, `link-file`, `directory`, `integer`, `unknown`

- Location: `bin/build/tools/file.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## Platform 

### `realPath` - undocumented

No documentation for `realPath`.

- Location: `bin/build/install-bin-build.sh`

#### Arguments

- `file ...` - Required. File. One or more files to `realpath`.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `renameLink` - Renames a link forcing replacement, and works on different versions

Renames a link forcing replacement, and works on different versions of `mv` which differs between systems.

- Location: `bin/build/tools/file.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `simplifyPath` - Normalizes segments of `/./` and `/../` in a path without

Normalizes segments of `/./` and `/../` in a path without using `realPath`
Removes dot and dot-dot paths from a path correctly

- Location: `bin/build/tools/file.sh`

#### Arguments

- `path ...` - Required. File. One or more paths to simplify

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## Utilities

### `fileTemporaryName` - Generate a temporary file name using mktemp, and fail using

Generate a temporary file name using mktemp, and fail using a function

- Location: `bin/build/install-bin-build.sh`

#### Arguments

- `usage` - Function. Required. Function to call if mktemp fails
- `--help` - Optional. Flag. Display this help.
- `...` - Optional. Arguments. Any additional arguments are passed through to mktemp.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `renameFiles` - Rename a list of files usually to back them up temporarily

Renames "$file0$oldSuffix" to "$file0$newSuffix" if file exists and outputs a message using the actionVerb

If files do not exist, does nothing

Used to move files, temporarily, sometimes and then move back easily.

Renames files which have `oldSuffix` to then have `newSuffix` and output a message using `actionVerb`:

- Location: `bin/build/tools/file.sh`

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

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `reverseFileLines` - Reverse output lines

Reverses a pipe's input lines to output using an awk trick.

Not recommended on big files.

- Location: `bin/build/install-bin-build.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Depends

    awk
    

#### Credits

Thanks to [Eric Pement](https://web.archive.org/web/20090208232311/http://student.northpark.edu/pemente/awk/awk1line.txt).

## Finding

### `fileMatches` - Find one or more patterns in a list of files,

Find one or more patterns in a list of files, with a list of file name pattern exceptions.

- Location: `bin/build/tools/file.sh`

#### Arguments

- `--help` - Optional. Flag. Display this help.
- `pattern ...` - Required. String. Pattern to find in files. No quoting is added so ensure these are compatible with `grep -e`.
- `--` - Required. Delimiter. exception.
- `exception ...` - Optional. String. File pattern which should be ignored.
- `--` - Required. Delimiter. file.
- `file ...` - Required. File. File to search. Special file `-` indicates files should be read from `stdin`.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `fileNotMatches` - Find list of files which do NOT match a specific

Find list of files which do NOT match a specific pattern or patterns and output them

- Location: `bin/build/tools/file.sh`

#### Arguments

- `--help` - Optional. Flag. Display this help.
- `pattern ...` - Required. String. Pattern to find in files.
- `--` - Required. Delimiter. exception.
- `exception ...` - Optional. String. File pattern which should be ignored.
- `--` - Required. Delimiter. file.
- `file ...` - Required. File. File to search. Special file `-` indicates files should be read from `stdin`.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error 

## Links

### `linkCreate` - Create a link

Create a link

- Location: `bin/build/tools/file.sh`

#### Arguments

- `target` - Exists. File. Source file name or path.
- `linkName` - String. Required. Link short name, created next to `target`.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
