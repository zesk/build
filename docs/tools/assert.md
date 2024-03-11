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

- `expected` - Expected string
- `actual` - Actual string
- `message` - Message to output if the assertion fails

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

- `expected` - Required. Expected string.
- `actual` - Required. Actual string.
- `message` - Message to output if the assertion fails. Optional.

#### Examples

    assertNotEquals "$(uname -s)" "Darwin" "Not compatible with Darwin"
    Single quote break-s

#### Exit codes

- `0` - Always succeeds

#### Review Status

File `bin/build/tools/assert.sh`, function `assertNotEquals` was reviewed 2023-11-12.

### `assertContains` - Assert one string contains another (case-sensitive)

Assert one string contains another (case-sensitive)

#### Arguments

- `needle` - Thing we are looking for
- `haystack` - Thing we are looking in

#### Exit codes

- `0` - The assertion succeeded
- `1` - Assertion failed
- `2` - Bad arguments

### `assertNotContains` - Assert one string does not contains another (case-sensitive)

Assert one string does not contains another (case-sensitive)

#### Arguments

- `needle` - Thing we are looking for
- `haystack` - Thing we are looking in

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

- `leftValue` - Value to compare on the left hand side of the comparison
- `rightValue` - Value to compare on the right hand side of the comparison
- `message` - Message to output if the assertion fails

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

- `leftValue` - Value to compare on the left hand side of the comparison
- `rightValue` - Value to compare on the right hand side of the comparison
- `message` - Message to output if the assertion fails

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

#### Usage

    assertLessThanOrEqual leftValue rightValue [ message ]
    

#### Arguments

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

- `expectedExitCode` - A numeric exit code expected from the command
- `command` - The command to run
- `arguments` - Any arguments to pass to the command to run

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

- `expectedExitCode` - A numeric exit code not expected from the command
- `command` - The command to run
- `arguments` - Any arguments to pass to the command to run

#### Exit codes

- `0` - If the process exits with a different exit code
- `1` - If the process exits with the provided exit code

#### Review Status

File `bin/build/tools/assert.sh`, function `assertNotExitCode` was reviewed 2023-11-12.

## Output 


ExitCode _bashDocumentation_Template assertOutputContains  ./docs/_templates/__function.md: 1
ExitCode _bashDocumentation_Template assertOutputDoesNotContain  ./docs/_templates/__function.md: 1

## Directory

ExitCode _bashDocumentation_Template assertDirectoryExists  ./docs/_templates/__function.md: 1
ExitCode _bashDocumentation_Template assertDirectoryDoesNotExist  ./docs/_templates/__function.md: 1

## File

ExitCode _bashDocumentation_Template assertFileExists  ./docs/_templates/__function.md: 1
ExitCode _bashDocumentation_Template assertFileDoesNotExist  ./docs/_templates/__function.md: 1

ExitCode _bashDocumentation_Template assertFileContains  ./docs/_templates/__function.md: 1
ExitCode _bashDocumentation_Template assertFileDoesNotContain  ./docs/_templates/__function.md: 1

## FileSize

ExitCode _bashDocumentation_Template assertFileSize  ./docs/_templates/__function.md: 1
ExitCode _bashDocumentation_Template assertNotFileSize  ./docs/_templates/__function.md: 1

ExitCode _bashDocumentation_Template assertZeroFileSize  ./docs/_templates/__function.md: 1
ExitCode _bashDocumentation_Template assertNotZeroFileSize  ./docs/_templates/__function.md: 1



## Random

ExitCode _bashDocumentation_Template randomString  ./docs/_templates/__function.md: 1

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
