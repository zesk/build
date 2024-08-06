# File Tools

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

## Attributes 

### Modification time


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

### Owner Group Size Type


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

## Platform 


### `realPath` - IDENTICAL _realPath EOF

IDENTICAL _realPath EOF

#### Usage

    realPath argument
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

### `renameLink` - Renames a link forcing replacement, and works on different versions

Renames a link forcing replacement, and works on different versions of `mv` which differs between systems.

#### Usage

    renameLink from to
    

#### Exit codes

- `0` - Always succeeds

#### Usage

    simplifyPath path
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

## Utilities


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
