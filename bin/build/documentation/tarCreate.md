## `tarCreate`

> Platform agnostic tar cfz which ignores owner and attributes

### Usage

    tarCreate target [ files ]

Platform agnostic tar cfz which ignores owner and attributes
`tar` command is not cross-platform so this differentiates between the GNU and BSD command line arguments without needing to know what operating system you are on. Creates a gz-compressed tar file (`.tgz` or `.tar.gz`) with user and group set to 0 and no extended attributes attached to the files.

### Arguments

- `target` - FileDirectory. Required.The tar.gz file to create.
- `files` - File. Optional. A list of files to include in the tar file.

### Reads standard input

A list of files to include in the tar file

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

