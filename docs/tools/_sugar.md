# Sugar Core

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)

Sugar refers to syntactic sugar - code which makes other code more readable.

The functions are grouped as follows;

- `_` - Single underscore prefixed functions means "return" a failure value
- `__` - Double underscore prefixed functions means "run the command" and handle the failure value

Most functions are used in the form suffixed with `|| return $?` which takes the returned code and returns immediately from the function.

    _return 1 "This failed" || return $?
    __argument isInteger "$1" || return $?

Alternately, these can be used within an `if` or other compound statement but the return code should be returned to the user, typically.

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

Unable to find "_exit" (using index "/Users/kent/.build")

### `_return` - IDENTICAL _return 6

IDENTICAL _return 6

#### Usage

    _return _return [ exitCode [ message ... ] ]
    

#### Exit codes

- exitCode or 1 if nothing passed

#### Errors

Unable to find "_exit" (using index "/Users/kent/.build")

### `_environment` - Return `$errorEnvironment` always. Outputs `message ...` to `stderr`.

Return `$errorEnvironment` always. Outputs `message ...` to `stderr`.

#### Usage

    _environment message ...
    

#### Arguments



#### Exit codes

- 1

#### Errors

Unable to find "_exit" (using index "/Users/kent/.build")

### `_argument` - Return `$errorArgument` always. Outputs `message ...` to `stderr`.

Return `$errorArgument` always. Outputs `message ...` to `stderr`.

#### Usage

    _argument message ..`.
    

#### Arguments



#### Exit codes

- 2

#### Errors

Unable to find "_exit" (using index "/Users/kent/.build")

### `__execute` - Run `command ...` (with any arguments) and then `_return` if

Run `command ...` (with any arguments) and then `_return` if it fails.

#### Usage

    __execute command ...
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

#### Errors

Unable to find "_exit" (using index "/Users/kent/.build")

### `__try` - Run `command ...` (with any arguments) and then `_exit` if

Run `command ...` (with any arguments) and then `_exit` if it fails. Critical code only.

#### Usage

    __try command ...
    

#### Arguments



#### Exit codes

- None

#### Errors

Unable to find "_exit" (using index "/Users/kent/.build")

### `__echo` - Output the `command ...` to stdout prior to running, then

Output the `command ...` to stdout prior to running, then `__execute` it

#### Usage

    __echo command ...
    

#### Arguments



#### Exit codes

- Any

#### Errors

Unable to find "_exit" (using index "/Users/kent/.build")

### `__environment` - Run `command ...` (with any arguments) and then `_environment` if

Run `command ...` (with any arguments) and then `_environment` if it fails.

#### Usage

    __environment command ...
    

#### Arguments



#### Exit codes

- `0` - Success
- `1` - Failed

#### Errors

Unable to find "_exit" (using index "/Users/kent/.build")

### `__argument` - Run `command ...` (with any arguments) and then `_argument` if

Run `command ...` (with any arguments) and then `_argument` if it fails.

#### Usage

    __argument command ...FUNCNAME
    

#### Arguments



#### Exit codes

- `0` - Success
- `2` - Failed

#### Errors

Unable to find "_exit" (using index "/Users/kent/.build")

## Decorations


### `_list` - Output a titled list

Output a titled list

#### Usage

    _list title [ items ... ]
    

#### Exit codes

- `0` - Always succeeds

#### Errors

Unable to find "_exit" (using index "/Users/kent/.build")

<!-- TEMPLATE footer 5 -->
<hr />

[⬅ Top](index.md) [⬅ Parent ](../index.md)

Copyright &copy; 2024 [Market Acumen, Inc.](https://marketacumen.com?crcat=code&crsource=zesk/build&crcampaign=docs&crkw=Sugar Core)
