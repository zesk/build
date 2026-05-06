## `processMemoryUsage`

> Outputs value of resident memory used by a process, value

### Usage

    processMemoryUsage pid

Outputs value of resident memory used by a process, value is in kilobytes

> Location: `bin/build/tools/process.sh`

### Arguments

- `pid` - Integer. Required. Process ID of running process

### Examples

    > processMemoryUsage 23

### Sample Output

423

### Return codes

- `0` - Success
- `2` - Argument error

