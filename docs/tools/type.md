# Type Functions

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

### `inArray` - Check if an element exists in an array

Check if an element exists in an array

- Location: `bin/build/tools/text.sh`

#### Usage

_mapEnvironment

#### Arguments

- `element` - Thing to search for
- `arrayElement0` - One or more array elements to match

#### Examples

    if inArray "$thing" "${things[@]}"; then things+=("$thing");
        things+=("$thing")
    fi

#### Exit codes

- `0` - If element is found in array
- `1` - If element is NOT found in array
### `isUnsignedNumber` - Test if an argument is a positive floating point number

Test if an argument is a positive floating point number
(`1e3` notation NOT supported)

- Location: `bin/build/tools/type.sh`

#### Usage

_mapEnvironment

#### Arguments

- No arguments.

#### Exit codes

- `0` - if it is a number equal to or greater than zero
- `1` - if it is not a number equal to or greater than zero

#### Credits

Thanks to [F. Hauri - Give Up GitHub (isnum_Case)](https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash).
### `isNumber` - Test if an argument is a floating point number

Test if an argument is a floating point number
(`1e3` notation NOT supported)

- Location: `bin/build/tools/type.sh`

#### Usage

_mapEnvironment

#### Arguments

- No arguments.

#### Exit codes

- `0` - if it is a floating point number
- `1` - if it is not a floating point number

#### Credits

Thanks to [F. Hauri - Give Up GitHub (isnum_Case)](https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash).
### `isInteger` - Test if an argument is a signed integer

Test if an argument is a signed integer

- Location: `bin/build/tools/type.sh`

#### Usage

_mapEnvironment

#### Arguments

- No arguments.

#### Exit codes

- `0` - if it is a signed integer
- `1` - if it is not a signed integer

#### Credits

Thanks to [F. Hauri - Give Up GitHub (isuint_Case)](https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash).
### `isUnsignedInteger` - Test if an argument is an unsigned integer

Test if an argument is an unsigned integer

- Location: `bin/update-available.sh`

#### Usage

_mapEnvironment

#### Arguments

- No arguments.

#### Exit codes

- `0` - if it is an unsigned integer
- `1` - if it is not an unsigned integer

#### Credits

Thanks to [F. Hauri - Give Up GitHub (isnum_Case)](https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash).
### `isPositiveInteger` - Test if an argument is a positive integer (non-zero)

Test if an argument is a positive integer (non-zero)

- Location: `bin/build/install-bin-build.sh`

#### Usage

_mapEnvironment

#### Arguments

- No arguments.

#### Exit codes

- `0` - if it is a positive integer
- `1` - if it is not a positive integer
### `isNumber` - Test if an argument is a floating point number

Test if an argument is a floating point number
(`1e3` notation NOT supported)

- Location: `bin/build/tools/type.sh`

#### Usage

_mapEnvironment

#### Arguments

- No arguments.

#### Exit codes

- `0` - if it is a floating point number
- `1` - if it is not a floating point number

#### Credits

Thanks to [F. Hauri - Give Up GitHub (isnum_Case)](https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash).
### `isFunction` - Test if argument are bash functions

Test if argument are bash functions
If no arguments are passed, returns exit code 1.

- Location: `bin/build/install-bin-build.sh`

#### Usage

_mapEnvironment

#### Arguments

- `string` - Required. String to test if it is a bash function. Builtins are supported. `.` is explicitly not supported to disambiguate it from the current directory `.`.

#### Exit codes

- `0` - argument is bash function
- `1` - argument is not a bash function
### `isExecutable` - Test if all arguments are executable binaries

Test if all arguments are executable binaries
If no arguments are passed, returns exit code 1.

- Location: `bin/build/tools/platform/_isExecutable.sh`

#### Usage

_mapEnvironment

#### Arguments

- `string` - Required. Path to binary to test if it is executable.

#### Exit codes

- `0` - All arguments are executable binaries
- `1` - One or or more arguments are not executable binaries
### `isCallable` - Test if all arguments are callable as a command

Test if all arguments are callable as a command
If no arguments are passed, returns exit code 1.

- Location: `bin/build/tools/type.sh`

#### Usage

_mapEnvironment

#### Arguments

- `string` - Required. Path to binary to test if it is executable.

#### Exit codes

- `0` - All arguments are callable as a command
- `1` - One or or more arguments are callable as a command
### `isTrue` - True-ish

True-ish
Succeeds when all arguments are "true"-ish

- Location: `bin/build/tools/type.sh`

#### Usage

_mapEnvironment

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `isArray` - Is a variable declared as an array?

Is a variable declared as an array?

- Location: `bin/build/tools/type.sh`

#### Usage

_mapEnvironment

#### Arguments

- `variableName` - Required. String. Variable to check is an array.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
