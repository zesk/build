## `pipeRunner`

> Single reader, multiple writers

### Usage

    pipeRunner [ --mode mode ] [ namedPipe ] [ --writer line ... ] [ readerExecutable ... ]

Single reader, multiple writers
Attempt at having docker communicate back to the outside world.

### Arguments

- `--mode mode` - String. Optional.
- namedPipe
- `--writer line ...` - When encountered all additional arguments are written to the runner.
- `readerExecutable ...` - Callable. Optional.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

