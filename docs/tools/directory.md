# Directory Tools

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

### `directoryRelativePath` - Given a path to a file, compute the path back

Given a path to a file, compute the path back up to the top in reverse (../..)
If path is blank, outputs `.`.

Essentially converts the slash `/` to a `..`, so convert your source appropriately.

     directoryRelativePath "/" -> ".."
     directoryRelativePath "/a/b/c" -> ../../..

- Location: `bin/build/tools/directory.sh`

#### Arguments

- `directory` - String. A path to convert.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `isAbsolutePath` - Is a path an absolute path?

Is a path an absolute path?

- Location: `bin/build/tools/directory.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - if all paths passed in are absolute paths (begin with `/`).
- `1` - one ore more paths are not absolute paths
### `directoryIsEmpty` - Does a directory exist and is it empty?

Does a directory exist and is it empty?

- Location: `bin/build/tools/directory.sh`

#### Arguments

- No arguments.

#### Exit codes

- `2` - Directory does not exist
- `1` - Directory is not empty
- `0` - Directory is empty

### `fileDirectoryExists` - Does the file's directory exist?

Does the file's directory exist?

- Location: `bin/build/tools/directory.sh`

#### Arguments

- `directory` - Test if file directory exists (file does not have to exist)

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### `requireFileDirectory` - Given a list of files, ensure their parent directories exist

Given a list of files, ensure their parent directories exist

Creates the directories for all files passed in.

- Location: `bin/build/tools/directory.sh`

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

- Location: `bin/build/tools/directory.sh`

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

- Location: `bin/build/tools/directory.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### `__directoryParent` - Utility for specific implementations of `directoryParent`

Utility for specific implementations of `directoryParent`

- Location: `bin/build/tools/directory.sh`

#### Arguments

- `usageFunction` - Required. Function. Called when an error occurs.
- `startingDirectory` - Required. EmptyString|RealDirectory. Uses the current directory if blank.
- `--pattern filePattern` - Required. RelativePath. The file or directory to find the home for.
- `--test testExpression` - String. Optional. Zero or more. The `test` argument to test the targeted `filePattern`. By default uses `-d`.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### `directoryParent` - Finds a file above `startingDirectory`, uses `testExpression` to test (defaults

Finds a file above `startingDirectory`, uses `testExpression` to test (defaults to `-d`)

- Location: `bin/build/tools/directory.sh`

#### Arguments

- `startingDirectory` - Required. EmptyString|RealDirectory. Uses the current directory if blank.
- `--pattern filePattern` - Required. RelativePath. The file or directory to find the home for.
- `--test testExpression` - String. Optional. Zero or more. The `test` argument to test the targeted `filePattern`. By default uses `-d`.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
