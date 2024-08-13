# Assert Tools

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

## Equality

### `assertEquals` - Assert two strings are equal.

Assert two strings are equal.

If this fails it will output an error and exit.

#### Usage

    assertEquals expected actual [ message ]
    

#### Arguments

- `--help` - Optional. Flag. Display this help.
- `--line lineNumber` - Optional. Integer. Line number of calling function.
- `--debug` - Optional. Flag. Debugging
- `--display` - Optional. String. Display name for the condition.
- `--success` - Optional. Boolean. Whether the assertion should pass (`true`) or fail (`false`)
- `--stderr-match` - Optional. String. One or more strings which must match stderr. Implies `--stderr-ok`
- `--stdout-no-match` - Optional. String. One or more strings which must match stderr.
- `--stdout-match` - Optional. String. One or more strings which must match stdout.
- `--stdout-no-match` - Optional. String. One or more strings which must match stdout.
- `--stderr-ok` - Optional. Flag. Output to stderr will not cause the test to fail.
- `--dump` - Optional. Flag. Output stderr and stdout after test regardless.
- `expected` - Expected string
- `actual` - Actual string
- `message` - Message to output if the assertion fails

#### Examples

    assertEquals "$(alignRight 4 "hi")" "  hi" "alignRight not working"

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Review Status

File `bin/build/tools/assert.sh`, function `assertEquals` was reviewed 2023-11-12.
### `assertNotEquals` - Assert two strings are not equal

Assert two strings are not equal.

If this fails it will output an error and exit.

#### Usage

    assertNotEquals expected actual [ message ]
    

#### Arguments

- `--help` - Optional. Flag. Display this help.
- `--line lineNumber` - Optional. Integer. Line number of calling function.
- `--debug` - Optional. Flag. Debugging
- `--display` - Optional. String. Display name for the condition.
- `--success` - Optional. Boolean. Whether the assertion should pass (`true`) or fail (`false`)
- `--stderr-match` - Optional. String. One or more strings which must match stderr. Implies `--stderr-ok`
- `--stdout-no-match` - Optional. String. One or more strings which must match stderr.
- `--stdout-match` - Optional. String. One or more strings which must match stdout.
- `--stdout-no-match` - Optional. String. One or more strings which must match stdout.
- `--stderr-ok` - Optional. Flag. Output to stderr will not cause the test to fail.
- `--dump` - Optional. Flag. Output stderr and stdout after test regardless.
- `expected` - Required. Expected string.
- `actual` - Required. Actual string.
- `message` - Message to output if the assertion fails. Optional.

#### Examples

    assertNotEquals "$(uname -s)" "Darwin" "Not compatible with Darwin"
    Single quote break-s

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Review Status

File `bin/build/tools/assert.sh`, function `assertNotEquals` was reviewed 2023-11-12.
### `assertContains` - Assert one string contains another (case-sensitive)

Assert one string contains another (case-sensitive)

#### Arguments

- `--help` - Optional. Flag. Display this help.
- `--line lineNumber` - Optional. Integer. Line number of calling function.
- `--debug` - Optional. Flag. Debugging
- `--display` - Optional. String. Display name for the condition.
- `--success` - Optional. Boolean. Whether the assertion should pass (`true`) or fail (`false`)
- `--stderr-match` - Optional. String. One or more strings which must match stderr. Implies `--stderr-ok`
- `--stdout-no-match` - Optional. String. One or more strings which must match stderr.
- `--stdout-match` - Optional. String. One or more strings which must match stdout.
- `--stdout-no-match` - Optional. String. One or more strings which must match stdout.
- `--stderr-ok` - Optional. Flag. Output to stderr will not cause the test to fail.
- `--dump` - Optional. Flag. Output stderr and stdout after test regardless.
- `needle` - Thing we are looking for
- `haystack` - Thing we are looking in

#### Exit codes

