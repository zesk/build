# Assert Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)


## `assertEquals` - Assert two strings are equal.

Assert two strings are equal.

If this fails it will output an error and exit.

### Usage

    assertEquals expected actual [ message ]

### Arguments

- `expected` - Expected string
- `actual` - Actual string
- `message` - Message to output if the assertion fails

### Examples

    assertEquals "$(alignRight 4 "hi")" "  hi" "alignRight not working"

### Exit codes

- `0` - Always succeeds

### Review Status

File `./bin/build//tools/assert.sh`, function `assertEquals` was reviewed 2023-11-12.

## `assertNotEquals` - Assert two strings are not equal

Assert two strings are not equal.

If this fails it will output an error and exit.

### Usage

    assertNotEquals expected actual [ message ]

### Arguments

- `expected` - Expected string
- `actual` - Actual string
- `message` - Message to output if the assertion fails

### Exit codes

- `0` - Always succeeds

### Review Status

File `./bin/build//tools/assert.sh`, function `assertNotEquals` was reviewed 2023-11-12.


## `assertGreaterThan` - Assert actual value is greater than expected value

Assert actual value is greater than expected value.

    expected < actual will pass

If this fails it will output an error and exit.

### Usage

    assertGreaterThan expected actual [ message ]

### Arguments

- `expected` - Expected numeric value
- `actual` - Actual numeric value
- `message` - Message to output if the assertion fails

### Examples

    assertGreaterThan 3 $found

### Exit codes

- `0` - Always succeeds

### Review Status

File `./bin/build//tools/assert.sh`, function `assertGreaterThan` was reviewed 2023-11-14.

## `assertGreaterThanOrEqual` - Assert actual value is greater than or equal to expected value

Assert actual value is greater than or equal to expected value.

If this fails it will output an error and exit.

### Usage

    assertNotEquals expected actual [ message ]

### Arguments

- `expected` - Expected numeric value
- `actual` - Actual numeric value
- `message` - Message to output if the assertion fails

### Examples

    assertGreaterThanOrEqual 3 $found

### Exit codes

- `0` - Always succeeds

### Review Status

File `./bin/build//tools/assert.sh`, function `assertGreaterThanOrEqual` was reviewed 2023-11-12.


## `assertLessThan` - Assert actual value is less than expected value

Assert actual value is less than expected value.

If this fails it will output an error and exit.

### Usage

    assertLessThan expected actual [ message ]

### Arguments

- `expected` - Expected numeric value
- `actual` - Actual numeric value
- `message` - Message to output if the assertion fails

### Examples

    assertLessThan 3 $found

### Exit codes

- `0` - expected less than to actual
- `1` - expected greater than or equal to actual, or invalid numbers

### Review Status

File `./bin/build//tools/assert.sh`, function `assertLessThan` was reviewed 2023-11-12.

## `assertLessThanOrEqual` - Assert two strings are not equal

Assert two strings are not equal.

If this fails it will output an error and exit.

### Usage

    assertNotEquals expected actual [ message ]

### Arguments

- `expected` - Expected numeric value
- `actual` - Actual numeric value
- `message` - Message to output if the assertion fails

### Examples

    assertLessThanOrEqual 3 $found

### Exit codes

- `0` - expected less than or equal to actual
- `1` - expected greater than actual, or invalid numbers

### Review Status

File `./bin/build//tools/assert.sh`, function `assertLessThanOrEqual` was reviewed 2023-11-12.


## `assertExitCode` - Assert a process runs and exits with the correct exit

Assert a process runs and exits with the correct exit code.

If this fails it will output an error and exit.

### Usage

    assertExitCode expectedExitCode command [ arguments ... ]

### Arguments

- `expectedExitCode` - A numeric exit code expected from the command
- `command` - The command to run
- `arguments` - Any arguments to pass to the command to run

### Exit codes

- `0` - If the process exits with the provided exit code
- `1` - If the process exits with a different exit code

### Local cache

None.

### Environment

None.

### Review Status

File `./bin/build//tools/assert.sh`, function `assertExitCode` was reviewed 2023-11-12.

## `assertNotExitCode` - Assert a process runs and exits with an exit code

Assert a process runs and exits with an exit code which does not match the passed in exit code.

If this fails it will output an error and exit.

### Usage

    assertNotExitCode expectedExitCode command [ arguments ... ]

### Arguments

