# Sugar Core

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)

Sugar refers to syntactic sugar - code which makes other code more readable.

The functions are grouped as follows;

- `_` - Single underscore prefixed functions means "return" a failure value
- `__` - Double underscore prefixed functions means "run the command" and handle the failure value

Quick guide:

- `_exit message ...` - Exits with exit code 99 always. Outputs `message ...` to `stderr`. If `BUILD_DEBUG` environment is set to `true` will output debugging information. Should be used for script initialization which is critical, otherwise avoid it and use `_return`.
- `_return code message ...` - Return code always. Outputs `message ...` to `stderr`.
- `_environment message ...` - Return `$errorEnvironment` always. Outputs `message ...` to `stderr`.
- `_argument message ...` - Return `$errorArgument` always. Outputs `message ...` to `stderr`.
- `__execute command ...` - Run `command ...` (with any arguments) and then `_return` if it fails.
- `__try command ...` - Run `command ...` (with any arguments) and then `_exit` if it fails. Critical code only.
- `__echo command ...` - Output the `command ...` to stdout prior to running, then `__execute` it
- `__environment command ...` - Run `command ...` (with any arguments) and then `_environment` if it fails.
- `__argument command ...` - Run `command ...` (with any arguments) and then `_argument` if it fails.

# Sugar Functions References


### `_exit` - Critical exit `errorCritical` - exit immediately

Critical exit `errorCritical` - exit immediately

#### Exit codes

- `0` - Always succeeds

### `_return` - Return code always. Outputs `message ...` to `stderr`.

Return code always. Outputs `message ...` to `stderr`.

#### Arguments

- `code` - Integer. Required. Return code.
- `message ...` - String. Optional. Message to output.

#### Exit codes

- `0` - Always succeeds

### `_environment` - Return `$errorEnvironment` always. Outputs `message ...` to `stderr`.

Return `$errorEnvironment` always. Outputs `message ...` to `stderr`.

#### Arguments

- `message ...` - String. Optional. Message to output.

#### Exit codes

- 1

### `_argument` - Return `$errorArgument` always. Outputs `message ...` to `stderr`.

Return `$errorArgument` always. Outputs `message ...` to `stderr`.

#### Arguments

- `message ...` - String. Optional. Message to output.

#### Exit codes

- 2

### `__execute` - Run `command ...` (with any arguments) and then `_return` if

Run `command ...` (with any arguments) and then `_return` if it fails.

#### Arguments

- `command ...` - Any command and arguments to run.

#### Exit codes

- `0` - Always succeeds

### `__try` - Run `command ...` (with any arguments) and then `_exit` if

Run `command ...` (with any arguments) and then `_exit` if it fails. Critical code only.

#### Arguments

- `command ...` - Any command and arguments to run.

#### Exit codes

- None

### `__echo` - Output the `command ...` to stdout prior to running, then

Output the `command ...` to stdout prior to running, then `__execute` it

#### Arguments

- `command ...` - Any command and arguments to run.

#### Exit codes

- Any

### `__environment` - Run `command ...` (with any arguments) and then `_environment` if

Run `command ...` (with any arguments) and then `_environment` if it fails.

#### Arguments

- `command ...` - Any command and arguments to run.

#### Exit codes

- `0` - Success
- `1` - Failed

### `__argument` - Run `command ...` (with any arguments) and then `_argument` if

Run `command ...` (with any arguments) and then `_argument` if it fails.

#### Arguments

- `command ...` - Any command and arguments to run.

#### Exit codes

- `0` - Success
- `2` - Failed

## Decorations


### `_list` - Output a titled list

Output a titled list

#### Exit codes

- `0` - Always succeeds


[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