- `0` - The assertion succeeded
- `1` - Assertion failed
- `2` - Bad arguments
### `assertNotContains` - Assert one string does not contains another (case-sensitive)

Assert one string does not contains another (case-sensitive)

#### Arguments

- `--help` - Optional. Flag. Display this help.
- `--line lineNumber` - Optional. Integer. Line number of calling function.
- `--debug` - Optional. Flag. Debugging
- `--display` - Optional. String. Display name for the condition.
- `--success` - Optional. Boolean. Whether the assertion should pass (`true`) or fail (`false`)
- `--stderr-match` - Optional. String. One or more strings which must match stderr. Implies `--stderr-ok`
- `--stdout-no-match` - Optional. String. One or more strings which must match stderr.
- `--stdout-match` - Optional. String. One or more strings which must match stdout.
- `--stdout-no-match` - Optional. String. One or more strings which must match stdout.
- `--stderr-ok` - Optional. Flag. Output to stderr will not cause the test to fail.
- `--dump` - Optional. Flag. Output stderr and stdout after test regardless.
- `needle` - Thing we are looking for
- `haystack` - Thing we are looking in

#### Exit codes

- `0` - The assertion succeeded
- `1` - Assertion failed
- `2` - Bad arguments

## Comparison

### `assertGreaterThan` - Assert `leftValue > rightValue`

Assert `leftValue > rightValue`

#### Arguments

- `leftValue` - Value to compare on the left hand side of the comparison
- `rightValue` - Value to compare on the right hand side of the comparison
- `message` - Message to output if the assertion fails

#### Examples

    assertGreaterThan 3 "$found"

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Review Status

File `bin/build/tools/assert.sh`, function `assertGreaterThan` was reviewed 2023-11-14.
### `assertGreaterThanOrEqual` - Assert actual value is greater than or equal to expected value

Assert `leftValue >= rightValue`

#### Arguments

- `leftValue` - Value to compare on the left hand side of the comparison
- `rightValue` - Value to compare on the right hand side of the comparison
- `message` - Message to output if the assertion fails

#### Examples

    assertGreaterThanOrEqual 3 $found

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Review Status

File `bin/build/tools/assert.sh`, function `assertGreaterThanOrEqual` was reviewed 2023-11-12.

### `assertLessThan` - Assert `leftValue < rightValue`

Assert `leftValue < rightValue`

#### Arguments

- `leftValue` - Value to compare on the left hand side of the comparison
- `rightValue` - Value to compare on the right hand side of the comparison
- `message` - Message to output if the assertion fails

#### Examples

    assertLessThan 3 $found

#### Exit codes

- `0` - expected less than to actual
- `1` - expected greater than or equal to actual, or invalid numbers

#### Review Status

File `bin/build/tools/assert.sh`, function `assertLessThan` was reviewed 2023-11-12.
### `assertLessThanOrEqual` - Assert `leftValue <= rightValue`

Assert `leftValue <= rightValue`

#### Arguments

- `--help` - Optional. Flag. Display this help.
- `--line lineNumber` - Optional. Integer. Line number of calling function.
- `--debug` - Optional. Flag. Debugging
- `--display` - Optional. String. Display name for the condition.
- `--success` - Optional. Boolean. Whether the assertion should pass (`true`) or fail (`false`)
- `--stderr-match` - Optional. String. One or more strings which must match stderr. Implies `--stderr-ok`
- `--stdout-no-match` - Optional. String. One or more strings which must match stderr.
- `--stdout-match` - Optional. String. One or more strings which must match stdout.
- `--stdout-no-match` - Optional. String. One or more strings which must match stdout.
- `--stderr-ok` - Optional. Flag. Output to stderr will not cause the test to fail.
- `--dump` - Optional. Flag. Output stderr and stdout after test regardless.
- `leftValue` - Value to compare on the left hand side of the comparison
- `rightValue` - Value to compare on the right hand side of the comparison
- `message` - Message to output if the assertion fails

