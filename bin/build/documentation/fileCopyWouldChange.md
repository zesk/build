## `fileCopyWouldChange`

> Check whether copying a file would change it

### Usage

    fileCopyWouldChange [ --map ] source destination

Check whether copying a file would change it
This function does not modify the source or destination.

### Arguments

- `--map` - Flag. Optional. Map environment values into file before copying.
- `source` - File. Required. Source path
- `destination` - File. Required. Destination path

### Return codes

- `0` - Something would change
- `1` - Nothing would change

