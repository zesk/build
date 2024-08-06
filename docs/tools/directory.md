# Directory Tools

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />


### `isAbsolutePath` - Is a path an absolute path?

Is a path an absolute path?

#### Usage

    isAbsolutePath path ...
    

#### Exit codes

- `0` - if all paths passed in are absolute paths (begin with `/`).
- `1` - one ore more paths are not absolute paths

### `directoryIsEmpty` - Does a directory exist and is it empty?

Does a directory exist and is it empty?

#### Usage

    directoryIsEmpty directory
    

#### Exit codes

- `2` - Directory does not exist
- `1` - Directory is not empty
- `0` - Directory is empty


### `fileDirectoryExists` - Does the file's directory exist?

Does the file's directory exist?

#### Usage

    fileDirectoryExists directory
    

#### Arguments



#### Exit codes

- `0` - Always succeeds


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
