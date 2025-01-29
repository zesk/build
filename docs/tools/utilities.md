# Utilites Functions

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

### `incrementor` - Set or increment a process-wide incrementor. If no numeric value

Set or increment a process-wide incrementor. If no numeric value is supplied the default is to increment the current value and output it.
New values are set to 0 by default so will output `1` upon first usage.
If no variable name is supplied it uses the default variable name `default`.

Variable names can contain alphanumeric characters, underscore, or dash.

Sets `default` incrementor to 1 and outputs `1`

    incrementor 1

Increments the `kitty` counter and outputs `1` on first call and `n + 1` for each subsequent call.

    incrementor kitty

Sets `kitty` incrementor to 2 and outputs `2`

    incrementor 2 kitty


- Location: `bin/build/tools/utilities.sh`

#### Usage

_mapEnvironment

#### Arguments

- `count` - Optional. Integer. Sets the value for any following named variables to this value.
- `variable` - Optional. String. Variable to change or increment.
- `--reset` - Optional. Flag. Reset all counters to zero.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Depends

    buildCacheDirectory
    
### `extensionLists` - Generates a directory containing files with `extension` as the file

Generates a directory containing files with `extension` as the file names.
All files passed to this are added to the `@` file, the `!` file is used for files without extensions.
Extension parsing is done by removing the final dot from the filename:
- `foo.sh` -> `"sh"`
- `foo.tar.gz` -> `"gz"`
- `foo.` -> `"!"``
- `foo-bar` -> `"!"``

- Location: `bin/build/tools/os.sh`

#### Usage

_mapEnvironment

#### Arguments

- `--help` - Optional. Flag. This help.
- `--clean` - Optional. Flag. Clean directory of all files first.
- `directory` - Required. Directory. Directory to create extension lists.
- `file0` - Optional. List of files to add to the extension list.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `pipeRunner` - Single reader, multiple writers

Single reader, multiple writers

- Location: `bin/build/tools/utilities.sh`

#### Usage

_mapEnvironment

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