#### Examples

    assertLessThanOrEqual 3 $found

#### Exit codes

- `0` - expected less than or equal to actual
- `1` - expected greater than actual, or invalid numbers

#### Review Status

File `bin/build/tools/assert.sh`, function `assertLessThanOrEqual` was reviewed 2023-11-12.

## Exit code

### `assertExitCode` - Assert a process runs and exits with the correct exit

Assert a process runs and exits with the correct exit code.

If this fails it will output an error and exit.

#### Usage

    assertExitCode expectedExitCode command [ arguments ... ]
    

#### Arguments

- `--help` - Optional. Flag. Display this help.
- `--line lineNumber` - Optional. Integer. Line number of calling function.
- `--debug` - Optional. Flag. Debugging
- `--display` - Optional. String. Display name for the condition.
- `--success` - Optional. Boolean. Whether the assertion should pass (`true`) or fail (`false`)
- `--stderr-match` - Optional. String. One or more strings which must match stderr. Implies `--stderr-ok`
- `--stdout-no-match` - Optional. String. One or more strings which must match stderr.
- `--stdout-match` - Optional. String. One or more strings which must match stdout.
- `--stdout-no-match` - Optional. String. One or more strings which must match stdout.
- `--stderr-ok` - Optional. Flag. Output to stderr will not cause the test to fail.
- `--dump` - Optional. Flag. Output stderr and stdout after test regardless.

#### Exit codes

- `0` - If the process exits with the provided exit code
- `1` - If the process exits with a different exit code

#### Review Status

File `bin/build/tools/assert.sh`, function `assertExitCode` was reviewed 2023-11-12.
### `assertNotExitCode` - Assert a process runs and exits with an exit code

Assert a process runs and exits with an exit code which does not match the passed in exit code.

If this fails it will output an error and exit.

#### Usage

    assertNotExitCode expectedExitCode command [ arguments ... ]
    

#### Arguments

- `--help` - Optional. Flag. Display this help.
- `--line lineNumber` - Optional. Integer. Line number of calling function.
- `--debug` - Optional. Flag. Debugging
- `--display` - Optional. String. Display name for the condition.
- `--success` - Optional. Boolean. Whether the assertion should pass (`true`) or fail (`false`)
- `--stderr-match` - Optional. String. One or more strings which must match stderr. Implies `--stderr-ok`
- `--stdout-no-match` - Optional. String. One or more strings which must match stderr.
- `--stdout-match` - Optional. String. One or more strings which must match stdout.
- `--stdout-no-match` - Optional. String. One or more strings which must match stdout.
- `--stderr-ok` - Optional. Flag. Output to stderr will not cause the test to fail.
- `--dump` - Optional. Flag. Output stderr and stdout after test regardless.

#### Exit codes

- `0` - If the process exits with a different exit code
- `1` - If the process exits with the provided exit code

#### Review Status

File `bin/build/tools/assert.sh`, function `assertNotExitCode` was reviewed 2023-11-12.

## Output 

### `assertOutputEquals` - Assert output of a binary equals a string

Assert output of a binary equals a string

If this fails it will output an error and exit.

#### Usage

    assertOutputEquals expected binary [ parameters ]
    

#### Arguments

- `--help` - Optional. Flag. Display this help.
- `--line lineNumber` - Optional. Integer. Line number of calling function.
- `--debug` - Optional. Flag. Debugging
- `--display` - Optional. String. Display name for the condition.
- `--success` - Optional. Boolean. Whether the assertion should pass (`true`) or fail (`false`)
- `--stderr-match` - Optional. String. One or more strings which must match stderr. Implies `--stderr-ok`
- `--stdout-no-match` - Optional. String. One or more strings which must match stderr.
- `--stdout-match` - Optional. String. One or more strings which must match stdout.
- `--stdout-no-match` - Optional. String. One or more strings which must match stdout.
- `--stderr-ok` - Optional. Flag. Output to stderr will not cause the test to fail.
- `--dump` - Optional. Flag. Output stderr and stdout after test regardless.
- `expected` - Expected string
- `binary` - Binary to run and evaluate output
- `parameters` - Any additional parameters to binary

