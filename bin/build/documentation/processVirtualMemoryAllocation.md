## `processVirtualMemoryAllocation`

> Outputs value of virtual memory allocated for a process, value

### Usage

    processVirtualMemoryAllocation [ --help ] [ pid ]

Outputs value of virtual memory allocated for a process, value is in kilobytes

### Arguments

- `--help` - Flag. Optional. Display this help.
- `pid` - Process ID of running process

### Examples

    processVirtualMemoryAllocation 23

### Sample Output

423

### Return codes

- `0` - Success
- `2` - Argument error