- `expectedExitCode` - A numeric exit code not expected from the command
- `command` - The command to run
- `arguments` - Any arguments to pass to the command to run

### Exit codes

- `0` - If the process exits with a different exit code
- `1` - If the process exits with the provided exit code

### Review Status

File `./bin/build//tools/assert.sh`, function `assertNotExitCode` was reviewed 2023-11-12.


## `assertOutputContains` - Run a command and expect the output to contain the

Run a command and expect the output to contain the occurrence of a string.

If this fails it will output the command result to stdout.

### Usage

    assertOutputContains expected command [ arguments ... ]

### Arguments

- `expected` - A string to expect in the output
- `command` - The command to run
- `arguments` - Any arguments to pass to the command to run
- `--exit` - Assert exit status of process to be this number
- `--stderr` - Also include standard error in output checking

### Examples

    assertOutputContains Success complex-thing.sh --dry-run

### Exit codes

- `0` - If the output contains at least one occurrence of the string
- `1` - If output does not contain string

### Local cache

None

### Review Status

File `./bin/build//tools/assert.sh`, function `assertOutputContains` was reviewed 2023-11-12.

## `assertOutputDoesNotContain` - Run a command and expect the output to not contain

Run a command and expect the output to not contain the occurrence of a string.

If this fails it will output the command result to stdout.

### Usage

    assertOutputDoesNotContain expected command [ arguments ... ]

### Arguments

- `expected` - A string to NOT expect in the output
- `command` - The command to run
- `arguments` - Any arguments to pass to the command to run
- `--exit` - Assert exit status of process to be this number
- `--stderr` - Also include standard error in output checking

### Examples

    assertOutputDoesNotContain Success complex-thing.sh --dry-run

### Exit codes

- `0` - If the output contains at least one occurrence of the string
- `1` - If output does not contain string

### Local cache

None

### Review Status

File `./bin/build//tools/assert.sh`, function `assertOutputDoesNotContain` was reviewed 2023-11-12.


## `assertDirectoryExists` - Test that a directory exists

$Test that a directory exists

### Usage

    assertDirectoryExists directory [ message ... ]

### Arguments

- `directory` - Directory that should exist
- `message` - An error message if this fails

### Examples

    assertDirectoryExists "$HOME" "HOME not found"

### Exit codes

- `0` - If the assertion succeeds
- `1` - If the assertion fails

### Local cache

None

### Environment

- This fails if `directory` is anything but a `directory`

## `assertDirectoryDoesNotExist` - Test that a directory does not exist

$Test that a directory does not exist

### Usage

    assertDirectoryDoesNotExist directory [ message ... ]

### Arguments

- `directory` - Directory that should NOT exist
- `message` - An error message if this fails

### Exit codes

- `0` - If the assertion succeeds
- `1` - If the assertion fails

### Local cache

None

### Environment

- This fails if `directory` is anything at all, even a non-directory (such as a link)

### Review Status

File `./bin/build//tools/assert.sh`, function `assertDirectoryDoesNotExist` was reviewed 2023-11-12.


### Usage

    assertFileContains fileName string0 [ ... ]

### Arguments

- `fileName` - File to search
- `string0 ...` - One or more strings which must be found on at least one line in the file

### Examples

    assertFileContains $logFile Success
    assertFileContains $logFile "is up to date"

### Exit codes

- `0` - If the assertion succeeds
- `1` - If the assertion fails

### Local cache

None

### Environment

If the file does not exist, this will fail.

### Review Status

File `./bin/build//tools/assert.sh`, function `assertFileContains` was reviewed 2023-11-12.

### Usage

    assertFileDoesNotContain fileName string0 [ ... ]

### Arguments

- `fileName` - File to search
- `string0 ...` - One or more strings which must NOT be found anywhere in `fileName`

### Examples

    assertFileDoesNotContain $logFile error Error ERROR
    assertFileDoesNotContain $logFile warning Warning WARNING

### Exit codes

- `1` - If the assertions fails
- `0` - If the assertion succeeds

### Environment

If the file does not exist, this will fail.


## `randomString` - Outputs 40 random hexadecimal characters, lowercase.

Outputs 40 random hexadecimal characters, lowercase.

### Usage

    randomString [ ... ]

### Examples

    testPassword="$(randomString)"

### Sample Output

cf7861b50054e8c680a9552917b43ec2b9edae2b

### Exit codes

- `0` - Always succeeds

### Depends

    shasum, /dev/random

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