#### Examples

    assertOutputEquals "2023" date +%Y

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Review Status

File `bin/build/tools/assert.sh`, function `assertOutputEquals` was reviewed 2023-11-12.
### `assertOutputContains` - Run a command and expect the output to contain the

Run a command and expect the output to contain the occurrence of a string.

If this fails it will output the command result to stdout.

#### Arguments

- `--help` - Optional. Flag. Display this help.
- `--line lineNumber` - Optional. Integer. Line number of calling function.
- `--debug` - Optional. Flag. Debugging
- `--display` - Optional. String. Display name for the condition.
- `--success` - Optional. Boolean. Whether the assertion should pass (`true`) or fail (`false`)
- `--stderr-match` - Optional. String. One or more strings which must match stderr. Implies `--stderr-ok`
- `--stdout-no-match` - Optional. String. One or more strings which must match stderr.
- `--stdout-match` - Optional. String. One or more strings which must match stdout.
- `--stdout-no-match` - Optional. String. One or more strings which must match stdout.
- `--stderr-ok` - Optional. Flag. Output to stderr will not cause the test to fail.
- `--dump` - Optional. Flag. Output stderr and stdout after test regardless.
- `expected` - A string to expect in the output
- `command` - The command to run
- `arguments` - Any arguments to pass to the command to run
- `--exit` - Assert exit status of process to be this number
- `--stderr` - Also include standard error in output checking

#### Examples

    assertOutputContains Success complex-thing.sh --dry-run

#### Exit codes

- `0` - If the output contains at least one occurrence of the string
- `1` - If output does not contain string

#### Review Status

File `bin/build/tools/assert.sh`, function `assertOutputContains` was reviewed 2023-11-12.
### `assertOutputDoesNotContain` - Run a command and expect the output to not contain

Run a command and expect the output to not contain the occurrence of a string.

If this fails it will output the command result to stdout.

#### Usage

    assertOutputDoesNotContain expected command [ arguments ... ]
    

#### Arguments

- `--help` - Optional. Flag. Display this help.
- `--line lineNumber` - Optional. Integer. Line number of calling function.
- `--debug` - Optional. Flag. Debugging
- `--display` - Optional. String. Display name for the condition.
- `--success` - Optional. Boolean. Whether the assertion should pass (`true`) or fail (`false`)
- `--stderr-match` - Optional. String. One or more strings which must match stderr. Implies `--stderr-ok`
- `--stdout-no-match` - Optional. String. One or more strings which must match stderr.
- `--stdout-match` - Optional. String. One or more strings which must match stdout.
- `--stdout-no-match` - Optional. String. One or more strings which must match stdout.
- `--stderr-ok` - Optional. Flag. Output to stderr will not cause the test to fail.
- `--dump` - Optional. Flag. Output stderr and stdout after test regardless.
- `expected` - A string to NOT expect in the output
- `command` - The command to run
- `arguments` - Any arguments to pass to the command to run
- `--exit` - Assert exit status of process to be this number
- `--stderr` - Also include standard error in output checking

#### Examples

    assertOutputDoesNotContain Success complex-thing.sh --dry-run

#### Exit codes

- `0` - If the output contains at least one occurrence of the string
- `1` - If output does not contain string

#### Local cache

None

#### Review Status

File `bin/build/tools/assert.sh`, function `assertOutputDoesNotContain` was reviewed 2023-11-12.

## Directory

### `assertDirectoryExists` - Test that a directory exists

$\Test that a directory exists

#### Usage

    assertDirectoryExists directory [ message ... ]
    

#### Arguments

