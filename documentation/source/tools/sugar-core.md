# Sugar Core

<!-- TEMPLATE header 2 -->
[⬅ Parent ](../index.md)
<hr />

Sugar refers to syntactic sugar - code which makes other code more readable.

The functions are grouped as follows;

- `_` - Single underscore prefixed functions means "return" a failure value
- `__` - Double underscore prefixed functions means "run the command" and handle the failure value

Most functions are used in the form suffixed with `|| return $?` which takes the returned code and returns immediately
from the function.

    _return 1 "This failed" || return $?
    __argument isInteger "$1" || return $?

Alternately, these can be used within an `if` or other compound statement but the return code should be returned to the
user, typically.

Quick guide:

- `isPositiveInteger value` - Returns 0 if value passed is an integer, otherwise returns 1.
- `isBoolean value` - Returns 0 if value passed is `true` or `false`, otherwise returns 1.
- `_choose testValue trueValue falseValue` - Outputs `trueValue` when `[ "$testValue" = "true" ]` otherwise outputs
  `falseValue`.

Error codes:

- `_code name ...` - Exit codes. Outputs integers based on error names, one per line.

Return errors:

- `_return code message ...` - Return code always. Outputs `message ...` to `stderr`.
- `_environment message ...` - Return `1` always. Outputs `message ...` to `stderr`.
- `_argument message ...` - Return `2` always. Outputs `message ...` to `stderr`.

Run-related:

- `__execute command ...` - Run `command ...` (with any arguments) and then `_return` if it fails.
- `__echo command ...` - Output the `command ...` to stdout prior to running, then `__execute` it
- `__environment command ...` - Run `command ...` (with any arguments) and then `_environment` if it fails.
- `__argument command ...` - Run `command ...` (with any arguments) and then `_argument` if it fails.

# Sugar Functions References

## Sugar utilities

{isBoolean}

{returnCode}
{exitString}

{_choose}

## Cleanup

{returnClean}
{returnUndo}

## Fail with an error code

{_return} {_environment} {_argument}

## Run-related

{__execute} {__echo} {__environment} {__argument}
