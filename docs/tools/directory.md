# Directory Tools

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

### `isAbsolutePath` - Is a path an absolute path?

Is a path an absolute path?

#### Arguments

- No arguments.

#### Exit codes

- `0` - if all paths passed in are absolute paths (begin with `/`).
- `1` - one ore more paths are not absolute paths
### `directoryIsEmpty` - Does a directory exist and is it empty?

Does a directory exist and is it empty?

#### Arguments

- No arguments.

#### Exit codes

- `2` - Directory does not exist
- `1` - Directory is not empty
- `0` - Directory is empty

### `fileDirectoryExists` - Does the file's directory exist?

Does the file's directory exist?

#### Arguments

- `directory` - Test if file directory exists (file does not have to exist)

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### `requireFileDirectory` - Given a list of files, ensure their parent directories exist

Given a list of files, ensure their parent directories exist

Creates the directories for all files passed in.

#### Arguments

- No arguments.

#### Examples

    logFile=./.build/$me.log
    requireFileDirectory "$logFile"

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `requireDirectory` - Given a list of directories, ensure they exist and create

Given a list of directories, ensure they exist and create them if they do not.

#### Arguments

- `dir1` - One or more directories to create

#### Examples

    requireDirectory "$cachePath"

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### `directoryClobber` - Copy directory over another sort-of-atomically

Copy directory over another sort-of-atomically

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