- `--help` - Optional. Flag. Display this help.
- `--line lineNumber` - Optional. Integer. Line number of calling function.
- `--debug` - Optional. Flag. Debugging
- `--display` - Optional. String. Display name for the condition.
- `--success` - Optional. Boolean. Whether the assertion should pass (`true`) or fail (`false`)
- `--stderr-match` - Optional. String. One or more strings which must match stderr. Implies `--stderr-ok`
- `--stdout-no-match` - Optional. String. One or more strings which must match stderr.
- `--stdout-match` - Optional. String. One or more strings which must match stdout.
- `--stdout-no-match` - Optional. String. One or more strings which must match stdout.
- `--stderr-ok` - Optional. Flag. Output to stderr will not cause the test to fail.
- `--dump` - Optional. Flag. Output stderr and stdout after test regardless.
- `directory` - Directory that should exist
- `message` - An error message if this fails

#### Examples

    assertDirectoryExists "$HOME" "HOME not found"

#### Exit codes

- `0` - If the assertion succeeds
- `1` - If the assertion fails

#### Local cache

None

#### Environment

- This fails if `directory` is anything but a `directory`
### `assertDirectoryDoesNotExist` - Test that a directory does not exist

$\Test that a directory does not exist

#### Usage

    assertDirectoryDoesNotExist directory [ message ... ]
    

#### Arguments

- `--help` - Optional. Flag. Display this help.
- `--line lineNumber` - Optional. Integer. Line number of calling function.
- `--debug` - Optional. Flag. Debugging
- `--display` - Optional. String. Display name for the condition.
- `--success` - Optional. Boolean. Whether the assertion should pass (`true`) or fail (`false`)
- `--stderr-match` - Optional. String. One or more strings which must match stderr. Implies `--stderr-ok`
- `--stdout-no-match` - Optional. String. One or more strings which must match stderr.
- `--stdout-match` - Optional. String. One or more strings which must match stdout.
- `--stdout-no-match` - Optional. String. One or more strings which must match stdout.
- `--stderr-ok` - Optional. Flag. Output to stderr will not cause the test to fail.
- `--dump` - Optional. Flag. Output stderr and stdout after test regardless.
- `directory` - Directory that should NOT exist
- `message` - An error message if this fails

#### Exit codes

- `0` - If the assertion succeeds
- `1` - If the assertion fails

#### Local cache

None

#### Environment

- This fails if `directory` is anything at all, even a non-directory (such as a link)

#### Review Status

File `bin/build/tools/assert.sh`, function `assertDirectoryDoesNotExist` was reviewed 2023-11-12.
### `assertDirectoryEmpty` - Test that a directory exists

$\Test that a directory exists

#### Arguments

- `--help` - Optional. Flag. Display this help.
- `--line lineNumber` - Optional. Integer. Line number of calling function.
- `--debug` - Optional. Flag. Debugging
- `--display` - Optional. String. Display name for the condition.
- `--success` - Optional. Boolean. Whether the assertion should pass (`true`) or fail (`false`)
- `--stderr-match` - Optional. String. One or more strings which must match stderr. Implies `--stderr-ok`
- `--stdout-no-match` - Optional. String. One or more strings which must match stderr.
- `--stdout-match` - Optional. String. One or more strings which must match stdout.
- `--stdout-no-match` - Optional. String. One or more strings which must match stdout.
- `--stderr-ok` - Optional. Flag. Output to stderr will not cause the test to fail.
- `--dump` - Optional. Flag. Output stderr and stdout after test regardless.
- `directory` - Directory that should exist and be empty
- `message` - An error message if this fails

#### Examples

    assertDirectoryExists "$HOME" "HOME not found"

#### Exit codes

- `0` - If the assertion succeeds
- `1` - If the assertion fails

#### Local cache

None

#### Environment

- This fails if `directory` is anything but a `directory`
### `assertDirectoryNotEmpty` - Test that a directory does not exist

$\Test that a directory does not exist

