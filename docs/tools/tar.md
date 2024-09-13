# tar Functions

The ever-ready Tape Archive tool, still handy in 2024.

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

### `tarCreate` - Platform agnostic tar cfz which ignores owner and attributes

Platform agnostic tar cfz which ignores owner and attributes

`tar` command is not cross-platform so this differentiates between the GNU and BSD command line arguments without needing to know what operating system you are on. Creates a gz-compressed tar file (`.tgz` or `.tar.gz`) with user and group set to 0 and no extended attributes attached to the files.

- Location: `bin/build/tools/os.sh`

#### Usage

    tarCreate target files
    

#### Arguments

- `target` - The tar.gz file to create
- `files` - A list of files to include in the tar file

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `tarExtractPattern` - Platform agnostic tar extract with wildcards

Platform agnostic tar extract with wildcards

e.g. `tar -xf '*/file.json'` or `tar -xf --wildcards '*/file.json'` depending on OS

`tar` command is not cross-platform so this differentiates between the GNU and BSD command line arguments.

- Location: `bin/build/tools/tar.sh`

#### Arguments

- `pattern` - The file pattern to extract

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
