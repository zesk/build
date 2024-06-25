# Assert Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)

## Equality


### `assertEquals` - Assert two strings are equal.

Assert two strings are equal.

If this fails it will output an error and exit.

#### Usage

    assertEquals expected actual [ message ]
    

#### Arguments



#### Examples

    assertEquals "$(alignRight 4 "hi")" "  hi" "alignRight not working"

#### Exit codes

- `0` - Always succeeds

#### Review Status

File `bin/build/tools/assert.sh`, function `assertEquals` was reviewed 2023-11-12.

### `assertNotEquals` - Assert two strings are not equal

Assert two strings are not equal.

If this fails it will output an error and exit.

#### Usage

    assertNotEquals expected actual [ message ]
    

#### Arguments



#### Examples

    assertNotEquals "$(uname -s)" "Darwin" "Not compatible with Darwin"
    Single quote break-s

#### Exit codes

- `0` - Always succeeds

#### Review Status

File `bin/build/tools/assert.sh`, function `assertNotEquals` was reviewed 2023-11-12.

### `assertContains` - Assert one string contains another (case-sensitive)

Assert one string contains another (case-sensitive)

#### Usage

    assertContains needle haystack
    

#### Arguments



#### Exit codes

- `0` - The assertion succeeded
- `1` - Assertion failed
- `2` - Bad arguments

### `assertNotContains` - Assert one string does not contains another (case-sensitive)

Assert one string does not contains another (case-sensitive)

#### Usage

    assertNotContains needle haystack
    

#### Arguments



#### Exit codes

- `0` - The assertion succeeded
- `1` - Assertion failed
- `2` - Bad arguments

#### See Also

{SEE:assertContains}

## Comparison


### `assertGreaterThan` - Assert `leftValue > rightValue`

Assert `leftValue > rightValue`

#### Usage

    assertGreaterThan expected actual [ message ]
    

#### Arguments



#### Examples

    assertGreaterThan 3 "$found"

#### Exit codes

- `0` - Always succeeds

#### Review Status

File `bin/build/tools/assert.sh`, function `assertGreaterThan` was reviewed 2023-11-14.

### `assertGreaterThanOrEqual` - Assert actual value is greater than or equal to expected value

Assert `leftValue >= rightValue`

#### Usage

    assertNotEquals expected actual [ message ]
    

#### Arguments



#### Examples

    assertGreaterThanOrEqual 3 $found

#### Exit codes

- `0` - Always succeeds

#### Review Status

File `bin/build/tools/assert.sh`, function `assertGreaterThanOrEqual` was reviewed 2023-11-12.


### `assertLessThan` - Assert `leftValue < rightValue`

Assert `leftValue < rightValue`

#### Usage

    assertLessThan expected actual [ message ]
    

#### Arguments



#### Examples

    assertLessThan 3 $found

#### Exit codes

- `0` - expected less than to actual
- `1` - expected greater than or equal to actual, or invalid numbers

#### Review Status

File `bin/build/tools/assert.sh`, function `assertLessThan` was reviewed 2023-11-12.

### `assertLessThanOrEqual` - Assert `leftValue <= rightValue`

Assert `leftValue <= rightValue`

#### Usage

    assertLessThanOrEqual leftValue rightValue [ message ]
    

#### Arguments



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



#### Exit codes

- `0` - If the process exits with the provided exit code
- `1` - If the process exits with a different exit code

#### Local cache

None.

#### Environment

None.

#### Review Status

File `bin/build/tools/assert.sh`, function `assertExitCode` was reviewed 2023-11-12.

### `assertNotExitCode` - Assert a process runs and exits with an exit code

Assert a process runs and exits with an exit code which does not match the passed in exit code.

If this fails it will output an error and exit.

#### Usage

    assertNotExitCode expectedExitCode command [ arguments ... ]
    

#### Arguments



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



#### Examples

    assertOutputEquals "2023" date +%Y

#### Exit codes

- `0` - Always succeeds

#### Review Status

File `bin/build/tools/assert.sh`, function `assertOutputEquals` was reviewed 2023-11-12.

### `assertOutputContains` - Run a command and expect the output to contain the

Run a command and expect the output to contain the occurrence of a string.

If this fails it will output the command result to stdout.

#### Usage

    assertOutputContains expected command [ arguments ... ]
    

#### Arguments



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

#### Usage

    assertDirectoryEmpty directory [ message ... ]
    

#### Arguments



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

#### Usage

    assertDirectoryNotEmpty directory [ message ... ]
    

#### Arguments



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

#### Usage

    assertDirectoryExists directory [ message ... ]
    

#### Arguments



#### Examples

    assertDirectoryExists "$HOME" "HOME not found"

#### Exit codes

- `0` - If the assertion succeeds
- `1` - If the assertion fails

#### Local cache

None

#### Environment

- This fails if `directory` is anything but a `directory`

### `assertFileDoesNotExist` - Test that a file does not exist

$\Test that a file does not exist

#### Usage

    assertFileDoesNotExist file [ message ... ]
    

#### Arguments



#### Exit codes

- `0` - If the assertion succeeds
- `1` - If the assertion fails

#### Local cache

None

#### Environment

- This fails if `file` is anything at all, even a non-directory (such as a link)

#### Review Status

File `bin/build/tools/assert.sh`, function `assertFileDoesNotExist` was reviewed 2023-11-12.


#### Usage

    assertFileContains fileName string0 [ ... ]
    

#### Arguments



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



#### Examples

    assertFileDoesNotContain $logFile error Error ERROR
    assertFileDoesNotContain $logFile warning Warning WARNING

#### Exit codes

- `1` - If the assertions fails
- `0` - If the assertion succeeds

#### Environment

If the file does not exist, this will fail.

## FileSize


#### Usage

    assertFileSize expectedSize [ fileName ... ]
    

#### Arguments



#### Examples

    assertFileSize 22 .config
    assertFileSize 0 .env

#### Exit codes

- `1` - If the assertions fails
- `0` - If the assertion succeeds

#### Environment

If the file does not exist, this will fail.

#### Usage

    assertNotFileSize expectedSize [ fileName ... ]
    

#### Arguments



#### Examples

    assertNotFileSize 22 .config
    assertNotFileSize 0 .env

#### Exit codes

- `1` - If the assertions fails
- `0` - If the assertion succeeds

#### Environment

If the file does not exist, this will fail.


#### Usage

    assertZeroFileSize [ fileName ... ]
    

#### Arguments



#### Examples

    assertZeroFileSize .config
    assertZeroFileSize /var/www/log/error.log

#### Exit codes

- `1` - If the assertions fails
- `0` - If the assertion succeeds

#### Environment

If the file does not exist, this will fail.

#### Usage

    assertNotZeroFileSize [ fileName ... ]
    

#### Arguments



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
    

#### Examples

    testPassword="$(randomString)"

#### Sample Output

    cf7861b50054e8c680a9552917b43ec2b9edae2b
    

#### Exit codes

- `0` - Always succeeds

#### Depends

    shasum, /dev/random
    

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