#### Arguments

- `--help` - Optional. Flag. Display this help.
- `--line lineNumber` - Optional. Integer. Line number of calling function.
- `--debug` - Optional. Flag. Debugging
- `--display` - Optional. String. Display name for the condition.
- `--success` - Optional. Boolean. Whether the assertion should pass (`true`) or fail (`false`)
- `--stderr-match` - Optional. String. One or more strings which must match stderr. Implies `--stderr-ok`
- `--stdout-no-match` - Optional. String. One or more strings which must match stderr.
- `--stdout-match` - Optional. String. One or more strings which must match stdout.
- `--stdout-no-match` - Optional. String. One or more strings which must match stdout.
- `--stderr-ok` - Optional. Flag. Output to stderr will not cause the test to fail.
- `--dump` - Optional. Flag. Output stderr and stdout after test regardless.
- `directory` - Directory that should exist and not be empty
- `message` - An error message if this fails

#### Exit codes

- `0` - If the assertion succeeds
- `1` - If the assertion fails

#### Local cache

None

#### Review Status

File `bin/build/tools/assert.sh`, function `assertDirectoryNotEmpty` was reviewed 2023-11-12.

## File

### `assertFileExists` - Test that a file exists

$\Test that a file exists

#### Arguments

- `--help` - Optional. Flag. Display this help.
- `--line lineNumber` - Optional. Integer. Line number of calling function.
- `--debug` - Optional. Flag. Debugging
- `--display` - Optional. String. Display name for the condition.
- `--success` - Optional. Boolean. Whether the assertion should pass (`true`) or fail (`false`)
- `--stderr-match` - Optional. String. One or more strings which must match stderr. Implies `--stderr-ok`
- `--stdout-no-match` - Optional. String. One or more strings which must match stderr.
- `--stdout-match` - Optional. String. One or more strings which must match stdout.
- `--stdout-no-match` - Optional. String. One or more strings which must match stdout.
- `--stderr-ok` - Optional. Flag. Output to stderr will not cause the test to fail.
- `--dump` - Optional. Flag. Output stderr and stdout after test regardless.
- `item` - File that should exist
- `message` - An error message if this fails

#### Examples

    assertDirectoryExists "$HOME" "HOME not found"

#### Exit codes

- `0` - If the assertion succeeds
- `1` - If the assertion fails

#### Local cache

None

#### Environment

- This fails if `file` is anything but a `file`
### `assertFileDoesNotExist` - Test that a file does not exist

$\Test that a file does not exist

#### Arguments

- `--help` - Optional. Flag. Display this help.
- `--line lineNumber` - Optional. Integer. Line number of calling function.
- `--debug` - Optional. Flag. Debugging
- `--display` - Optional. String. Display name for the condition.
- `--success` - Optional. Boolean. Whether the assertion should pass (`true`) or fail (`false`)
- `--stderr-match` - Optional. String. One or more strings which must match stderr. Implies `--stderr-ok`
- `--stdout-no-match` - Optional. String. One or more strings which must match stderr.
- `--stdout-match` - Optional. String. One or more strings which must match stdout.
- `--stdout-no-match` - Optional. String. One or more strings which must match stdout.
- `--stderr-ok` - Optional. Flag. Output to stderr will not cause the test to fail.
- `--dump` - Optional. Flag. Output stderr and stdout after test regardless.
- `file` - File that should NOT exist
- `message` - An error message if this fails

#### Exit codes

- `0` - If the assertion succeeds
- `1` - If the assertion fails

#### Local cache

None

#### Environment

- This fails if `file` is anything at all, even a non-file (such as a link)

#### Review Status

File `bin/build/tools/assert.sh`, function `assertFileDoesNotExist` was reviewed 2023-11-12.

#### Usage

    assertFileContains fileName string0 [ ... ]
    

#### Arguments

