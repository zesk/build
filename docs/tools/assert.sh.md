# Assert Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)


## `assertNotEquals` - 

Assert two strings are not equal.

If this fails it will output an error and exit.

(Located at: `./bin/build/tools/assert.sh`)

### Usage

    assertNotEquals expected actual [ message ]

### Arguments

- `expected` - Expected string
- `actual` - Actual string
- `message` - Message to output if the assertion fails

### Exit codes

- `0` - Always succeeds

### Local cache

None

### Environment

No environment dependencies or modifications.

## `assertEquals` - 

Assert two strings are equal.

If this fails it will output an error and exit.

(Located at: `./bin/build/tools/assert.sh`)

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

### Local cache

None

### Environment

No environment dependencies or modifications.

## `assertExitCode` - 

Assert a process runs and exits with the correct exit code.

If this fails it will output an error and exit.

(Located at: `./bin/build/tools/assert.sh`)

### Usage

    assertExitCode expectedExitCode command [ arguments ... ]

### Arguments

- `expectedExitCode` - A numeric exit code expected from the command
- `command` - The command to run
- `arguments` - Any arguments to pass to the command to run

### Exit codes

- `0` - Always succeeds

### Local cache

None

### Environment

No environment dependencies or modifications.

## `assertNotExitCode` - 

Assert a process runs and exits with an exit code which does not match the passed in exit code.

If this fails it will output an error and exit.

(Located at: `./bin/build/tools/assert.sh`)

### Usage

    assertNotExitCode expectedExitCode command [ arguments ... ]

### Arguments

- `expectedExitCode` - A numeric exit code not expected from the command
- `command` - The command to run
- `arguments` - Any arguments to pass to the command to run

### Exit codes

- `0` - Always succeeds

### Local cache

None

### Environment

No environment dependencies or modifications.

## `assertOutputContains` - 

Run a command and expect the output to contain the occurrence of a string.

If this fails it will output the command result to stdout.

(Located at: `./bin/build/tools/assert.sh`)

### Usage

    assertOutputContains expected command [ arguments ... ]

### Arguments

- `expected` - A string to expect in the output
- `command` - The command to run
- `arguments` - Any arguments to pass to the command to run

### Examples

    assertOutputContains Success complex-thing.sh --dry-run

### Exit codes

- `0` - Always succeeds

### Local cache

None

### Environment

No environment dependencies or modifications.

## `assertDirectoryExists` - 



(Located at: `./bin/build/tools/assert.sh`)

### Usage

    assertDirectoryExists directory [ message ... ]

### Arguments

- `directory` - Directory that should exist
- `message` - An error message if this fails

### Examples

    assertDirectoryExists "$HOME" "HOME not found"

### Exit codes

- `0` - Always succeeds

### Local cache

None

### Environment

No environment dependencies or modifications.

## `assertDirectoryDoesNotExist` - 



(Located at: `./bin/build/tools/assert.sh`)

### Usage

    assertDirectoryDoesNotExist directory [ message ... ]

### Arguments

- `directory` - Directory that should NOT exist
- `message` - An error message if this fails

### Exit codes

- `0` - Always succeeds

### Local cache

None

### Environment

No environment dependencies or modifications.

## `assertFileContains` - 



(Located at: `./bin/build/tools/assert.sh`)

### Usage

    assertFileContains fileName string0 [ ... ]

### Arguments

- `fileName` - File to search
- `string0 ...` - One or more strings which must be found on at least one line in the file

### Examples

    assertFileContains $logFile Success
    assertFileContains $logFile "is up to date"

### Exit codes

- `0` - Always succeeds

### Local cache

None

### Environment

No environment dependencies or modifications.

## `assertFileDoesNotContain` - 



(Located at: `./bin/build/tools/assert.sh`)

### Usage

    assertFileDoesNotContain fileName string0 [ ... ]

### Arguments

- `fileName` - File to search
- `string0 ...` - One or more strings which must NOT be found anywhere in `fileName`

### Examples

    assertFileDoesNotContain $logFile error Error ERROR
    assertFileDoesNotContain $logFile warning Warning WARNING

### Exit codes

- `0` - Always succeeds

### Local cache

None

### Environment

No environment dependencies or modifications.

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
