## `fileCopy`

> Copy file from source to destination

### Usage

    fileCopy [ --map ] [ --escalate ] source destination

Copy file from source to destination
Supports mapping the file using the current environment, or escalated privileges.

### Arguments

- `--map` - Flag. Optional. Map environment values into file before copying.
- `--escalate` - Flag. Optional. The file is a privilege escalation and needs visual confirmation. Requires root privileges.
- `source` - File. Required. Source path
- `destination` - File. Required. Destination path

### Return codes

- `0` - Success
- `1` - Failed