- `--help` - Optional. Flag. Display this help.
- `--line lineNumber` - Optional. Integer. Line number of calling function.
- `--debug` - Optional. Flag. Debugging
- `--display` - Optional. String. Display name for the condition.
- `--success` - Optional. Boolean. Whether the assertion should pass (`true`) or fail (`false`)
- `--stderr-match` - Optional. String. One or more strings which must match stderr. Implies `--stderr-ok`
- `--stdout-no-match` - Optional. String. One or more strings which must match stderr.
- `--stdout-match` - Optional. String. One or more strings which must match stdout.
- `--stdout-no-match` - Optional. String. One or more strings which must match stdout.
- `--stderr-ok` - Optional. Flag. Output to stderr will not cause the test to fail.
- `--dump` - Optional. Flag. Output stderr and stdout after test regardless.
- `fileName` - File to search
- `string0 ...` - One or more strings which must be found on at least one line in the file

#### Examples

    assertFileContains $logFile Success
    assertFileContains $logFile "is up to date"

#### Exit codes

- `0` - If the assertion succeeds
- `1` - If the assertion fails

#### Local cache

None

#### Environment

If the file does not exist, this will fail.

#### Review Status

File `bin/build/tools/assert.sh`, function `assertFileContains` was reviewed 2023-11-12.
#### Usage

    assertFileDoesNotContain fileName string0 [ ... ]
    

#### Arguments

- `--help` - Optional. Flag. Display this help.
- `--line lineNumber` - Optional. Integer. Line number of calling function.
- `--debug` - Optional. Flag. Debugging
- `--display` - Optional. String. Display name for the condition.
- `--success` - Optional. Boolean. Whether the assertion should pass (`true`) or fail (`false`)
- `--stderr-match` - Optional. String. One or more strings which must match stderr. Implies `--stderr-ok`
- `--stdout-no-match` - Optional. String. One or more strings which must match stderr.
- `--stdout-match` - Optional. String. One or more strings which must match stdout.
- `--stdout-no-match` - Optional. String. One or more strings which must match stdout.
- `--stderr-ok` - Optional. Flag. Output to stderr will not cause the test to fail.
- `--dump` - Optional. Flag. Output stderr and stdout after test regardless.
- `fileName` - File to search
- `string0 ...` - One or more strings which must NOT be found anywhere in `fileName`

#### Examples

    assertFileDoesNotContain $logFile error Error ERROR
    assertFileDoesNotContain $logFile warning Warning WARNING

#### Exit codes

- `1` - If the assertions fails
- `0` - If the assertion succeeds

#### Environment

If the file does not exist, this will fail.

## FileSize

#### Arguments

- `--help` - Optional. Flag. Display this help.
- `--line lineNumber` - Optional. Integer. Line number of calling function.
- `--debug` - Optional. Flag. Debugging
- `--display` - Optional. String. Display name for the condition.
- `--success` - Optional. Boolean. Whether the assertion should pass (`true`) or fail (`false`)
- `--stderr-match` - Optional. String. One or more strings which must match stderr. Implies `--stderr-ok`
- `--stdout-no-match` - Optional. String. One or more strings which must match stderr.
- `--stdout-match` - Optional. String. One or more strings which must match stdout.
- `--stdout-no-match` - Optional. String. One or more strings which must match stdout.
- `--stderr-ok` - Optional. Flag. Output to stderr will not cause the test to fail.
- `--dump` - Optional. Flag. Output stderr and stdout after test regardless.
- `expectedSize` - Integer file size which `fileName` should be, in bytes.
- `fileName ...` - One ore more file which should be `expectedSize` bytes in size.

#### Examples

    assertFileSize 22 .config
    assertFileSize 0 .env

#### Exit codes

- `1` - If the assertions fails
- `0` - If the assertion succeeds

#### Environment

If the file does not exist, this will fail.
#### Arguments

