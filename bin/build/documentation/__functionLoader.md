### `__functionLoader`

> Loads conditional code based on whether a function is defined

#### Usage

    __functionLoader prefix testFunction subdirectory handler function

Loads conditional code based on whether a function is defined yet
Argument ... - Arguments. Optional. Additional arguments to the function.

> Location: `bin/build/tools.sh`

#### Arguments

- `prefix` - ApplicationDirectory. Required. Relative path from the application directory to the subdirectory.
- `testFunction` - Function. Required. Function which MUST be defined in the subdirectory sources.
- `subdirectory` - RelativeDirectory. Required. Path added to `prefix` to load files.
- `handler` - Function. Required. Error handler.
- `function` - Function. Required. Function to call; first argument will be `handler`.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

