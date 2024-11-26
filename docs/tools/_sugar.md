# Sugar Core

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

Sugar refers to syntactic sugar - code which makes other code more readable.

The functions are grouped as follows;

- `_` - Single underscore prefixed functions means "return" a failure value
- `__` - Double underscore prefixed functions means "run the command" and handle the failure value

Most functions are used in the form suffixed with `|| return $?` which takes the returned code and returns immediately from the function.

    _return 1 "This failed" || return $?
    __argument isInteger "$1" || return $?

Alternately, these can be used within an `if` or other compound statement but the return code should be returned to the user, typically.

Quick guide:

- `isPositiveInteger value` - Returns 0 if value passed is an integer, otherwise returns 1.
- `_boolean value` - Returns 0 if value passed is `true` or `false`, otherwise returns 1.
- `_choose testValue trueValue falseValue` - Outputs `trueValue` when `[ "$testValue" = "true" ]` otherwise outputs `falseValue`.

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

## Sugar utilties


### `_integer` - Is this an unsigned integer?

Is this an unsigned integer?

#### Usage

    isPositiveInteger value
    

#### Exit codes

- `0` - if value is an unsigned integer
- `1` - if value is not an unsigned integer 
### `_boolean` - Boolean test

Boolean test
Returns 0 if `value` is boolean `false` or `true`.
Is this a boolean? (`true` or `false`)

#### Usage

    _boolean value
    

#### Exit codes

- `0` - if value is a boolean
- `1` - if value is not a boolean


### `_code` - Print one or more an exit codes by name.

Print one or more an exit codes by name.

Valid codes:

- `environment` - generic issue with environment
- `argument` - issue with arguments
- `assert` - assertion failed
- `identical` - identical check failed
- `leak` - function leaked globals
- `test` - test failed
- `exit` - exit function immediately
- `internal` - internal errors

Unknown error code is 254, end of range is 255 which is not used.

### Error codes reference (`_code`):

- 1 - environment or general error
- 2 - argument error
- 97 - **a**ssert - ASCII 97 = `a`
- 105 - **i**dentical - ASCII 105 = `i`
- 108 - **l**eak - ASCII 108 = `l`
- 116 - **t**est - ASCII 116 = `t`
- 120 - e**x**it - ASCII 120 = `x`
- 253 - internal
- 254 - unknown

#### Usage

    _code name ...
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

#### See Also

Not found


### `_choose` - Boolean selector

Boolean selector

#### Usage

    _choose testValue trueChoice falseChoice
    

#### Exit codes

- `0` - Always succeeds

## Fail with an error code


### `_return` - IDENTICAL _return 19

IDENTICAL _return 19

#### Usage

    _return [ exitCode [ message ... ] ]
    

#### Arguments



#### Exit codes

- exitCode 
### `_environment` - Return `$errorEnvironment` always. Outputs `message ...` to `stderr`.

Return `$errorEnvironment` always. Outputs `message ...` to `stderr`.

#### Usage

    _environment message ...
    

#### Arguments



#### Exit codes

- 1 
### `_argument` - Return `$errorArgument` always. Outputs `message ...` to `stderr`.

Return `$errorArgument` always. Outputs `message ...` to `stderr`.

#### Usage

    _argument message ..`.
    

#### Arguments



#### Exit codes

- 2

## Run-related


### `__execute` - Run `command ...` (with any arguments) and then `_return` if

Run `command ...` (with any arguments) and then `_return` if it fails.

#### Usage

    __execute command ...
    

#### Arguments



#### Exit codes

- `0` - Always succeeds 

### `__echo` - Output the `command ...` to stdout prior to running, then

Output the `command ...` to stdout prior to running, then `__execute` it

#### Usage

    __echo command ...
    

#### Arguments



#### Exit codes

- Any 
### `__environment` - Run `command ...` (with any arguments) and then `_environment` if

Run `command ...` (with any arguments) and then `_environment` if it fails.

#### Usage

    __environment command ...
    

#### Arguments



#### Exit codes

- `0` - Success
- `1` - Failed 
### `__argument` - Run `command ...` (with any arguments) and then `_argument` if

Run `command ...` (with any arguments) and then `_argument` if it fails.

#### Usage

    __argument command ...FUNCNAME
    

#### Arguments



#### Exit codes

- `0` - Success
- `2` - Failed

## Decorations


### `_list` - Output a titled list

Output a titled list

#### Usage

    _list title [ items ... ]
    

#### Exit codes

- `0` - Always succeeds 
#### Usage

    _format [ separator [ prefix [ suffix [ title [ item ... ] ] ] ]
    

#### Arguments



#### Exit codes

- `0` - Always succeeds 
### `_command` - Output a command, quoting individual arguments

Output a command, quoting individual arguments

#### Usage

    _command command [ argument ... ]
    

#### Exit codes

- `0` - Always succeeds