- `--help` - Optional. Flag. Display this help.
- `--line lineNumber` - Optional. Integer. Line number of calling function.
- `--debug` - Optional. Flag. Debugging
- `--display` - Optional. String. Display name for the condition.
- `--success` - Optional. Boolean. Whether the assertion should pass (`true`) or fail (`false`)
- `--stderr-match` - Optional. String. One or more strings which must match stderr. Implies `--stderr-ok`
- `--stdout-no-match` - Optional. String. One or more strings which must match stderr.
- `--stdout-match` - Optional. String. One or more strings which must match stdout.
- `--stdout-no-match` - Optional. String. One or more strings which must match stdout.
- `--stderr-ok` - Optional. Flag. Output to stderr will not cause the test to fail.
- `--dump` - Optional. Flag. Output stderr and stdout after test regardless.
- `expectedSize` - Integer file size which `fileName` should NOT be, in bytes.
- `fileName ...` - Required. File. One ore more file which should NOT be `expectedSize` bytes in size.

#### Examples

    assertNotFileSize 22 .config
    assertNotFileSize 0 .env

#### Exit codes

- `1` - If the assertions fails
- `0` - If the assertion succeeds

#### Environment

If the file does not exist, this will fail.

#### Arguments

- `--help` - Optional. Flag. Display this help.
- `--line lineNumber` - Optional. Integer. Line number of calling function.
- `--debug` - Optional. Flag. Debugging
- `--display` - Optional. String. Display name for the condition.
- `--success` - Optional. Boolean. Whether the assertion should pass (`true`) or fail (`false`)
- `--stderr-match` - Optional. String. One or more strings which must match stderr. Implies `--stderr-ok`
- `--stdout-no-match` - Optional. String. One or more strings which must match stderr.
- `--stdout-match` - Optional. String. One or more strings which must match stdout.
- `--stdout-no-match` - Optional. String. One or more strings which must match stdout.
- `--stderr-ok` - Optional. Flag. Output to stderr will not cause the test to fail.
- `--dump` - Optional. Flag. Output stderr and stdout after test regardless.
- `fileName ...` - Required. File. One ore more file which should be zero bytes in size.

#### Examples

    assertZeroFileSize .config
    assertZeroFileSize /var/www/log/error.log

#### Exit codes

- `1` - If the assertions fails
- `0` - If the assertion succeeds

#### Environment

If the file does not exist, this will fail.
#### Arguments

- `--help` - Optional. Flag. Display this help.
- `--line lineNumber` - Optional. Integer. Line number of calling function.
- `--debug` - Optional. Flag. Debugging
- `--display` - Optional. String. Display name for the condition.
- `--success` - Optional. Boolean. Whether the assertion should pass (`true`) or fail (`false`)
- `--stderr-match` - Optional. String. One or more strings which must match stderr. Implies `--stderr-ok`
- `--stdout-no-match` - Optional. String. One or more strings which must match stderr.
- `--stdout-match` - Optional. String. One or more strings which must match stdout.
- `--stdout-no-match` - Optional. String. One or more strings which must match stdout.
- `--stderr-ok` - Optional. Flag. Output to stderr will not cause the test to fail.
- `--dump` - Optional. Flag. Output stderr and stdout after test regardless.
- `fileName ...` - Required. File. One ore more file which should NOT be zero bytes in size.

#### Examples

    assertNotZeroFileSize 22 .config
    assertNotZeroFileSize 0 .env

#### Exit codes

- `1` - If the assertions fails
- `0` - If the assertion succeeds

#### Environment

If the file does not exist, this will fail.

## Random

### `randomString` - Outputs 40 random hexadecimal characters, lowercase.

Outputs 40 random hexadecimal characters, lowercase.

#### Usage

    randomString [ ... ]
    

#### Arguments

- No arguments.

#### Examples

    testPassword="$(randomString)"

#### Sample Output

    cf7861b50054e8c680a9552917b43ec2b9edae2b
    

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Depends

    shasum, /dev/random
    
