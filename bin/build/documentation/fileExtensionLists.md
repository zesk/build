## `fileExtensionLists`

> Generates a directory containing files with `extension` as the file

### Usage

    fileExtensionLists [ --clean ] directory [ file0 ... ] [ --help ]

Generates a directory containing files with `extension` as the file names.
All files passed to this are added to the `@` file, the `!` file is used for files without extensions.
Extension parsing is done by removing the final dot from the filename:
- `foo.sh` -> `"sh"`
- `foo.tar.gz` -> `"gz"`
- `foo.` -> `"!"``
- `foo-bar` -> `"!"``

### Arguments

- `--clean` - Flag. Optional. Clean directory of all files first.
- `directory` - Directory. Required. Directory to create extension lists.
- `file0 ...` - String. Optional. List of files to add to the extension list.
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

