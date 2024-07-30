# Type Functions

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />


### `inArray` - Check if an element exists in an array

Check if an element exists in an array

#### Usage

    inArray element [ arrayElement0 arrayElement1 ... ]
    

#### Arguments



#### Exit codes

- `0` - If element is found in array
- `1` - If element is NOT found in array

### `isUnsignedNumber` - Test if an argument is a positive floating point number

Test if an argument is a positive floating point number
(`1e3` notation NOT supported)

#### Usage

    isUnsignedNumber argument ...
    

#### Exit codes

- `0` - if it is a number equal to or greater than zero
- `1` - if it is not a number equal to or greater than zero

#### Credits

Thanks to [F. Hauri - Give Up GitHub (isnum_Case)](https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash).

### `isNumber` - Test if an argument is a floating point number

Test if an argument is a floating point number
(`1e3` notation NOT supported)

#### Usage

    isNumber argument ...
    

#### Exit codes

- `0` - if it is a floating point number
- `1` - if it is not a floating point number

#### Credits

Thanks to [F. Hauri - Give Up GitHub (isnum_Case)](https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash).

### `isInteger` - Test if an argument is a signed integer

Test if an argument is a signed integer

#### Usage

    isInteger argument ...
    

#### Exit codes

- `0` - if it is a signed integer
- `1` - if it is not a signed integer

#### Credits

Thanks to [F. Hauri - Give Up GitHub (isuint_Case)](https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash).

### `isUnsignedInteger` - Test if an argument is an unsigned integer

Test if an argument is an unsigned integer

#### Usage

    isUnsignedInteger argument ...
    

#### Exit codes

- `0` - if it is an unsigned integer
- `1` - if it is not an unsigned integer

#### Credits

Thanks to [F. Hauri - Give Up GitHub (isnum_Case)](https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash).

### `isNumber` - Test if an argument is a floating point number

Test if an argument is a floating point number
(`1e3` notation NOT supported)

#### Usage

    isNumber argument ...
    

#### Exit codes

- `0` - if it is a floating point number
- `1` - if it is not a floating point number

#### Credits

Thanks to [F. Hauri - Give Up GitHub (isnum_Case)](https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash).

### `isFunction` - Test if all arguments are bash functions

Test if all arguments are bash functions
If no arguments are passed, returns exit code 1.

#### Usage

    isFunction string0 [ string1 ... ]
    

#### Arguments



#### Exit codes

- `0` - All arguments are bash functions
- `1` - One or or more arguments are not a bash function

### `isExecutable` - Test if all arguments are executable binaries

Test if all arguments are executable binaries
If no arguments are passed, returns exit code 1.

#### Usage

    isExecutable string0 [ string1 ... ]
    

#### Arguments



#### Exit codes

- `0` - All arguments are executable binaries
- `1` - One or or more arguments are not executable binaries

### `isCallable` - Test if all arguments are callable as a command

Test if all arguments are callable as a command
If no arguments are passed, returns exit code 1.

#### Usage

    isCallable string0 [ string1 ... ]
    

#### Arguments



#### Exit codes

- `0` - All arguments are callable as a command
- `1` - One or or more arguments are callable as a command
