## `fileModificationSeconds`

> Fetch the modification time in seconds from now of a

### Usage

    fileModificationSeconds [ filename ... ]

Fetch the modification time in seconds from now of a file as a timestamp

### Arguments

- `filename ...` - File to fetch modification time

### Examples

    fileModificationTime ~/.bash_profile

### Return codes

- `2` - If file does not exist
- `0` - If file exists and modification times are output, one per line

