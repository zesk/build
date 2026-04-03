## `iTerm2Download`

> Download an file from remote to terminal host

### Usage

    iTerm2Download [ file ] [ --name name ] [ --ignore | -i ]

Download an file from remote to terminal host
Argument:

### Arguments

- `file` - File. Optional. File to download.
- `--name name` - String. Optional. Target name of the file once downloaded.
--ignore |- ` -i` - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.

### Reads standard input

file

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

