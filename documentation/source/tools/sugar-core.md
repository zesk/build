# Sugar Core

<!-- TEMPLATE header 2 -->
[⬅ Parent ](../index.md)
<hr />

Sugar refers to syntactic sugar - code which makes other code more readable.

Most functions are used in the form suffixed with `|| return $?` which takes the returned code and returns immediately
from the function.

    returnMessage 1 "This failed" || return $?
    catchArgument "$handler" isInteger "$1" || return $?

Alternately, these can be used within an `if` or other compound statement but the return code should be returned to the
user, typically.

Quick guide:

- `isPositiveInteger value` - Returns 0 if value passed is an integer, otherwise returns 1.
- `isBoolean value` - Returns 0 if value passed is `true` or `false`, otherwise returns 1.
- `chooseBoolean testValue trueValue falseValue` - Outputs `trueValue` when `[ "$testValue" = "true" ]` otherwise
  outputs
  `falseValue`.

Error codes:

- `returnCode name ...` - Exit codes. Outputs integers based on error names, one per line.
- `returnCodeString integer ...` - Exit strings. Reverse of `returnCode`.

Return errors:

- `returnMessage code message ...` - Return `code` and outputs `message ...` to `stderr` IFF `code` is non-zero,
  otherwise output `message ...` to `stdout`.
- `returnEnvironment message ...` - Return `1` always. Outputs `message ...` to `stderr`.
- `returnArgument message ...` - Return `2` always. Outputs `message ...` to `stderr`.

Run-related:

- `execute command ...` - Run `command ...` (with any arguments) and then `_return` if it fails.
- `executeEcho command ...` - Output the `command ...` to stdout prior to running, then `execute` it (helpful to debug
  statements within other scripts)
- `catchEnvironment handler command ...` - Run `command ...` (with any arguments) and then run `handler` with an
  environment error if it fails.

# Sugar Functions References

## Sugar utilities

{isBoolean}

{booleanChoose}

{returnCode}

{returnCodeString}

## Cleanup

{returnClean}

{returnUndo}

## Fail with an error code

{returnMessage}

{returnEnvironment}

{returnArgument}

## Run-related

{execute}

{executeEcho}

{returnThrow}

{convertValue}

{catchCode}

{catchEnvironment}

{catchArgument}

{throwEnvironment}

{throwArgument}
