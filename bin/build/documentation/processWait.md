## `processWait`

> Wait for processes not owned by this process to exit,

### Usage

    processWait processId [ --timeout seconds ] [ --signals signal ] [ --require ]

Wait for processes not owned by this process to exit, and send signals to terminate processes.

### Arguments

- `processId` - Integer. Required. Wait for process ID to exit.
- `--timeout seconds` - Integer. Optional. Wait for this long after sending a signals to see if a process exits. If not supplied waits 1 second after each signal, then waits forever.
- `--signals signal` - CommaDelimitedList. Optional. Send each signal to processes, in order.
- `--require` - Flag. Optional. Require all processes to be alive upon first invocation.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

